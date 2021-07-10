import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/register/remote/dto/register_request.dart';
import 'package:flutter_clean_architecture/presentation/common/infra/router.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/primary_button.shared_component.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/text_header.shared_component.dart';
import 'package:flutter_clean_architecture/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_clean_architecture/presentation/register/bloc/register_event.dart';
import 'package:flutter_clean_architecture/presentation/register/bloc/register_state.dart';

class RegisterPage extends StatefulWidget {
  final RegisterBloc registerBloc;

  const RegisterPage({ Key? key, required this.registerBloc }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  bool _isObscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _nameInputController = TextEditingController();
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();


  void _handleState(state){
    if(state is RegisterPageStateLoading){
      _isLoading = state.isLoading;
    }else if(state is RegisterPageStateSuccess){
      Navigator.pushNamedAndRemoveUntil(context, AppRouter.ROUTE_HOME, (r) => false);
    }else if(state is RegisterPageStateError){
      _showAlert(state.message);
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

  void _doRegister(){
    if(_formKey.currentState!.validate()){
      String name = _nameInputController.text.toString().trim();
      String email = _emailInputController.text.toString().trim();
      String password = _passwordInputController.text.toString().trim();
      RegisterRequest req = RegisterRequest(name: name, email: email, password: password);
      widget.registerBloc.add(RegisterPageEventDoRegister(registerRequest: req));
    }
  }


  Widget _headerWidget(){
    return Container(
      margin: const EdgeInsets.only(top: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextHeader(text: "Create Account"),
          Text("Please fill up this form below to get all access from the app")
        ],
      ),
    );
  }

  Widget _loadingBar(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: LinearProgressIndicator(
        value: _isLoading ? null : 0,
      ),
    );
  }

  Widget _signUpForm(){
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameInputController,
              decoration: InputDecoration(
                hintText: "Name"
              ),
              validator: (v) {
                if(v == null || v.toString().trim().isEmpty){
                  return "Name cannot be empty";
                }
                return null;
              },
            ),

            SizedBox(height: 16),

            TextFormField(
              controller: _emailInputController,
              decoration: InputDecoration(
                hintText: "Email"
              ),
              validator: (v){
                if(v == null || v.trim().isEmpty){
                  return "Email cannot be empty";
                }
                return null;
              },
            ),

            SizedBox(height: 16,),

            TextFormField(
              controller: _passwordInputController,
              decoration: InputDecoration(
                hintText: "Password",
                suffix: InkWell(
                  onTap: () {
                    setState(() {
                      _isObscurePassword = !_isObscurePassword;
                    });
                  },
                  child: _isObscurePassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                )
              ),
              obscureText: _isObscurePassword,
              validator: (v){
                if(v == null || v.trim().length < 8){
                  return "Password must at least 8 characters";
                }
                return null;
              },
              
            ),

            SizedBox(height: 16),

            PrimaryButton(text: "Create account", onClick: _isLoading ? null : _doRegister)
          ],
        )
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocConsumer<RegisterBloc, RegisterPageState>(
            bloc: widget.registerBloc,
            listener: (context, state) => {
              _handleState(state)
            },
            builder: (context, state){
              return Column(
                children: [
                  _headerWidget(),
                  _loadingBar(),
                  _signUpForm()
                ],
              );
            },
          ),
        ),
      ),
      
    ),
    );
  }
}