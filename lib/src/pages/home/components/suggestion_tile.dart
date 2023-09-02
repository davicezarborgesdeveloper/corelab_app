import 'package:corelab_app_challenge/src/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../core/ui/styles/colors_app.dart';

class SuggestionTile extends StatelessWidget {
  const SuggestionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Row(
          children: [
            Icon(
              Icons.history,
              size: 24,
              color: ColorsApp.i.secondary,
            ),
            const SizedBox(width: 14),
            Text(
              'Ortodontia',
              style: context.textStyles.textRegular
                  .copyWith(color: ColorsApp.i.textTernary, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
