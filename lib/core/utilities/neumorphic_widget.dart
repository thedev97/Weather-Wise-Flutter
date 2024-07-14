import 'package:flutter/material.dart';

class NeuContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final Color color;

   const NeuContainer({
    super.key,
    required this.child,
    this.height = 120,
    this.width = 120,
    this.color = const Color(0xFFf1ded0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            offset: Offset(-5, -5),
            blurRadius: 5,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(5, 5),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}