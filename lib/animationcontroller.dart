import 'package:flutter/material.dart';

class AnimationControllerSilder extends StatefulWidget {
  AnimationController animationController;
  Function buildaniamtion;
  Function playanimation;
  AnimationControllerSilder({this.animationController, this.buildaniamtion, this.playanimation});
  @override
  _AnimationControllerSilderState createState() => _AnimationControllerSilderState();
}

class _AnimationControllerSilderState extends State<AnimationControllerSilder> {
  bool isplaying = false;
  @override
  Widget build(BuildContext context) {
    widget.animationController.addStatusListener((status) {
      setState(() {});
      if (status == AnimationStatus.completed) {
        widget.animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        widget.animationController.forward();
      }
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: isplaying
              ? Icon(
                  Icons.pause,
                  color: Color(0xFF9DF7F7),
                )
              : Icon(
                  Icons.play_arrow,
                  color: Color(0xFF9DF7F7),
                ),
          onPressed: () {
            isplaying = !isplaying;
            widget.animationController.forward();
          },
        ),
        Slider(
          min: 0.0,
          max: 1.0,
          value: widget.animationController.value,
          activeColor: Color(0xFF9DF7F7),
          inactiveColor: Color(0xFFC2E8E8).withOpacity(0.9),
          onChanged: (value) {
            print(value);

            widget.buildaniamtion();
            widget.animationController.value = value;
          },
        )
      ],
    );
  }
}
