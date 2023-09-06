import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/register_page.dart';
import 'package:flutter_app/widgets/custom_btn.dart';
import 'package:flutter_app/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {



  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("close"),
                onPressed: (){
                  Navigator.pop(context);
                },

              )
            ],
          );
        }
    );

  }




  Future<String> _loginAccount() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email:  _loginEmail,password:  _loginPassword);
      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password'){
        return'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return'The account already exists for that email';
      }
      return e.message;
    }catch (e){
      return e.toString();

    }
  }


  void _submitForm() async{
    setState(() {
      _loginFormLoading = true;
    });

    String _loginFeedback = await _loginAccount();
    if(_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);

      setState(() {
        _loginFormLoading = false;
      });
    }
  }


  bool _loginFormLoading = false;

  String _loginEmail = "";
  String _loginPassword = "";

  FocusNode _passwordFocusNode;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                padding: EdgeInsets.only(
                  top: 24.0,
                ),

                child: Text("Welcome User,\nLogin to your account",
                textAlign: TextAlign.center,
                  style: constants.boldheading,
                ),
              ),
                Column(
                  children: [
                    CustomInput(
                      hintText: "Email...",
                      onChanged: (value) {
                        _loginEmail = value;
                      },
                      onSubmitted: (value){
                        _passwordFocusNode.requestFocus();

                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: "Password...",
                      onChanged: (value){
                        _loginPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value){
                        _submitForm();
                      },

                    ),
                    CustomBtn(
                      text: "Login",
                      onPressed: (){
                        _submitForm();

                      },
                      isLoading: _loginFormLoading,
                    ),
                  ],

                ),


            Padding(
              padding: const EdgeInsets.only(
                bottom: 12.0,
              ),
              child: CustomBtn(
                text: "Create New Account",
                onPressed: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => RegisterPage()
                   )
                 );
                },
                outlineBtn: true,
              ),
            ),
            ],
        ),
          ),
    ),
    );
  }
}