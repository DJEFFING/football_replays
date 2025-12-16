import 'package:football_replays/domain/entities/match_entity.dart';
import 'package:football_replays/domain/repositories/match_repository.dart';

class GetMatches{
  final MatchRepository repository;

  GetMatches(this.repository);

  Future<List<MatchEntity>> call() async{
    return await repository.getRecentMatches();
  }

}