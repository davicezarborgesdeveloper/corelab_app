import 'package:corelab_app_challenge/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

class AppbarSearchable extends StatefulWidget {
  final HomeController controller;
  final double appSize;
  final GestureTapCallback? backButton;
  final ValueChanged<String>? searchSubmitted;
  const AppbarSearchable(
    this.controller,
    this.appSize, {
    required this.backButton,
    this.searchSubmitted,
    super.key,
  });

  @override
  State<AppbarSearchable> createState() => _AppbarSearchableState();
}

class _AppbarSearchableState extends State<AppbarSearchable> {
  final searchEC = TextEditingController();

  @override
  void dispose() {
    searchEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Row(
          children: [
            IconButton(
                onPressed: widget.backButton,
                icon: const Icon(Icons.arrow_back)),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: searchEC,
                  autofocus: true,
                  // onChanged: widget.searchChange,
                  onFieldSubmitted: widget.searchSubmitted,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    suffixIcon: widget.controller.filterQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              searchEC.text = '';
                              widget.controller
                                  .filter('', [false, false, false, false]);
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ),
            // if (widget.controller.filterQuery.isNotEmpty)
            //   Container(
            //     color: Colors.amber,
            //     child: TextButton(
            //       onPressed: () {},
            //       child: Text(
            //         'Filtros',
            //         style: context.textStyles.textBold
            //             .copyWith(color: Colors.white, fontSize: 14),
            //       ),
            //     ),
            //   ),
          ],
        );
      },
    );
  }
}
