import 'package:flutter/material.dart';

class DangerButton extends StatelessWidget {
  final String text;
  final VoidCallback? onClick;
  const DangerButton({Key? key, required this.text, required this.onClick}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
          width: double.infinity,
          height: 46,
        ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
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
