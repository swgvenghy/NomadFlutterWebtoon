import 'package:flutter/material.dart';
import 'package:webtoon_flutter/Webtoon/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key}); //App이라는 위젯의 key를 Stateless라는 수퍼클래스에 보낸 것

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
