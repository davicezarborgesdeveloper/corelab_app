import 'package:corelab_app_challenge/src/core/ui/helpers/size_extensions.dart';
import 'package:corelab_app_challenge/src/core/ui/styles/colors_app.dart';
import 'package:corelab_app_challenge/src/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ResultNotFound extends StatelessWidget {
  const ResultNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 80),
        SizedBox(
          width: context.percentWidth(.63),
          child: Image.asset('assets/images/rafiki.png'),
        ),
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: context.percentWidth(.946),
            child: Text(
              'Resultado não encontrado',
              style: context.textStyles.textMedium
                  .copyWith(color: ColorsApp.i.textPrimary, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: SizedBox(
            width: context.percentWidth(.946),
            child: Text(
              'Não encontramos nenhum resultado parecido com "chinelo".',
              style: context.textStyles.textMedium
                  .copyWith(color: ColorsApp.i.textTernary, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
//355/375