import 'package:football_replays/domain/entities/match_entity.dart';

class MatchModel extends MatchEntity {
  MatchModel(
      {required super.id,
      required super.title,
      required super.competition,
      required super.matchviewUrl,
      required super.competitionUrl,
      required super.thumbnail,
      required super.date,
      required super.videos});

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    
     // Parser la liste des vidéos
    List<Video> videosList = [];
    if (json['videos'] != null && json['videos'] is List) {
      videosList = (json['videos'] as List)
          .map((videoJson) => Video.fromJson(videoJson as Map<String, dynamic>))
          .toList();
    }
    
    return MatchModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        competition: json['competition'] ?? '',
        matchviewUrl: json['matchviewUrl'] ?? '',
        competitionUrl: json['competitionUrl'] ?? '',
        thumbnail: json['thumbnail'] ?? '',
        date: json['date'] ?? '',
        videos: videosList);
  }
}
