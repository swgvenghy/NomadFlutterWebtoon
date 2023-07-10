import 'package:flutter/material.dart';


void main() {
  runApp(App());
}
class App extends StatefulWidget{
 State<App> createState() => _AppState();
}

class _AppState extends State<App>{
  bool showTitle = true;

  void toggleTitle() {
    setState(() {
      showTitle = !showTitle;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDD8),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showTitle? MyLargeTitle() : Text("nothing"),
              IconButton(onPressed: toggleTitle, icon: Icon(Icons.remove_red_eye),),
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatefulWidget{
  State<MyLargeTitle> createState() => _MyLargeTtitle();
}

class _MyLargeTtitle extends State<MyLargeTitle>{
  void initState() {
    super.initState();
    print('initState!');
  }
  void dispose() {
    super.dispose();
    print("dispose!");
  }
  Widget build(BuildContext context) {
    return Text(
      'My Large Title',
      style: TextStyle(
        fontSize: 30,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
    );
  }
}