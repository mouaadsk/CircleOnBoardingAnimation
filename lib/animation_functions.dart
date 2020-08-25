import 'package:flutter/material.dart';

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width -
      MediaQuery.of(context).padding.left -
      MediaQuery.of(context).padding.right;
}
Size getSize(BuildContext context) {
  return Size(getWidth(context), getHeight(context));
}
Offset getCenterOffset(
    Size size, double animationEvolution, bool reversingWidgets) {
  try {
    Offset offsetToReturn = Offset(
        size.width * ((0.5 + animationEvolution * 1.5 ) + (reversingWidgets? - 1 : 0)),
        size.height * (.8 - (.3 * animationEvolution)));
    return offsetToReturn;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
