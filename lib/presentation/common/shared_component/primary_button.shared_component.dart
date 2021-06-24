import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onClick;
  const PrimaryButton({Key? key, required this.text, required this.onClick}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
          width: double.infinity,
          height: 46,
        ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)
              )
          ),
          onPressed: onClick,
          child: Text(text.toUpperCase(), 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              )
            )
      ),
    );
  }
}
