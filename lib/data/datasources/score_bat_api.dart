import 'package:dio/dio.dart';
import 'package:football_replays/const/Api_const.dart';
import 'package:football_replays/data/models/match_model.dart';

class ScoreBatApi {
  Future<List<MatchModel>> fetchMatches() async {
    final String url = '${ApiConst.baseUrl}/?token=${ApiConst.token}';
    final dio = Dio();
    
    try {
      final response = await dio.get(url);
      
      if (response.statusCode == 200) {
        // L'API retourne un objet avec une clé "response"
        final Map<String, dynamic> jsonResponse = response.data;
        final List<dynamic> jsonData = jsonResponse['response'];
        
        // Debug: affiche le premier élément
        if (jsonData.isNotEmpty) {
          print('PREMIER MATCH: ${jsonData[0]}');
        }
        
        return jsonData.map((json) => MatchModel.fromJson(json)).toList();
      } else {
        throw Exception('Erreur lors du chargement des matchs');
      }
    } catch (e) {
      print('ERREUR DÉTAILLÉE: $e');
      throw Exception('Erreur de connexion: $e');
    }
  }
}