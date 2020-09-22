//! this file contains the parameters of the animation and any width or height depends on the screenHeight or the screenWidth 
//! for example we always do this : RealElementHeight/Width = elementWidth/tHeight * screenHeight/Width 
double buttonHeight = .1, buttonBottomMargin = 0.15;

//! the zoomFactor paramaeter means how much of growth the cutted rectangle (transformed to a circle) must be 
double circleZoomingFactor = 50;
 //! in this variable you can adjust if you want to move the button to the center before/after the animation start/end
 bool movingTheButton = false;
 //! these variables are for the duration of the animation/movingTheButton
 Duration animationCircleDuration = Duration(seconds : 1), movingTheButtonDuration = Duration(milliseconds: 200);

