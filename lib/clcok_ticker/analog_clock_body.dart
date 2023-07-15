import 'dart:math';
import 'package:flutter/material.dart';
import 'package:neu_clock/clcok_ticker/pendulum_widget.dart';

class AnalogClock extends StatefulWidget {
  final DateTime now;
  final bool isStarted;

  const AnalogClock({Key? key, required this.now, this.isStarted = false})
      : super(key: key);

  @override
  State<AnalogClock> createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.now.second % 2 == 0) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: MediaQuery.of(context).size.width/2 + 10,
          child: Pendulum(
            animationController: _animationController,
            isStarted: widget.isStarted,
          ),
        ),
        Container(
          // color: const Color(0xffefeeee),
          alignment: const Alignment(0, 0),
          transformAlignment: Alignment.center,
          child: Container(
            width: 224,
            height: 224,
            decoration: BoxDecoration(
              color: const Color(0xffefeeee),
              borderRadius: BorderRadius.circular(133),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffffffff),
                  Color(0xffcdd1d4),
                ],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffffffff),
                  offset: Offset(-33.2, -33.2),
                  blurRadius: 38,
                  spreadRadius: 0.0,
                ),
                BoxShadow(
                  color: Color(0xffcdd1d4),
                  offset: Offset(33.2, 33.2),
                  blurRadius: 38,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ...List.generate(
                  12,
                  (index) {
                    return _HoursStop(
                      turnAngle: 2 * pi * (index / 12),
                    );
                  },
                ),
                SecondsHand(now: widget.now),
                MinutesHand(now: widget.now),
                HoursHand(now: widget.now),
                const CircleAvatar(
                  radius: 10,
                  backgroundColor: Color(0xff9980fa),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SecondsHand extends StatelessWidget {
  final DateTime now;

  const SecondsHand({Key? key, required this.now}) : super(key: key);

  double _calculateSecondsAngle(DateTime dateTime) {
    return 2 * pi * (dateTime.second / 60) + 1.5 * pi;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 112,
        ),
        Container(
          height: 1,
          width: 110,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(1),
          ),
          transform: Matrix4.rotationZ(
            _calculateSecondsAngle(now),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
      ],
    );
  }
}

class MinutesHand extends StatelessWidget {
  final DateTime now;

  const MinutesHand({Key? key, required this.now}) : super(key: key);

  double _calculateMinutesAngle(DateTime dateTime) {
    return 2 * pi * (dateTime.minute / 60) + 1.5 * pi;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 112,
        ),
        Container(
          height: 2,
          width: 96,
          decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.circular(1),
          ),
          transform: Matrix4.rotationZ(
            _calculateMinutesAngle(now),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }
}

class HoursHand extends StatelessWidget {
  final DateTime now;

  const HoursHand({Key? key, required this.now}) : super(key: key);

  double _calculateHoursAngle(DateTime dateTime) {
    return 2 * pi * (dateTime.hour / 12 + dateTime.minute / (60 * 12)) +
        3 / 2 * pi;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 112,
        ),
        Container(
          height: 3,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(2),
          ),
          transform: Matrix4.rotationZ(
            _calculateHoursAngle(now),
          ),
        ),
        const SizedBox(
          width: 32,
        ),
      ],
    );
  }
}

class _HoursStop extends StatelessWidget {
  final double length;
  final double width;
  final double turnAngle;

  const _HoursStop(
      {Key? key, required this.turnAngle, this.length = 3, this.width = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: turnAngle,
      child: Row(
        children: [
          const SizedBox(
            width: 212,
          ),
          Container(
            height: width,
            width: length,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
