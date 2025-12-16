import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoWebViewWidget extends StatefulWidget {
  final String htmlString;
  
  const VideoWebViewWidget({super.key, required this.htmlString});

  @override
  State<VideoWebViewWidget> createState() => _VideoWebViewWidgetState();
}

class _VideoWebViewWidgetState extends State<VideoWebViewWidget> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
        ),
      )
      ..loadHtmlString(_createFullHtml());
  }

  String _createFullHtml() {
    return '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
          }
          html, body {
            width: 100%;
            height: 100%;
            background: #000;
            overflow: hidden;
          }
          div, iframe {
            width: 100% !important;
            height: 100% !important;
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
            border: none !important;
          }
        </style>
      </head>
      <body>
        ${widget.htmlString}
      </body>
      </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    // PLUS DE SCAFFOLD ICI - juste le contenu
    return AspectRatio(
      aspectRatio: 16 / 9, // Format vidéo standard
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}