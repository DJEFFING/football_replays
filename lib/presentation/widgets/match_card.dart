import 'package:flutter/material.dart';
import 'package:football_replays/presentation/pages/match_detail.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/match_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MatchCard extends StatelessWidget {
  final MatchEntity match;
  final VoidCallback? onTap;

  const MatchCard({
    super.key,
    required this.match,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              // IMAGE (temporaire pour test)
              // Dans ton MatchCard
              CachedNetworkImage(
                imageUrl: match.thumbnail,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sports_soccer,
                          size: 50, color: Colors.grey[600]),
                      SizedBox(height: 8),
                      Text('Image non disponible',
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // TITRE
              Text(
                match.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              // COMPÉTITION
              Text(
                match.competition,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              // DATE formatée
              Text(
                _formatDate(match.date),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 14),

              // BOUTON "VOIR +"
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: (){
                    print("la lien de la vidéo ${match.videos[0].embed}");
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>MatchDetailPage(match: match)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "voir +",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Formatage de la date : "24 novembre 2025 à 15:00"
  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat("d MMMM yyyy 'à' HH:mm", "fr_FR").format(date);
    } catch (e) {
      return dateStr; // au cas où la date serait invalide
    }
  }
}
