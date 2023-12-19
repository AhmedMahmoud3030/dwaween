import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class audioplayerx extends StatefulWidget {
  const audioplayerx({super.key});

  @override
  State<audioplayerx> createState() => _audioplayerxState();
}

class _audioplayerxState extends State<audioplayerx> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer()..setAsset('assets/tone.mp3');
  }

  void dispose() {
    _audioPlayer.dispose(); 
    super.dispose();
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _audioPlayer.positionStream,
      builder: (context, snapshot) {
        // final processingState = playerState?.processingState;
        // final playing = playerState?.playing;
        return IconButton(
          onPressed: _audioPlayer.play,
          icon: const Icon(Icons.play_arrow),
        );
      },
    );
  }
}
