import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String htmlString;
  const VideoPlayerWidget({super.key, required this.htmlString});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
static final RegExp _videoSrcRegex = RegExp(r'src=["' r"']([^" r'"' r"']+)[" r"']");

  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    final videoUrl = _extractVideoUrl(widget.htmlString);

    if (videoUrl != null) {
      // Initialisation si l'URL est trouvée
      // ignore: deprecated_member_use
      _controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {});
          _controller?.play(); // Utilisation de ?. pour la sécurité
        });
    } else {
      // Optionnel: Gérer le cas où l'URL n'est pas trouvée
      // Le _controller reste null. Vous pouvez initialiser un contrôleur vide
      // ou simplement le laisser null et gérer le cas dans build().
    }
  }

  @override
  void dispose() {
    // Appel sécurisé de dispose uniquement si le contrôleur existe
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Si _controller est null ou non initialisé, afficher le CircularProgressIndicator
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    // Afficher la vidéo si le contrôleur est initialisé
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lecteur Vidéo"),
      ),
      body: Center( // Centrez le lecteur vidéo
        child: AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        ),
      ),
    );
  }

  /// Fonction pour extraire l'URL de la vidéo à partir de la chaîne HTML
  String? _extractVideoUrl(String htmlString) {
    // Utilise la variable statique
    final match = _videoSrcRegex.firstMatch(htmlString);
    print(match?.group(1));
    return match?.group(1);
  }
}