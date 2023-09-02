import 'package:corelab_app_challenge/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

class AppbarSearchable extends StatefulWidget {
  final HomeController controller;
  final double appSize;
  final GestureTapCallback? backButton;
  const AppbarSearchable(this.controller, this.appSize,
      {required this.backButton, super.key});

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
              ),
            ),
          ],
        );
      },
    );
  }
}
