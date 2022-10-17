import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class MusicPlayerDataProvider extends ChangeNotifier {
  bool isFromPlayer = false;
  bool isFromMiniPlayer = false;
  List<Audio> audios = [];
  AssetsAudioPlayer assetsAudioPlayer;
  int selectedIndex;
  String audioName;
  void addData(
      bool isFromPlayer,
      bool isFromminiPlayer,
      List<Audio> audios,
      AssetsAudioPlayer assetsAudioPlayer,
      int selectedIndex,
      String audioName) {
    this.isFromPlayer = isFromPlayer;
    this.assetsAudioPlayer = assetsAudioPlayer;
    this.selectedIndex = selectedIndex;
    this.audioName = audioName;
    this.audios = audios;
    this.isFromMiniPlayer = isFromMiniPlayer;
    MusicPlayerdata.value = isFromMiniPlayer;
    notifyListeners();
  }

  void setIsFromPlayer(bool isFromPlayer) {
    this.isFromPlayer = isFromPlayer;
    notifyListeners();
  }

  void setIsFromMiniPlayer(bool isFromMiniPlayer) {
    this.isFromMiniPlayer = isFromMiniPlayer;
  }

  // void setIsFromPlayerHome(bool isFromPlayerHome) {
  //   this.isFromPlayerHome = isFromPlayerHome;
  // }

  // void setisMiniPlayerFirstTime(bool isMiniPlayerFirstTime) {
  //   this.isMiniPlayerFirstTime = isMiniPlayerFirstTime;
  // }

  // void setisViewallMiniPlayerFirstTime(bool isViewAllMiniPlayerFirstTime) {
  //   this.isViewAllMiniPlayerFirstTime = isViewAllMiniPlayerFirstTime;
  // }

  void setIsPlaying(AssetsAudioPlayer audioPlayer) {
    this.assetsAudioPlayer = audioPlayer;
    notifyListeners();
  }

  void setSelectedPos(int pos) {
    this.selectedIndex = pos;
    notifyListeners();
  }

  // void setIsTimerStarted(bool isTimeStarted) {
  //   this.isTimerStarted = isTimeStarted;
  // }
}

class MusicPlayerdata {
  static bool value;
  static bool getData() {
    return true;
  }
}
