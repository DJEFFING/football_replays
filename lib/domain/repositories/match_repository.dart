import 'package:football_replays/domain/entities/match_entity.dart';

abstract class MatchRepository{
  Future<List<MatchEntity>> getRecentMatches();
}