import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class Audiobar extends StatefulWidget {
  const Audiobar({super.key});

  @override
  State<Audiobar> createState() => _AudiobarState();
}

bool p = false;

class _AudiobarState extends State<Audiobar> {
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

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
      stream: _postionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return SafeArea(
          child: Container(
            height: 125,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 27, 161, 134),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 50,
                      child: IconButton(
                        icon: SvgPicture.asset("assets/img/ic_mnshed.svg"),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                padding: EdgeInsets.all(16),
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "المفضلة",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontFamily: "Amiri Regular"),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "أضف ملاحظة",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontFamily: "Amiri Regular"),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 35.0,
                                          height: 35.0,
                                          child: const DecoratedBox(
                                            decoration: const BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 35.0,
                                          height: 35.0,
                                          child: const DecoratedBox(
                                            decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 35.0,
                                          height: 35.0,
                                          child: const DecoratedBox(
                                            decoration: const BoxDecoration(
                                                color: Colors.teal,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 35.0,
                                          height: 35.0,
                                          child: const DecoratedBox(
                                            decoration: const BoxDecoration(
                                                color: Colors.black,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "لون الخط",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontFamily: "Amiri Regular"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 35.0,
                                          height: 35.0,
                                          child: const DecoratedBox(
                                            decoration: const BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 35.0,
                                          height: 35.0,
                                          child: const DecoratedBox(
                                            decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 35.0,
                                          height: 35.0,
                                          child: const DecoratedBox(
                                            decoration: const BoxDecoration(
                                                color: Colors.teal,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 35.0,
                                          height: 35.0,
                                          child: const DecoratedBox(
                                            decoration: const BoxDecoration(
                                                color: Colors.black,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "لون الخلفية",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontFamily: "Amiri Regular"),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.white,
                              elevation: 0,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 300,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "صوت القصيدة أبرق بدا نحو المرابع يلمع",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Amiri Regular"),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 25,
                      width: 350,
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
                        buffered:
                            positionData?.bufferedPosition ?? Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        onSeek: _audioPlayer.seek,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 55,
                      width: 55,
                      child: IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Container(
                                  padding: EdgeInsets.all(16),
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                            );
                          },
                          icon: SvgPicture.asset("assets/img/ic_downlod.svg")),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: IconButton(
                          onPressed: () {
                            _audioPlayer.seek(Duration(
                                seconds: _audioPlayer.position.inSeconds - 60));
                          },
                          icon: SvgPicture.asset("assets/img/ic_pspeed.svg")),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: IconButton(
                          onPressed: () {
                            _audioPlayer.seek(Duration(
                                seconds: _audioPlayer.position.inSeconds - 10));
                          },
                          icon: SvgPicture.asset("assets/img/ic_p.svg")),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
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
                              : SvgPicture.asset("assets/img/ic_pause.svg")),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: IconButton(
                          onPressed: () {
                            _audioPlayer.seek(Duration(
                                seconds: _audioPlayer.position.inSeconds + 10));
                          },
                          icon: SvgPicture.asset("assets/img/ic_next.svg")),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: IconButton(
                          onPressed: () {
                            _audioPlayer.seek(Duration(
                                seconds: _audioPlayer.position.inSeconds + 60));
                          },
                          icon: SvgPicture.asset("assets/img/ic_nspeed.svg")),
                    ),
                    SizedBox(
                      height: 55,
                      width: 55,
                      child: IconButton(
                          onPressed: () {
                            _audioPlayer.speed;
                          },
                          icon: SvgPicture.asset("assets/img/ic_repeat.svg")),
                    ),
                  ],
                ),
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
