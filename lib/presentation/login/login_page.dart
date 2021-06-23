import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/primary_button.shared_component.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/text_header.shared_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _isShowPassword = false;
  final _formKey = GlobalKey<FormState>();
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();


  void _doLogin(){
    if (_formKey.currentState!.validate()) {
      String email = _emailTextFieldController.text.toString().trim();
      String password = _passwordTextFieldController.text.toString().trim();
      print(email);
      print(password);
    }

  }

  Widget _headerWidget(){
    return Container(
      margin: EdgeInsets.only(top: 36, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextHeader(text: "Sign In"),
          Text("Please sign in first to get all feature of this app. If you don't have any account, create a new one"),
        ],
      ),
    );
  }

  Widget _loadingBar(){
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 28, left: 16, right: 16),
      child: LinearProgressIndicator(
        value: _isLoading ? null : 0,
      ),
    );
  }


  Widget _createAccountSection(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 28),
      child: InkWell(
        onTap: () => {},
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text("Create a new account", style: TextStyle(decoration: TextDecoration.underline))
        )
      ),
    );
  }




  Widget _signInForm(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailTextFieldController,
              decoration: InputDecoration(
                hintText: "Email",
              ),
              validator: (value) {
                if(value == null || value.toString().trim().isEmpty){
                  return "Email must not be empty";
                }
                return null;
              },
            ),

            SizedBox(height: 16),

            TextFormField(
              obscureText: _isShowPassword,
              controller: _passwordTextFieldController,
              decoration: InputDecoration(
                hintText: "Password",
                suffixIcon: InkWell(
                  onTap: () => {
                    setState(() {
                      _isShowPassword = !_isShowPassword;
                    })
                  },
                  child: _isShowPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                )
              ),
              validator: (value) {
                if(value == null || value.toString().trim().isEmpty){
                  return "Password must not be empty";
                }
                return null;
              },
            ),

            SizedBox(height: 16,),


            PrimaryButton(
              text: "Login",
              onClick: () => {
                _doLogin()
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(

              child: Column(
                children: [
                  _headerWidget(),
                  _loadingBar(),
                  _signInForm(),
                  _createAccountSection()
                ],
              ),
            )
          )
      )
    );
  }
}
