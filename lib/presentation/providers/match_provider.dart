import 'package:flutter/material.dart';
import 'package:football_replays/domain/entities/match_entity.dart';
import 'package:football_replays/domain/usecases/get_Match.dart';
import 'package:football_replays/domain/usecases/search_matches.dart';

class MatchProvider extends ChangeNotifier{
  final GetMatches getMatchesUseCase;
  final SearchMatches searchMatchesUseCase;

  List<MatchEntity> _matches = [];
  List _filtedMatches = [];
  bool _isLoading = false;
  String? _errorMessage;

  List get filterMatches => _filtedMatches;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  MatchProvider({
    required this.getMatchesUseCase, 
    required this.searchMatchesUseCase
  });

  Future loadMatches () async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try{
      _matches = await getMatchesUseCase();
      _filtedMatches = _matches;
      _isLoading = false;
      notifyListeners();

    }catch(e){
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchMatches(String query){
    _filtedMatches = searchMatchesUseCase(_matches,query);
    notifyListeners();
  }

}