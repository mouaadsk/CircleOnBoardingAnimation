import 'package:flutter/widgets.dart';
import 'package:flutter_animation_circle/animation_functions.dart';
import 'dart:math';
import 'animationparametrs.dart';

class OnBoardingClipper extends CustomClipper<Rect> {
  double animationEvolution;
  bool reversingWidgets, movingButton;
  OnBoardingClipper(
      {this.animationEvolution, this.reversingWidgets, this.movingButton});
  @override
  Rect getClip(Size size) {
    // TODO: implement getClip
    Offset centerOffset =
        getCenterOffset(size, this.animationEvolution, this.reversingWidgets);
    double height = size.height,
        width = size.width,
        zoomingFactor = circleZoomingFactor,
        valueToAdd = this.movingButton ? 0 : ((1 - this.animationEvolution) * buttonHeight);
    print("the movingButton value is " + this.movingButton.toString());
    Rect rect = this.reversingWidgets
        ? Rect.fromLTWH(
            width * (.5 + valueToAdd) -
                (height *
                    (zoomingFactor * pow(this.animationEvolution, 4) + 0.1)),
            centerOffset.dy -
                (height *
                        (zoomingFactor * pow(this.animationEvolution, 4) +
                            0.1)) *
                    .5,
            height * (zoomingFactor * pow(this.animationEvolution, 4) + 0.1),
            height * (zoomingFactor * pow(this.animationEvolution, 4) + 0.1))
        : Rect.fromLTWH(
            width * (.5 - valueToAdd),
            centerOffset.dy -
                (height *
                        (zoomingFactor * pow(this.animationEvolution, 4) +
                            0.1)) *
                    .5,
            height * (zoomingFactor * pow(this.animationEvolution, 4) + 0.1),
            height * (zoomingFactor * pow(this.animationEvolution, 4) + 0.1));
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
