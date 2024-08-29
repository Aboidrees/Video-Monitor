import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutter/services.dart';


const String streamLink = 'rtmp://192.168.1.148/live/stream';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: VideoStreamPage(),
        ),
      ),
    );
  }
}

class VideoStreamPage extends StatefulWidget {
  const VideoStreamPage({super.key});

  @override
  VideoStreamPageState createState() => VideoStreamPageState();
}

class VideoStreamPageState extends State<VideoStreamPage> {
  late VlcPlayerController _vlcPlayerController;

  @override
  void initState() {
    super.initState();
      SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
      ]);
    // Initialize the VLC player controller with the stream URL
    _vlcPlayerController = VlcPlayerController.network(
      streamLink, // Replace with your stream URL
      hwAcc: HwAcc.full, // Hardware acceleration
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    _vlcPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Stream'),
      ),
      body: Center(
        child: VlcPlayer(
          controller: _vlcPlayerController,
          aspectRatio: 16 / 9,

          placeholder: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
