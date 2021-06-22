import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/text_header.shared_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Widget headerWidget(){
    return Container(
      margin: EdgeInsets.only(top: 36),
      child: Column(
        children: [
          TextHeader(text: "Sign In")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerWidget(),
                  Text("Please sign in first to get all feature of this app. If you don't have any account, create a new one"),
                ],
              ),
            )
          )
      )
    );
  }
}
