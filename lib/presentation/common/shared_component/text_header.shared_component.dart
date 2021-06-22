import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget {
  final String text;
  const TextHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(this.text, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),);
  }
}
