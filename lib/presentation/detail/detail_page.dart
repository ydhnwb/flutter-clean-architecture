import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String productId;
  const DetailPage({ Key? key, required this.productId }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text("Hello"),
              Text("Wordl")
            ],
          ),
        ),
      ),
    );
  }
}