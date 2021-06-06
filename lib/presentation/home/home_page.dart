import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/login/remote/dto/login_request.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_result.dart';
import 'package:flutter_clean_architecture/domain/login/repository/login_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.loginRepository}) : super(key: key);

  final LoginRepository loginRepository;

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  String info = "";

  void test() async {
    LoginRequest loginRequest = LoginRequest(email: "ahmadalbar@gmail.com", password: "yudhanewbie");
    var result = await this.widget.loginRepository.login(loginRequest);
    result.fold(
      (loginEntity) {
        setInfoString(loginEntity.name);
      },
      (failure) {
        print("Failure: $failure");
        print(failure);

      },
    );
  }

  setInfoString(String s){
    setState(() {
      info = s;
    });
  }


  @override
  void initState() {
    super.initState();
    test();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clean architecture"),
      ),
      body: Container(
        child: Center(child: Text(info)),
      ),
    );
  }
}