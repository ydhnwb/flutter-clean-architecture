import 'package:flutter/material.dart';

class PrimaryTabDetail extends StatefulWidget {
  const PrimaryTabDetail({ Key? key }) : super(key: key);

  @override
  _PrimaryTabDetailState createState() => _PrimaryTabDetailState();
}

class _PrimaryTabDetailState extends State<PrimaryTabDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("detail"),
        ),
      ),
    );
  }
}