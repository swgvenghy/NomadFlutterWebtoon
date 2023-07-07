import 'package:flutter/cupertino.dart';

class Button extends StatelessWidget{
  final String text;
  final Color bgColor;
  final Color textColor;

  const Button({
    required this.text,
    required this.bgColor,
    required this.textColor
  });


  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        color: bgColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20,
              color: textColor,
          ),
        ),
      ),
    );
  }
}