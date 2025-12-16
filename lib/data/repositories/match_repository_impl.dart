import 'package:football_replays/data/datasources/score_bat_api.dart';
import 'package:football_replays/domain/entities/match_entity.dart';
import 'package:football_replays/domain/repositories/match_repository.dart';

class MatchRepositoryImpl  implements MatchRepository{
  final ScoreBatApi api;
  MatchRepositoryImpl(this.api);

  @override
  Future<List<MatchEntity>> getRecentMatches() async {
    final matchModels = await api.fetchMatches();
    return matchModels;
  }

}