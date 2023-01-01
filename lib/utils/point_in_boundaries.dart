import 'package:agriclaim/ui/constants/enums.dart';

/// x = longitude, y = latitude
class Coordinates {
  final double x;
  final double y;

  Coordinates({required this.x, required this.y});
}

class FarmBoundary {
  static const int _accuracy = 5;

  /// return true if point is within or on boundary of farm
  static bool checkIsWithinBoundary(
      Coordinates point, List<Coordinates> boundaryPoints) {
    int numOfIntersections = 0;
    for (int i = 0; i < boundaryPoints.length; i++) {
      Coordinates a = boundaryPoints[i];
      Coordinates b = i == boundaryPoints.length - 1
          ? boundaryPoints[0]
          : boundaryPoints[i + 1];
      final boundaryState = getBoundaryState(point, a, b);
      if (boundaryState == BoundaryStates.onBoundary) {
        return true;
      }
      if (boundaryState == BoundaryStates.inBoundary) {
        numOfIntersections += 1;
      }
    }

    return (numOfIntersections % 2) == 1;
  }

  /// accuracy checked to 5 decimal places
  /// accurate of +- 1m
  /// http://wiki.gis.com/wiki/index.php/Decimal_degrees
  static BoundaryStates getBoundaryState(
      Coordinates point, Coordinates a, Coordinates b) {
    final double aY = roundOff(a.y);
    final double bY = roundOff(b.y);
    final double aX = roundOff(a.x);
    final double bX = roundOff(b.x);
    final double pY = roundOff(point.y);
    final double pX = roundOff(point.x);

    // checks to see if the point is completely above, below or to the right of the line
    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return BoundaryStates.outOfBoundary;
    }

    // calculate gradient of line
    final double m = (aY - bY) / (aX - bX);

    // calculate y intercept of line
    final double c = ((aX * -1) * m) + aY;

    // calculate x coordinate of intersection of the line with the
    // horizontal line extended from the point
    final double tempX = (pY - c) / m;
    final double x = roundOff(tempX);

    // x is the point of intersection between the horizontal line
    // and the line connecting a and b
    if (x == pX) {
      return BoundaryStates.onBoundary;
    }

    if (x < pX) {
      return BoundaryStates.outOfBoundary;
    }

    return BoundaryStates.inBoundary;
  }

  static double roundOff(double number) {
    return double.parse(number.toStringAsFixed(_accuracy));
  }
}
