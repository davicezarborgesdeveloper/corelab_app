import 'dart:developer';

import 'package:corelab_app_challenge/src/core/exceptions/repository_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './suggestion_service.dart';

class SuggestionServiceImpl implements SuggestionService {
  @override
  Future<List<String>?> getSuggestions() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      return sp.getStringList('suggestions');
    } catch (e, s) {
      log('Erro ao buscar sugestões', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar sugestões');
    }
  }

  @override
  Future<void> saveSuggestion(List<String> suggestions) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setStringList('suggestions', suggestions);
    } catch (e, s) {
      log('Erro ao salvar sugestão', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar sugestão');
    }
  }

  @override
  Future<void> suggestionClean() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.clear();
    } catch (e, s) {
      log('Erro limpar sugestoes', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro limpar sugestoe');
    }
  }
}
