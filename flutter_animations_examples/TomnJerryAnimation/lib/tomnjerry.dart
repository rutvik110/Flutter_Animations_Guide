import 'dart:ui';

import 'package:flutter/material.dart';

import 'animationcontroller.dart';


class TomnJerryAnimation extends StatefulWidget {
  @override
  _TomnJerryAnimationState createState() => _TomnJerryAnimationState();
}

class _TomnJerryAnimationState extends State<TomnJerryAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  CurvedAnimation timecurveforcircles;

  //for ball shadow
  CurvedAnimation bouncinganimationcurve;
  Animation heightanimation;
  //

  //for TomnJerry
  CurvedAnimation bouncingtnjanimation;
  Animation heightanimationtnj;
  //

  void rebuildanimaion() {
    setState(() {});
  }

  void playanimation() {
    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });
  }

  //To get those nice animating circles.
  List<Positioned> listofcircles() {
    List<Positioned> listofcircles = [];
    double radius = 0;
    
    int greenvalue = 235;

    while (radius <= 1000) {

                  Positioned circle = Positioned(
                    top: MediaQuery.of(context).size.height / 2 -
                        timecurveforcircles.value * radius * 2 / 2,
                    left: MediaQuery.of(context).size.width / 2 -
                        timecurveforcircles.value * radius * 2 / 2,
                    child: ClipOval(
                      child: Container(
                        color: Color.fromRGBO(245, greenvalue, 12,
                            1), 
                        height: timecurveforcircles.value * radius * 2,
                        width: timecurveforcircles.value * radius * 2,
                      ),
                    ),
                  );

                  listofcircles.add(circle);
                  
                  radius += 50;
                  if (greenvalue != 0) {
                    greenvalue -= 10;
                  }

    }

    return listofcircles;
  }

  






  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 8000));

    //for ball shadow
    bouncinganimationcurve = CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.4, curve: Curves.bounceOut));

    heightanimation = Tween(begin: Offset(0, -500), end: Offset(0, 0))
        .animate(bouncinganimationcurve);

    //

    //for TomnJerry
    bouncingtnjanimation = CurvedAnimation(
        parent: animationController,
        curve: Interval(0.49, 0.69, curve: Curves.bounceOut));

    heightanimationtnj = TweenSequence([
      TweenSequenceItem(
          weight: 10, tween: Tween(begin: Offset(0, 250), end: Offset(0, 0)))
    ]).animate(bouncingtnjanimation);

    //

    //AnimationCurve for listofcircles.
    timecurveforcircles = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.42, 1, curve: Curves.decelerate),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //BouncingBall
          BouncingBall(
            animationController: animationController,
            heightanimation: heightanimation,
          ),

          //ShadowforBall
          Positioned(
            top: MediaQuery.of(context).size.height / 2 + 20,
            left: MediaQuery.of(context).size.width / 2 -
                (60 + heightanimation.value.dy / 10) / 2,
            child: ClipOval(
              child: Container(
                height: 8.0,
                width: -heightanimation.value.dy / 4 != 0
                    ? 60 + heightanimation.value.dy / 10
                    : 0,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.black26,
                      spreadRadius: 0.7)
                ]),
              ),
            ),
          ),

          //Stackofcircles
          Stack(
            fit: StackFit.expand,
            children: listofcircles().reversed.toList(),
          ),

          //TomnJerry Imagepop up
          Positioned(
            top: MediaQuery.of(context).size.height / 2 -
                timecurveforcircles.value * 2 * 220 / 2,
            left: MediaQuery.of(context).size.width / 2 -
                timecurveforcircles.value * 2 * 220 / 2,
            child: Transform.translate(
              offset: heightanimationtnj.value,
              child: Opacity(
                opacity: animationController.value > 0.5 ? 1 : 0,
                child: Image.asset('assets/tnj.png',
                    height: timecurveforcircles.value * 2 * 220,
                    width: timecurveforcircles.value * 2 * 220),
              ),
            ),
          ),
          //

          //SliderControllerforanimation
          Positioned(
            bottom: 50.0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimationControllerSilder(
                animationController: animationController,
                buildaniamtion: rebuildanimaion,
                playanimation: playanimation,
              ),
            ),
          ),
        ],
      ),
    );
  }
}








class BouncingBall extends StatefulWidget {
  AnimationController animationController;

  Animation heightanimation;
  BouncingBall({Key key, this.animationController, this.heightanimation})
      : super(key: key);

  @override
  _BouncingBallState createState() => _BouncingBallState();
}

class _BouncingBallState extends State<BouncingBall> {
  // CurvedAnimation bouncinganimationcurve;
  Animation heightanimation;
  Animation sizeanimation;
  CurvedAnimation sizecurve;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    sizecurve = CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.42, curve: Curves.easeIn));

    heightanimation = widget.heightanimation;

    sizeanimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 50.0, end: 50), weight: 60),
      TweenSequenceItem(tween: Tween<double>(begin: 50.0, end: 0), weight: 5)
    ]).animate(sizecurve);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 - sizeanimation.value / 2,
      left: MediaQuery.of(context).size.width / 2 - sizeanimation.value / 2,
      child: Transform.translate(
        offset: heightanimation.value,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sizeanimation.value / 2),
            color: Color(0xFFFC0400),
          ),
          width: sizeanimation.value,
          height: sizeanimation.value,
        ),
      ),
    );
  }
}
