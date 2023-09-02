import 'package:corelab_app_challenge/src/core/ui/helpers/size_extensions.dart';
import 'package:corelab_app_challenge/src/core/ui/styles/colors_app.dart';
import 'package:corelab_app_challenge/src/core/ui/styles/text_styles.dart';
import 'package:corelab_app_challenge/src/pages/home/components/appbar/appbar_no_search.dart';
import 'package:corelab_app_challenge/src/pages/home/components/appbar/appbar_searchable.dart';
import 'package:corelab_app_challenge/src/pages/home/components/search_date_tile.dart';
import 'package:corelab_app_challenge/src/pages/home/components/suggestion_tile.dart';
import 'package:corelab_app_challenge/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/message.dart';
import 'widgets/search_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  final HomeController controller = HomeController();
  late final ReactionDisposer statusDisposer;
  final focusSearch = FocusNode();
  bool enableSearch = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      statusDisposer = reaction((_) => controller.status, (status) async {
        switch (status) {
          case HomeStateStatus.initial:
            break;
          case HomeStateStatus.loading:
            showLoader();
            break;
          case HomeStateStatus.loadingSuggestion:
            showLoader();
            break;
          case HomeStateStatus.loaded:
            hideLoader();
            break;
          case HomeStateStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? 'Erro');
            break;
        }
      });
      controller.loadProducts();
    });
    super.initState();
    // _searchDelegate = SearchAppBarDelegate(kWords);
  }

  @override
  void dispose() {
    statusDisposer();
    focusSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double appBarSize =
        context.appbarHeight < 80.0 ? 80.0 : context.appbarHeight;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: appBarSize,
        title: Observer(
            builder: (_) => controller.searchable
                ? AppbarSearchable(controller, appBarSize,
                    backButton: () => controller.setSearchable(false))
                : AppbarNoSearch(
                    appBarSize,
                    onTap: () async {
                      controller.setSearchable(true);
                      await controller.loadSuggestions();
                    },
                  )),
      ),
      body: Observer(
        builder: (_) => controller.searchable
            ? ListView.builder(
                itemCount: controller.suggestions.length,
                itemBuilder: (_, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 6),
                          child: Text(
                            'Pesquisas recentes',
                            style: context.textStyles.textMedium.copyWith(
                                fontSize: 16, color: ColorsApp.i.textPrimary),
                          ),
                        ),
                        SuggestionTile(),
                      ],
                    );
                  }
                  return SuggestionTile();
                },
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  DateTime date =
                      controller.groupProducts.keys.elementAt(index);
                  List itemsInDate = controller.groupProducts[date]!;
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 24),
                          color: ColorsApp.i.background,
                          child: Text(
                            'Últimos anúncios',
                            style: context.textStyles.textMedium.copyWith(
                                color: ColorsApp.i.textPrimary, fontSize: 20),
                          ),
                        ),
                        SearchDateTile(title: date, items: itemsInDate)
                      ],
                    );
                  }
                  return SearchDateTile(title: date, items: itemsInDate);
                },
                itemCount: controller.groupProducts.length,
              ),
      ),
    );
  }

  void showSearchPage(double appSize) async {
    showDialog(
        context: context, builder: (_) => SearchDialog(controller, appSize));
  }

  // void showSearchPage(
  //     BuildContext context, SearchAppBarDelegate searchDelegate) async {
  //   final String? selected = await showSearch<String>(
  //     context: context,
  //     delegate: searchDelegate,
  //   );

  //   if (selected != null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Your Word Choice: $selected'),
  //       ),
  //     );
  //   }
  // }
}
