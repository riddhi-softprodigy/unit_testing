import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioPlayer/controller/miniPlayerController.dart';
import 'package:audioPlayer/player/positionSeekBar.dart';
import 'package:audioPlayer/widget/buttonWidget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();

  Player({Key key, this.tempFile, this.audios, this.selectedIndex})
      : super(key: key);
  final String tempFile;
  int selectedIndex;
  final List<Audio> audios;
}

class _PlayerState extends State<Player> {
  var assetsAudioPlayer = AssetsAudioPlayer.withId("0");
  var loopMode = LoopMode.playlist;
  var miniPlayerData;
  @override
  void initState() {
    playSong();
    // TODO: implement initState
    super.initState();
  }

  playSong() async {
    miniPlayerData =
        Provider.of<MusicPlayerDataProvider>(context, listen: false);
    if (miniPlayerData.isFromMiniPlayer == true) {
      miniPlayerData.setIsFromMiniPlayer(false);
      setState(() {});
    } else {
      await assetsAudioPlayer.open(
          // Audio.file(widget.tempFile.path),
          Playlist(audios: widget.audios, startIndex: widget.selectedIndex),
          loopMode: loopMode,
          autoStart: true,
          playInBackground: PlayInBackground.enabled,
          showNotification: true,
          audioFocusStrategy: AudioFocusStrategy.request(
              resumeAfterInterruption: true,
              resumeOthersPlayersAfterDone: true),
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
          notificationSettings: NotificationSettings(
            nextEnabled: true,
            customNextAction: (next) {
              assetsAudioPlayer.next();
            },
            prevEnabled: true,
            customPrevAction: (previous) {
              assetsAudioPlayer.previous(); //  _controller.previousPage();
            },
            playPauseEnabled: true,
            customPlayPauseAction: (pause) {
              if (assetsAudioPlayer.current.hasValue == true) {
                assetsAudioPlayer.playOrPause();
              }
            },
          ));
      setState(() {});
    }

    assetsAudioPlayer.playlistAudioFinished.listen((Playing playing) async {
      if (widget.selectedIndex < widget.audios.length - 1) {
        await miniPlayerData.setSelectedPos(widget.selectedIndex + 1);
        // await assetsAudioPlayer.play();
        print("data from player screen");
        print(assetsAudioPlayer.isPlaying.value);
        Timer(Duration(seconds: 1), () async {
          await miniPlayerData.setIsPlaying(assetsAudioPlayer);
        });

        widget.selectedIndex = widget.selectedIndex + 1;

        if (mounted) setState(() {});
      } else {
        await miniPlayerData.setSelectedPos(0);
        Timer(Duration(seconds: 1), () async {
          await miniPlayerData.setIsPlaying(assetsAudioPlayer);
        });

        widget.selectedIndex = 0;

        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      body: Container(
        // color: const Color(0x42000000),
        child: ListView(
          children: [backButton(), audioControllers()],
        ),
      ),
    );
  }

  Widget backButton() => Container(
        margin: EdgeInsets.fromLTRB(
            15, MediaQuery.of(context).size.height * 0.04, 0, 0),
        alignment: Alignment.topLeft,
        child: BubbleMusicOptionButton(
            backgroundColor: Theme.of(context).backgroundColor,
            size: 45,
            outsideICon: true,
            textSelectionColor: Theme.of(context).hoverColor,
            icon: Icons.arrow_back,
            color: Colors.white,
            iconSize: 20,
            action: () {
              addMiniPlayerData(widget.selectedIndex,
                  getSongName(widget.audios[widget.selectedIndex].path));
              Navigator.pop(context);
            }),
      );

  void addMiniPlayerData(selectedIndex, audioName) {
    var miniPlayerData =
        Provider.of<MusicPlayerDataProvider>(context, listen: false);
    miniPlayerData.addData(true, false, widget.audios, assetsAudioPlayer,
        selectedIndex, audioName);
  }

  Widget SeekBarWidget(RealtimePlayingInfos infos) {
    return PositionSeekWidget(
      currentPosition: infos.currentPosition,
      duration: infos.duration,
      seekTo: (to) {
        assetsAudioPlayer.seek(to);
      },
      nextSong: playPause,
      isMainPlayer: true,
    );
  }

  void playPause() {
    assetsAudioPlayer.playOrPause();
  }

  getSongName(path) {
    return path.split('/').last.toString().replaceAll('.mp3', '');
  }

  Widget audioControllers() =>
      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          width: MediaQuery.of(context).size.width * 1,
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Image(image: AssetImage('assets/images/image3.png')),
        ),
        Text(
          getSongName(widget.audios[widget.selectedIndex].path),
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: assetsAudioPlayer.builderRealtimePlayingInfos(
              builder: (context, RealtimePlayingInfos infos) {
            if (infos == null) {
              return Container(
                color: Colors.blue,
              );
            }
            return Column(
              children: [SeekBarWidget(infos)],
            );
          }),
        ),
        new Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BubbleMusicOptionButton(
                backgroundColor: Theme.of(context).backgroundColor,
                size: 45,
                outsideICon: true,
                textSelectionColor: Theme.of(context).hoverColor,
                icon: Icons.skip_previous,
                color: Colors.white,
                iconSize: 30,
                action: () async {
                  if (widget.selectedIndex > 0) {
                    await assetsAudioPlayer
                        .playlistPlayAtIndex(widget.selectedIndex);

                    await assetsAudioPlayer.previous();
                    print(assetsAudioPlayer.current.value.index);
                    setState(() {
                      widget.selectedIndex =
                          assetsAudioPlayer.current.value.index;
                    });
                  }
                },
              ),
              SizedBox(
                width: 50,
              ),
              BubbleMusicOptionButton(
                backgroundColor: Theme.of(context).backgroundColor,
                size: 55,
                outsideICon: true,
                textSelectionColor: Theme.of(context).hoverColor,
                icon: assetsAudioPlayer.isPlaying.value
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                color: Colors.white,
                iconSize: 40,
                action: () {
                  setState(() {
                    if (assetsAudioPlayer.isPlaying.value == true) {
                      assetsAudioPlayer.playOrPause();
                    } else {
                      assetsAudioPlayer.playOrPause();
                    }
                  });
                },
              ),
              SizedBox(
                width: 50,
              ),
              BubbleMusicOptionButton(
                backgroundColor: Theme.of(context).backgroundColor,
                size: 45,
                outsideICon: true,
                textSelectionColor: Theme.of(context).hoverColor,
                icon: Icons.skip_next_rounded,
                color: Colors.white,
                iconSize: 30,
                action: () async {
                  // await assetsAudioPlayer.playlistPlayAtIndex(0);
                  await assetsAudioPlayer.next();
                  print(assetsAudioPlayer.current.value.index);
                  setState(() {
                    widget.selectedIndex =
                        assetsAudioPlayer.current.value.index;
                  });
                },
              ),
            ],
          ),
        ),
      ]);

  @override
  void dispose() {
    // assetsAudioPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
