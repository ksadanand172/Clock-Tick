import 'package:flutter/material.dart';
import 'package:neu_clock/clcok_ticker/blinking_dot.dart';
import 'package:neu_clock/clcok_ticker/digital_font.dart';

class DigitalClock extends StatelessWidget {
  final DateTime now;
  final bool isStarted;

  const DigitalClock({Key? key, required this.now, this.isStarted = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      height: 50.0,
      color: const Color(0xffefeeee),
      alignment: Alignment.center,
      transformAlignment: Alignment.center,
      child: Container(
        color: const Color(0xffefeeee),
        child: Container(
          width: 148,
          height: 148,
          decoration: BoxDecoration(
            color: const Color(0xffefeeee),
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffefeeee),
                Color(0xffefeeee),
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffffffff),
                offset: Offset(-22.5, -22.5),
                blurRadius: 30,
                spreadRadius: 0.0,
              ),
              BoxShadow(
                color: Color(0xffd0cfcf),
                offset: Offset(22.5, 22.5),
                blurRadius: 30,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlinkWidget(
                  children: [
                    const CircleAvatar(
                      radius: 5,
                      backgroundColor: Color(0xff9980fa),
                    ),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: const Color(0xff9980fa)
                          .withOpacity(isStarted ? 0.2 : 1),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                DigitalNumber(
                  height: 14,
                  value: now.hour,
                  padLeft: now.hour >= 10 ? 1 : 2,
                ),
                const SizedBox(
                  width: 5,
                ),
                const DigitalColon(),
                const SizedBox(
                  width: 5,
                ),
                DigitalNumber(
                  height: 14,
                  value: now.minute,
                  padLeft: now.minute >= 10 ? 1 : 2,
                ),
                const SizedBox(
                  width: 5,
                ),
                const DigitalColon(),
                const SizedBox(
                  width: 5,
                ),
                DigitalNumber(
                  height: 14,
                  value: now.second,
                  padLeft: now.second >= 10 ? 1 : 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
