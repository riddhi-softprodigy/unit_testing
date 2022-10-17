import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:audioPlayer/controller/miniPlayerController.dart';
import 'package:audioPlayer/player/playerScreen.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatefulWidget {
  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  var assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    super.initState();
  }

  getSongName(path) {
    return path.split('/').last.toString().replaceAll('.mp3', '');
  }

  @override
  Widget build(BuildContext context) {
    var miniPlayerData =
        Provider.of<MusicPlayerDataProvider>(context, listen: false);

    return Consumer<MusicPlayerDataProvider>(builder: (_, genresData, child) {
      return genresData.isFromPlayer == false
          ? Container()
          : GestureDetector(
              onTap: () async {
                // await addMiniPlayerData();
                miniPlayerData.setIsFromPlayer(false);
                miniPlayerData.setIsFromMiniPlayer(true);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Player(
                        tempFile: genresData.audioName,
                        audios: genresData.audios,
                        selectedIndex: genresData.selectedIndex,
                      ),
                    ));
                //});
              },
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    shadowDarkColor: Colors.white,
                    shadowLightColorEmboss: Colors.grey[50],
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
                    depth: 8,
                    lightSource: LightSource.topLeft,
                    color: Colors.blueGrey[400]),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 74,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Image(
                                image: AssetImage('assets/images/image3.png')),
                          ),
                          Container(
                            height: 52,
                            width: MediaQuery.of(context).size.width * 0.68,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getSongName(genresData
                                      .audios[genresData.selectedIndex].path),
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Raleway Regular',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                            width: MediaQuery.of(context).size.width * 0.12,
                            child: GestureDetector(
                              onTap: () async {
                                await genresData.assetsAudioPlayer
                                    .playOrPause();
                                setState(() {});
                              },
                              child: Icon(
                                genresData.assetsAudioPlayer.isPlaying.value
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                size: 34.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
