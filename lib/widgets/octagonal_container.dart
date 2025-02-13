import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class OctagonalContainer extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final Color color;

  const OctagonalContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.imageUrl,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OctagonClipper(),
      child: Container(
        width: width,
        height: height,
        color: color,
        child: Center(
          child: Image(
            image: AssetImage(imageUrl),
            width: width, // Adjust image size
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class OctagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    double cut = w * 0.25; // Octagon cut size (adjusts proportions)

    Path path = Path();
    path.moveTo(cut, 0);
    path.lineTo(w - cut, 0);
    path.lineTo(w, cut);
    path.lineTo(w, h - cut);
    path.lineTo(w - cut, h);
    path.lineTo(cut, h);
    path.lineTo(0, h - cut);
    path.lineTo(0, cut);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


