import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({ Key? key }) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Container(
          child: Text("Hello profile"),
        ),
      ),
    );
  }
}