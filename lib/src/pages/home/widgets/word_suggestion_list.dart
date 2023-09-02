import 'package:flutter/material.dart';

class WordSuggestionList extends StatelessWidget {
  final List<String>? suggestions;
  final String? query;
  final ValueChanged<String>? onSelected;
  const WordSuggestionList({this.suggestions, this.query, this.onSelected});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.displaySmall;
    return ListView.builder(
        itemCount: suggestions?.length,
        itemBuilder: (BuildContext context, int i) {
          final String suggestion = suggestions![i];
          return ListTile(
            leading: query!.isEmpty ? Icon(Icons.history) : Icon(null),
            title: RichText(
              text: TextSpan(
                text: suggestion.substring(0, query!.length),
                style: textTheme!.copyWith(fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: suggestion.substring(query!.length),
                    style: textTheme,
                  ),
                ],
              ),
            ),
            onTap: () {
              onSelected!(suggestion);
            },
          );
        });
  }
}
