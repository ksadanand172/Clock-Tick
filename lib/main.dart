import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neu_clock/clcok_ticker/analog_clock_body.dart';
import 'package:neu_clock/clcok_ticker/digital_clock_body.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //To hide status or notification bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TicTicTicker(title: 'Tic Tic Ticker'),
    );
  }
}

class TicTicTicker extends StatefulWidget {
  const TicTicTicker({super.key, required this.title});

  final String title;

  @override
  State<TicTicTicker> createState() => _TicTicTickerState();
}

class _TicTicTickerState extends State<TicTicTicker> {
  late Timer _timer;
  DateTime now = DateTime(0, 0, 0);
  bool isStarted = false;

  void _startCounter() {
    if (!isStarted) {
      setState(() {
        isStarted = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
    }
  }

  void _onTimerTick(Timer timer) {
    setState(() {
      now = DateTime.now();
    });
  }

  void _stopCounter() {
    if (_timer.isActive) {
      setState(() {
        isStarted = false;
      });
      _timer.cancel();
    }
  }

  void _resetTimer() {
    setState(() {
      isStarted = false;
    });
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffefeeee),
      appBar: AppBar(
        backgroundColor: const Color(0xff9980fa),
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnalogClock(
            now: now,
            isStarted: isStarted,
          ),
          const SizedBox(
            height: 100,
          ),
          DigitalClock(
            now: now,
            isStarted: isStarted,
          ),
          const SizedBox(
            height: 120,
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.extended(
          onPressed: () {
            if (!isStarted) {
              _startCounter();
            } else {
              _stopCounter();
            }
          },
          tooltip: 'Start / Stop',
          icon:
              Icon(isStarted ? Icons.stop_outlined : Icons.play_arrow_outlined),
          backgroundColor: const Color(0xff9980fa),
          label: Text(isStarted ? "Stop" : "Start"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
