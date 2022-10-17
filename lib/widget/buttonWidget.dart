import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BubbleMusicOptionButton extends StatefulWidget {
  @override
  _BubbleMusicOptionButtonState createState() =>
      _BubbleMusicOptionButtonState();

  BubbleMusicOptionButton(
      {Key key,
      this.backgroundColor,
      this.size,
      this.iconSize,
      this.basicIcon,
      this.widget,
      this.textSelectionColor,
      this.action,
      this.color,
      this.icon,
      this.assetsaudioPlayer,
      this.outsideICon,
      this.paddingHorizontal})
      : super(key: key);

  final double paddingHorizontal;

  final Widget widget;
  final bool outsideICon;
  final bool basicIcon;
  final Color color;
  final double size;
  final double iconSize;
  final IconData icon;
  final Function action;
  final AssetsAudioPlayer assetsaudioPlayer;

  final Color backgroundColor;
  final Color textSelectionColor;
}

class _BubbleMusicOptionButtonState extends State<BubbleMusicOptionButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Container(
          padding: new EdgeInsets.symmetric(
              horizontal: widget.paddingHorizontal == null
                  ? 0
                  : widget.paddingHorizontal),
          child: Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                depth: 2,
                lightSource: LightSource.topLeft,
                color: Colors.grey),
            child: widget.basicIcon == true ? icon(context) : icon(context),
          )),
      onTap: () {
        if (widget.outsideICon == true) {
          widget.action();
        } else {
          if (widget.assetsaudioPlayer.current.hasValue == true) {
            setState(() {
              widget.action();
            });
          }
        }
      },
    );
  }

  Widget icon(BuildContext context) {
    return new Container(
      padding:
          widget.basicIcon != true ? null : EdgeInsets.symmetric(vertical: 10),
      height: widget.basicIcon == true ? null : widget.size,
      width: widget.size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.basicIcon == true || widget.widget != null
            ? null
            : Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: widget.widget != null
          ? widget.widget
          : new Icon(widget.icon, color: widget.color, size: widget.iconSize),
    );
  }
}
