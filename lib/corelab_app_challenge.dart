import 'package:corelab_app_challenge/src/core/ui/helpers/size_extensions.dart';
import 'package:corelab_app_challenge/src/core/ui/styles/text_styles.dart';
import 'package:corelab_app_challenge/src/core/ui/theme/theme_config.dart';
import 'package:flutter/material.dart';

import 'src/pages/base/base_page.dart';

class CorelabAppChallenge extends StatelessWidget {
  const CorelabAppChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corelab',
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.theme,
      home: Stack(children: [
        const BasePage(),
        Positioned(
          right: 16,
          bottom: 16,
          child: Text(
            '${context.screenWidth.toStringAsFixed(2)} x ${context.screenHeight.toStringAsFixed(2)}',
            style: context.textStyles.textThin.copyWith(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 24),
          ),
        )
      ]),
    );
  }
}
