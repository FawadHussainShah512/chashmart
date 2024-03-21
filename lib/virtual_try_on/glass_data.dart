
import 'dart:math';

class GlassData {
  double leftEarX;
  double leftEarY;
  double rightEarX;
  double rightEarY;
  double centerX;
  double centerY;
  List<Point> allPoints;

  GlassData({
    required this.leftEarX,
    required this.rightEarX,
    required this.leftEarY,
    required this.rightEarY,
    required this.centerX,
    required this.centerY,
    required this.allPoints
  });

  double get angleOfRotation {
    ///angle of rotation calculation logic
    return atan((leftEarY  - rightEarY) / (rightEarX - leftEarX));
  }

  double get relGlassLength {
    return calculateDistance(leftEarX, leftEarY, rightEarX, rightEarY);
  }
}

class Point {
  double x;
  double y;
  Point(this.x, this.y);
}

double calculateDistance(double x1, double y1, double x2, double y2) {
  double dx = x2 - x1;
  double dy = y2 - y1;
  return sqrt(dx * dx + dy * dy);
}