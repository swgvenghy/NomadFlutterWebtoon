import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen ({super.key});

  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  bool isFirst = true;

  late Timer timer; //시작하자마자 초기화x, 필요할 때 초기화하는 키워드 late

  void onTick(Timer timer) {
    if(totalSeconds == 0) {
      setState(() {
        totalPomodoros++;
        isFirst = true;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }
  void onStartPressed(){
    timer = Timer.periodic( //함수를 일정 주기로 반복하게 하도록 도움
        Duration(seconds:1), // 주기
        onTick, //콜백함수
    );
    setState(() {
      isRunning = true;
      isFirst = false;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    totalSeconds = twentyFiveMinutes;
    setState(() {
      isRunning = false;
      isFirst = true;
    });
  }
  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return (duration.toString().split(".").first.substring(2,7));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(  //UI를 비율에 기반하여 더 유연하게 만들도록 하는 위젯
            flex: 1,   //비율을 몇으로 할것인지 설정
            child: Container(
              alignment: Alignment.center,
              child: Text(format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      onPressed: isRunning
                          ? onPausePressed
                          : onStartPressed,
                      icon: Icon(isRunning
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline
                      ),
                    ),
                    !isFirst? IconButton(
                        iconSize: 120,
                        color: Theme.of(context).cardColor,
                        onPressed: onResetPressed, icon: Icon(Icons.stop_circle_outlined)
                    ) : const SizedBox(),
                  ],
                ),
              ]
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pomodoros',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.displayLarge!.color
                          ),
                        ),
                        Text('$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.displayLarge!.color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}