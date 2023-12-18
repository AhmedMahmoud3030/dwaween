import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioCard extends StatefulWidget {
  const AudioCard({super.key});

  @override
  State<AudioCard> createState() => _AudioCardState();
}

bool p = false;

class _AudioCardState extends State<AudioCard> {
  late AudioPlayer _audioPlayer;
  Stream<PositionData> get _postionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
                position,
                bufferedPosition,
                duration ?? Duration.zero,
              ));

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer()..setAsset('assets/tone10.mp3');
  }

  Future<void> dispose() async {
    super.dispose();
    _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder<PositionData>(
      stream: _postionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.all(10),
          // color: Colors.transparent,
          // shadowColor: Colors.blueGrey,
          // elevation: 10,
          child: SizedBox(
            height: height / 4.1,
            width: width,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "assets/img/banner.png",
                  height: height / 4.1,
                  width: width,
                  fit: BoxFit.fill,
                ),
                Container(
                    child: Column(
                  children: [
                    Container(
                      height: 75,
                      width: 380,
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Container(
                              width: 250,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 20,
                                ),
                                Text(
                                  "صوت القصيدة",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri Regular"),
                                ),
                                Text(
                                  " ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: IconButton(
                              onPressed: () {
                                if (p == false) {
                                  _audioPlayer.play();
                                  p = true;
                                } else {
                                  _audioPlayer.pause();
                                  p = false;
                                }
                              },
                              icon: !p
                                  ? SvgPicture.asset("assets/img/ic_play.svg")
                                  : SvgPicture.asset(
                                      "assets/img/ic_pause.svg")),
                        ),
                        SizedBox(
                          width: 250,
                          child: SizedBox(
                            width: 75,
                            child: ProgressBar(
                              barHeight: 8,
                              baseBarColor: Colors.grey[600],
                              bufferedBarColor: Colors.grey,
                              progressBarColor: Colors.teal[600],
                              thumbColor: Colors.teal[600],
                              timeLabelTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              progress: positionData?.position ?? Duration.zero,
                              buffered: positionData?.bufferedPosition ??
                                  Duration.zero,
                              total: positionData?.duration ?? Duration.zero,
                              onSeek: _audioPlayer.seek,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              width: 60,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
}
