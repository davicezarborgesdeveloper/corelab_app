import 'package:corelab_app_challenge/src/core/ui/styles/colors_app.dart';
import 'package:corelab_app_challenge/src/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../home_controller.dart';
import '../components/search_result_tile.dart';

class SearchDialog extends StatefulWidget {
  final HomeController controller;
  final double appSize;
  const SearchDialog(this.controller, this.appSize, {super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final searchEC = TextEditingController();

  @override
  void dispose() {
    searchEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: widget.appSize,
        title: Observer(
          builder: (_) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: searchEC,
                autofocus: true,
                onChanged: (value) {
                  widget.controller.filter(value);
                },
                decoration: InputDecoration(
                  suffixIcon: widget.controller.filterQuery != null &&
                          widget.controller.filterQuery!.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            searchEC.text = '';
                            widget.controller.filter('');
                          },
                        )
                      : null,
                ),
              ),
            );
          },
        ),
      ),
      body: Observer(builder: (_) {
        //Titulo, Descrição, preço ou catégoria
        var resultsCount = widget.controller.products.length;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, top: 24, bottom: 14),
              color: ColorsApp.i.background,
              child: Text(
                '$resultsCount ${resultsCount == 1 ? 'resultado encontrado' : 'resultados encontrados'}',
                style: context.textStyles.textMedium
                    .copyWith(color: ColorsApp.i.textPrimary, fontSize: 16),
              ),
            ),
            Expanded(
                child: ListView.separated(
                    itemBuilder: (_, index) =>
                        SearchResultTile(widget.controller.products[index]),
                    separatorBuilder: (_, index) =>
                        const Divider(color: Colors.grey, height: 1),
                    itemCount: widget.controller.products.length)),
          ],
        );
      }),
    );
  }
}
