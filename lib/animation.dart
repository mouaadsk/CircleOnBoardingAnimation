import 'package:flutter/material.dart';
import 'package:flutter_animation_circle/animation_functions.dart';
import 'package:flutter_animation_circle/animationparametrs.dart';
import 'package:flutter_animation_circle/clippers.dart';
import 'package:flutter_animation_circle/enums.dart';
import 'dart:math';

class CircleAnimation extends StatefulWidget {
  final Widget firstWidget, secondWidget;
  final bool movingTheButton;
  const CircleAnimation(
      {Key key, this.firstWidget, this.secondWidget, this.movingTheButton})
      : super(key: key);
  @override
  _CircleAnimationState createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with TickerProviderStateMixin {
  AnimationController _firstAnimationController, _movingButtonController;
  var _firstCurvedAniamtion;
  double value = 0;
  bool reversingWidgets = false, animationCompleted = false;
  var _firstTween;
  CircleOnBoardingAniamtionState _circleOnBoardingAniamtionState =
      CircleOnBoardingAniamtionState.ButtonCenter;
  Size _size;
  double leftButtonMargin, initialLeftMargin;
  Future<bool> playAnimation() async {
    try {
      //! Playing the first animation
      if (this.widget.movingTheButton) {
        this._circleOnBoardingAniamtionState =
            CircleOnBoardingAniamtionState.MovingTheButton;
        this._movingButtonController.forward().then((value) {
          this._circleOnBoardingAniamtionState =
              CircleOnBoardingAniamtionState.StartAnimation;
          this._firstAnimationController.forward().then((value) {
            //! reversing the widgets order in the stack
            this.reversingWidgets = true;
            this._firstAnimationController.reverse().then((value) {
              this._circleOnBoardingAniamtionState =
                  CircleOnBoardingAniamtionState.MovingTheButton;
              this._movingButtonController.reverse().then((value) {
                this.animationCompleted = true;
                _circleOnBoardingAniamtionState =
                    CircleOnBoardingAniamtionState.ButtonCenter;
              });
            });
          });
        });
      } else {
        this._circleOnBoardingAniamtionState =
            CircleOnBoardingAniamtionState.StartAnimation;
        this._firstAnimationController.forward().then((value) {
          this.reversingWidgets = true;
          this._firstAnimationController.reverse().then((value) {
            this.animationCompleted = true;
            setState(() {
              this._circleOnBoardingAniamtionState = CircleOnBoardingAniamtionState.ButtonCenter;
            });
          });
        });
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> reverseAnimation() async {
    try {
      if (this.widget.movingTheButton) {
        this._circleOnBoardingAniamtionState =
            CircleOnBoardingAniamtionState.MovingTheButton;
        //!playig the first animation backward
        this._movingButtonController.forward().then((value) {
          this._circleOnBoardingAniamtionState =
              CircleOnBoardingAniamtionState.StartAnimation;
          this._firstAnimationController.forward().then((value) {
            this.reversingWidgets = false;
            this._firstAnimationController.reverse().then((value) {
              this._circleOnBoardingAniamtionState =
                  CircleOnBoardingAniamtionState.MovingTheButton;
              this._movingButtonController.reverse().then((value) {
                _circleOnBoardingAniamtionState =
                    CircleOnBoardingAniamtionState.ButtonCenter;
                this.animationCompleted = false;
              });
            });
          });
        });
      } else {
        this._circleOnBoardingAniamtionState =
            CircleOnBoardingAniamtionState.StartAnimation;
        this._firstAnimationController.forward().then((value) {
          this.reversingWidgets = false;
          this._firstAnimationController.reverse().then((value) {
            this.animationCompleted = false;
            setState(() {
              this._circleOnBoardingAniamtionState = CircleOnBoardingAniamtionState.ButtonCenter;
            });
          });
        });
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Offset gettingTheCurrentCenterOfTheCircle(
      CircleOnBoardingAniamtionState animationState,
      bool reversingWidgetParameter) {
    try {
      return Offset(
          reversingWidgetParameter
              ? this._size.width * .5 -
                  (this._size.height * (circleZoomingFactor * pow(0, 4) + 0.1))
              : this._size.width * .5,
          this._size.height * (1 - buttonBottomMargin));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> movingTheButtonToPoistion(Offset moveToOffset) async {
    try {
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._firstAnimationController = AnimationController(
        duration: animationCircleDuration * .5, vsync: this);
    this._firstCurvedAniamtion = CurvedAnimation(
        parent: this._firstAnimationController,
        curve: Curves.easeInCirc,
        reverseCurve: Curves.easeInQuint);
    this._firstTween =
        Tween<double>(begin: 0.0, end: 1.0).animate(this._firstCurvedAniamtion)
          ..addListener(() {
            setState(() {
              this.value = this._firstAnimationController.value;
            });
          });
    if (this.widget.movingTheButton) {
      this._movingButtonController = AnimationController(
          duration: movingTheButtonDuration, vsync: this)
        ..addListener(() {
          setState(() {
            this.leftButtonMargin = initialLeftMargin +
                this._movingButtonController.value *
                    (gettingTheCurrentCenterOfTheCircle(
                                this._circleOnBoardingAniamtionState,
                                this.reversingWidgets)
                            .dx -
                        initialLeftMargin);
          });
        })
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed)
            setState(() {
              this.leftButtonMargin = initialLeftMargin +
                  this._movingButtonController.value *
                      (gettingTheCurrentCenterOfTheCircle(
                                  this._circleOnBoardingAniamtionState,
                                  !this.animationCompleted)
                              .dx -
                          initialLeftMargin);
              print("status is completed" + this.leftButtonMargin.toString());
            });
          else if (status == AnimationStatus.dismissed) {
            setState(() {
              this.leftButtonMargin = initialLeftMargin +
                  this._movingButtonController.value *
                      (gettingTheCurrentCenterOfTheCircle(
                                  this._circleOnBoardingAniamtionState,
                                  this.animationCompleted)
                              .dx -
                          initialLeftMargin);
              print("status is dismissed" + this.leftButtonMargin.toString());
            });
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context),
        screenHeight = getHeight(context);
    if (this._size == null) {
      this._size = getSize(context);
      this.initialLeftMargin =
          (this._size.width * .5 - buttonHeight * this._size.width);
      this.leftButtonMargin = initialLeftMargin;
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          this.reversingWidgets
              ? this.widget.secondWidget
              : this.widget.firstWidget,
          //TODO : displaying a button before starting the animation and in the animation end
          this._circleOnBoardingAniamtionState ==
                      CircleOnBoardingAniamtionState.ButtonCenter ||
                  this._circleOnBoardingAniamtionState ==
                      CircleOnBoardingAniamtionState.MovingTheButton
              ? Positioned(
                  left: this.leftButtonMargin,
                  bottom: screenHeight * buttonBottomMargin,
                  child: Center(
                      child: RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        if (!this.animationCompleted)
                          this.playAnimation();
                        else
                          this.reverseAnimation();
                      });
                    },
                    elevation: 2.0,
                    fillColor:
                        this.reversingWidgets ? Colors.amber : Colors.black,
                    child: Icon(
                      this.reversingWidgets
                          ? Icons.arrow_back
                          : Icons.arrow_forward,
                      size: screenHeight * buttonHeight * .45,
                      color:
                          this.reversingWidgets ? Colors.black : Colors.amber,
                    ),
                    padding:
                        EdgeInsets.all(screenHeight * (buttonHeight * .275)),
                    shape: CircleBorder(),
                  )),
                )
              : ClipOval(
                  clipper: OnBoardingClipper(
                      movingButton: this.widget.movingTheButton,
                      animationEvolution: this.value,
                      reversingWidgets: this.reversingWidgets),
                  child: this.reversingWidgets
                      ? this.widget.firstWidget
                      : this.widget.secondWidget,
                ),
        ]),
      ),
    );
  }
}
