import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;
  final Function nextSong;
  final bool isMainPlayer;

  PositionSeekWidget({
    @required this.currentPosition,
    @required this.duration,
    @required this.seekTo,
    @required this.nextSong,
    @required this.isMainPlayer,
  });

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  Duration _visibleValue;
  bool listenOnlyUserInterraction = false;

  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (durationToString(widget.currentPosition) == '00:30') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.nextSong.call();
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Column(
        children: [
          (percent * widget.duration.inMilliseconds.toDouble() > 0 &&
                  percent * widget.duration.inMilliseconds.toDouble() <
                      widget.duration.inMilliseconds.toDouble())
              ? NeumorphicSlider(
                  height: 12,

                  style: SliderStyle(
                      lightSource: LightSource.topLeft,
                      depth: 1,
                      disableDepth: true,
                      accent: Colors.white,
                      variant: Colors.orange),

                  // activeColor: Theme.of(context).primaryColor,
                  // inactiveColor: Colors.white,
                  min: 0,
                  max: widget.duration.inMilliseconds.toDouble(),
                  value: percent * widget.duration.inMilliseconds.toDouble(),
                  onChangeEnd: (newValue) {
                    setState(() {
                      listenOnlyUserInterraction = false;
                      widget.seekTo(_visibleValue);
                    });
                  },
                  onChangeStart: (_) {
                    setState(() {
                      listenOnlyUserInterraction = true;
                    });
                  },
                  onChanged: (newValue) {
                    setState(() {
                      final to = Duration(milliseconds: newValue.floor());
                      _visibleValue = to;
                    });
                  },
                )
              : NeumorphicSlider(
                  value: 0,
                  height: 12,
                  style: SliderStyle(
                      disableDepth: true,
                      lightSource: LightSource.topLeft,
                      depth: 1,
                      accent: Colors.white,
                      variant: Colors.orange),
                  // activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {},
                  // inactiveColor: Colors.white,
                  onChangeEnd: (newValue) {
                    setState(() {
                      listenOnlyUserInterraction = false;
                      widget.seekTo(_visibleValue);
                    });
                  },
                ),
          SizedBox(
            height: 10,
          ),
          (widget.isMainPlayer == true)
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        child: Text(durationToString(widget.currentPosition),
                            style: TextStyle(color: Colors.white60)),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(
                          durationToString(widget.duration),
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.white60),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  final twoDigitMinutes =
      twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds =
      twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return '$twoDigitMinutes:$twoDigitSeconds';
}
