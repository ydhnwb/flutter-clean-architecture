import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/common/module/shared_pref_module.dart';
import 'package:flutter_clean_architecture/presentation/common/infra/router.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/text_header.shared_component.dart';

class ProfileTab extends StatefulWidget {
  final SharedPreferenceModule pref;
  const ProfileTab({ Key? key, required this.pref }) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String _name = "";
  String _email = "";

  _showProfileInfo(){
    String userData = widget.pref.getUserData();
    if(userData.isNotEmpty){
      setState(() {
        _name = jsonDecode(userData)["name"];
        _email = jsonDecode(userData)["email"];        
      });

    }
  }

  _logout(){
    widget.pref.clear();
    Navigator.of(context, rootNavigator: true).pushReplacementNamed(AppRouter.ROUTE_LOGIN);
  }


  @override
  void initState() {
    super.initState();
    _showProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextHeader(text: _name),
              Text(_email),
              ElevatedButton(
                onPressed: () {
                  _logout();
                }, 
                child: Text("Sign out"))
            ],
          ),
        ),
      ),
    );
  }
}