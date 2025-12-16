class MatchEntity {
  final String id;
  final String title;
  final String competition;
  final String matchviewUrl;
  final String competitionUrl;
  final String thumbnail;
  final String date;
  final List<Video> videos;

  MatchEntity({required this.id, 
  required this.title,
  required this.competition,
  required this.matchviewUrl,
  required this.competitionUrl,
  required this.thumbnail,
  required this.date,
  required this.videos});

}

class Video {
  final String id;
  final String title;
  final String embed;

  Video({required this.id, required this.title, required this.embed});

  // AJOUTE CETTE MÉTHODE
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      embed: json['embed']?.toString() ?? '',
    );
  }
}