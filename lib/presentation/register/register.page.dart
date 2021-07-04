import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/primary_button.shared_component.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/text_header.shared_component.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

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

            SizedBox(height: 16,),

            PrimaryButton(text: "Create account", onClick:() => {})
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
          child: Column(
            children: [
              _headerWidget(),
              _loadingBar(),
              _signUpForm()
            ],
          ),
        ),
      ),
      
    ),
    );
  }
}