import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/common/infra/router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  startSplash() async {
    return Timer(Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, AppRouter.ROUTE_LOGIN);
    });
  }

  @override
  void initState() {
    super.initState();
    startSplash();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Text("Splash screen"),
      )),
    );
  }
}
