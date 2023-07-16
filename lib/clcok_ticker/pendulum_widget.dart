import 'dart:math';

import 'package:flutter/material.dart';

class Pendulum extends StatelessWidget {
  final AnimationController animationController;
  final bool isStarted;

  const Pendulum(
      {Key? key, required this.animationController, this.isStarted = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double begin = isStarted ? 0.48 : 0.5;
    double end = isStarted ? 0.52 : 0.5;
    return RotationTransition(
      turns: Tween(begin: begin, end: end).animate(animationController),
      alignment: Alignment.topCenter,
      child: Container(
        transform: Matrix4.rotationZ(pi),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.orange,
              ),
            ),
            const _PendulumWeigh(),
          ],
        ),
      ),
    );
  }
}

class _PendulumWeigh extends StatelessWidget {
  const _PendulumWeigh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(54),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange,
            Colors.orangeAccent,
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffffffff),
            offset: Offset(-0.82, -0.82),
            blurRadius: 4,
            spreadRadius: 0.0,
          ),
          BoxShadow(
            color: Color(0xffbebdbd),
            offset: Offset(0.82, 0.82),
            blurRadius: 4,
            spreadRadius: 0.0,
          ),
        ],
      ),
    );
  }
}
