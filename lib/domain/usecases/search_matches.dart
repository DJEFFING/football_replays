import 'package:football_replays/domain/entities/match_entity.dart';

class SearchMatches{
  List call(List<MatchEntity> matches, String query){
    if(query.isEmpty) return matches;

    return matches.where((match){
      return match.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}