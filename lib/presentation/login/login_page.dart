import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/login/remote/dto/login_request.dart';
import 'package:flutter_clean_architecture/presentation/common/infra/router.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/primary_button.shared_component.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/text_header.shared_component.dart';
import 'package:flutter_clean_architecture/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_clean_architecture/presentation/login/bloc/login_event.dart';
import 'package:flutter_clean_architecture/presentation/login/bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  final LoginBloc loginBloc;
  const LoginPage({Key? key, required this.loginBloc}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _isShowPassword = false;
  final _formKey = GlobalKey<FormState>();
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();


  void _handleState(state){
    if(state is LoginStateSuccessLogin){
      Navigator.pushReplacementNamed(context, AppRouter.ROUTE_HOME);
    }else if(state is LoginStateErrorLogin){
      _showAlert(state.message);
    }else if(state is LoginStateLoading){
      _isLoading = state.isLoading;
    }
  }

  void _showAlert(String message){
    showCupertinoDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text("OK")
            )
          ],
        );
      }
    );
  }


  void _doLogin(){
    if (_formKey.currentState!.validate()) {
      String email = _emailTextFieldController.text.toString().trim();
      String password = _passwordTextFieldController.text.toString().trim();
      widget.loginBloc.add(LoginEventDoLogin(loginRequest: LoginRequest(email: email, password: password)));
    }
  }

  void _goToRegisterPage(){
    Navigator.pushNamed(context, AppRouter.ROUTE_REGISTER);
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
        onTap: () => {
          _goToRegisterPage()
        },
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
              obscureText: !_isShowPassword,
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
              onClick: _isLoading ? null : _doLogin,
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
              child: BlocConsumer<LoginBloc, LoginState>(
                bloc: widget.loginBloc,
                listener: (context, state){
                  _handleState(state);
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      _headerWidget(),
                      _loadingBar(),
                      _signInForm(),
                      _createAccountSection()
                    ],
                );
                },
              )
            )
          )
      )
    );
  }
}
