import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:audioPlayer/controller/miniPlayerController.dart';
import 'package:audioPlayer/player/miniPlayer.dart';
import 'package:audioPlayer/player/playerScreen.dart';
import 'package:audioPlayer/utils.dart';
import 'package:provider/provider.dart';

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();

  SongList({
    Key key,
    this.currentAudioFile,
  }) : super(key: key);
  final String currentAudioFile;
}

class _SongListState extends State<SongList> {
  bool loadingCarousel = true;
  final List<Audio> audios = [];
  void initState() {
    getSongList();
    // TODO: implement initState
    super.initState();
  }

  getSongName(path) {
    return path.split('/').last.toString().replaceAll('.mp3', '');
  }

  getSongList() {
    for (int i = 0; i < songList.length; i++) {
      audios.add(
        Audio(
          songList[i],
          metas: Metas(
            id: getSongName(songList[i]),
            title: getSongName(songList[i]),
            artist: 'Florent Champigny',
            album: 'RockAlbum',
            image: MetasImage.network(
                'https://static.radio.fr/images/broadcasts/cb/ef/2075/c300.png'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // var miniPlayerData =
    //     Provider.of<MusicPlayerDataProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text('Song List'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: songList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            shadowDarkColor: Colors.grey,
                            shadowLightColorEmboss: Colors.grey[50],
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(5)),
                            depth: 8,
                            lightSource: LightSource.topLeft,
                            color: Colors.white70),
                        child: ListTile(
                          title: Wrap(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Image(
                                    image:
                                        AssetImage('assets/images/image3.png')),
                              ),
                              Text(
                                getSongName(songList[index]),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                          onTap: () {
                            // if (miniPlayerData.selectedIndex == index) {
                            //   miniPlayerData.setIsFromMiniPlayer(true);
                            // }
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) => Player(
                                  tempFile: songList[index],
                                  audios: audios,
                                  selectedIndex: index,
                                ),
                              ),
                            );
                          },
                        )),
                  );
                }),
          ),
          // Positioned(bottom: 0, child: MiniPlayer()),
        ],
      ),
    );
  }
}
