import 'package:corelab_app_challenge/src/services/suggestion/suggestion_service_impl.dart';

abstract interface class SuggestionService {
  Future<void> saveSuggestion(String suggestion);
  Future<List<String>?> getSuggestions();
  Future<void> suggestionClean();

  factory SuggestionService() {
    return SuggestionServiceImpl();
  }
}
