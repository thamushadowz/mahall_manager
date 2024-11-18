import 'package:flutter/material.dart';

class TornEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 10); // Start at the left edge, slightly below the top
    bool isUp = true;
    double stepWidth = 10; // Width of each "tear"
    double tearHeight = 5; // Height of each "tear"

    // Create a zig-zag pattern for the torn effect
    for (double x = 0; x < size.width; x += stepWidth) {
      path.lineTo(x, isUp ? 30 - tearHeight : 30);
      isUp = !isUp;
    }

    path.lineTo(size.width, 10);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
