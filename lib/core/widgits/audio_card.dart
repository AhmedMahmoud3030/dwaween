import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:easy_localization/easy_localization.dart';
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
        return Container(
          decoration: BoxDecoration(
              color: Color(0xff51DECF),
              borderRadius: BorderRadius.circular(10)),
          height: height / 4.06,
          width: width * .92,
          child: Stack(
            children: <Widget>[
              Image.asset(
                "assets/images/paintings/banner.png",
                height: height / 4.1,
                width: width,
                fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Audible_poems".tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              " مدح الرسول صلى الله عليه وسلم",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Cairo"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Visibility(
                            visible: p,
                            child: ProgressBar(
                              barHeight: 2,
                              baseBarColor: Colors.grey[600],
                              bufferedBarColor: Colors.white,
                              progressBarColor: Colors.teal[600],
                              thumbColor: Colors.white,
                              thumbGlowRadius: 8,
                              thumbGlowColor: Colors.teal[600],
                              thumbRadius: 5,
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
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            "الشيخ إبراهيم إنياس",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
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
                              ? SvgPicture.asset(
                                  "assets/images/icons/ic_play.svg",
                                  width: 40,
                                  height: 40,
                                )
                              : SvgPicture.asset(
                                  "assets/images/icons/ic_pause.svg",
                                  width: 40,
                                  height: 40,
                                ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
