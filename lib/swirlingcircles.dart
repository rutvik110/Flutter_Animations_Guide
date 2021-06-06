import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import 'animationcontroller.dart';

class SwirlingCircles extends StatefulWidget {
  const SwirlingCircles({Key key}) : super(key: key);

  @override
  _SwirlingCirclesState createState() => _SwirlingCirclesState();
}

class _SwirlingCirclesState extends State<SwirlingCircles> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween<double>(begin: 0, end: 3).animate(animationController);

    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Transform.rotate(
                  angle: -(math.pi / 180) * 45 * animation.value,
                  child: CustomPaint(
                    painter: PaintCircle(animation: animation, xoffset: 0, yoffset: 25, centeroffset: -10),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Transform.rotate(
                  angle: (math.pi / 180) * 45 * animation.value,
                  child: CustomPaint(
                    painter: PaintCircle(animation: animation, xoffset: 0, yoffset: 25, centeroffset: 0),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Transform.rotate(
                  angle: (math.pi / 180) * -90 * animation.value,
                  child: CustomPaint(
                    painter: PaintCircle(animation: animation, xoffset: 0, yoffset: 25, centeroffset: 10),
                  ),
                ),
              ),
            ),
            // Positioned.fill(
            //   child: Center(
            //     child: Transform.rotate(
            //       angle: (math.pi / 180) * 90 * animation.value,
            //       child: CustomPaint(
            //         painter: PaintCircle(xoffset: 10, animation: animation, yoffset: 25, centeroffset: 0),
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned.fill(
            //   child: Center(
            //     child: Transform.rotate(
            //       angle: (math.pi / 180) * 90 * animation.value,
            //       child: CustomPaint(
            //         painter: PaintCircle(xoffset: -10, animation: animation, yoffset: -25, centeroffset: 20),
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned.fill(
            //   child: Center(
            //     child: Transform.rotate(
            //       angle: (math.pi / 180) * 60 * animation.value,
            //       child: CustomPaint(
            //         painter: PaintCircle(animation: animation, yoffset: 25),
            //       ),
            //     ),
            //   ),
            // ),
            Align(
                alignment: Alignment.center,
                child: ClipOval(
                  child: Container(
                    height: 10,
                    width: 10,
                    color: Colors.red,
                  ),
                )),
            Positioned(
              bottom: 20,
              child: AnimationControllerSilder(
                animationController: animationController,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PaintCircle extends CustomPainter {
  Animation<double> animation;
  double yoffset = 0;
  double centeroffset = 0;
  double xoffset = 0;

  PaintCircle({this.animation, this.yoffset, this.centeroffset, this.xoffset});
  @override
  void paint(Canvas canvas, Size size) {
    Paint brush = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.difference;

    canvas.drawCircle(Offset(xoffset, (animation.value * yoffset + centeroffset)), animation?.value * 25, brush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
