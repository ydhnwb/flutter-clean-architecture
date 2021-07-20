import 'package:flutter/material.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({ Key? key }) : super(key: key);

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new product"),
      ),
      body: Container(
        child: Text("Hello create"),
      ),
    );
  }
}