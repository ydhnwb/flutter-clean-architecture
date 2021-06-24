import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/common/module/shared_pref_module.dart';
import 'package:flutter_clean_architecture/domain/login/entity/login_entity.dart';
import 'package:flutter_clean_architecture/main.dart';
import 'package:flutter_clean_architecture/presentation/common/infra/router.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final SharedPreferenceModule pref = sl.get();

  @override
  void initState() {
    _checkIsLoggedIn();
    super.initState();
  }


  void _checkIsLoggedIn(){
    if(pref.getUserData().isEmpty){
      _goToLoginPage();
    }
  }

  void _goToLoginPage(){
    Navigator.popAndPushNamed(context, AppRouter.ROUTE_LOGIN);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clean architecture"),
      ),
      body: Container(
        child: Center(child: Text(pref.getUserData())),
      ),
    );
  }
}