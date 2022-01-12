import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myyapp/Food_app/homeSc.dart';
import 'package:myyapp/Food_app/log_in.dart';
import 'package:myyapp/Food_app/welcome.dart';
import 'package:myyapp/main.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserCredential? userCredential;
  String errorMessage = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Length is less than Six';
                      }
                    },
                    controller: _name,
                    decoration: InputDecoration(
                        hintText: "Name",
                        focusColor: Colors.white,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.8),
                        ),
                        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                        contentPadding: EdgeInsets.only(left: 20)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: TextFormField(
                    controller: _email,
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        String pattern = r'\w+@\w+\.\w+';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value.toString())){
                          return 'Enter valid email.';
                        }else{
                          return  'E-mail Address is required.';
                        }
                      }
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.8),
                        ),
                        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                        contentPadding: EdgeInsets.only(left: 20),
                        hintText: "Username"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: TextFormField(
                    controller: _password,
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Invalid Password Address format.';
                      }
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.8),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.9),
                        ),
                        hintText: "password",
                        contentPadding: EdgeInsets.only(left: 20)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => LogIn()),
                              (route) => false);
                        },
                        child:Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                    Container(
                      width: 150,
                      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)),
                      child: FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            return sendData();
                          }
                          // sendData();
                        },
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                "Register",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  sendData() async {
    setState(() {
      isLoading = false;
    });
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text);
      flutterToast(Colors.white, Colors.green, 'Sign Up Successful');
      await FirebaseFirestore.instance.collection("users").doc().set({
        'name': _name.text.toString(),
        'email': _email.text.toString(),
        'password': _password.text.toString(),
        'userid': userCredential!.user!.uid,
      }).then((value){
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) =>HomeScreen()), (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        flutterToast(Colors.white, Colors.red, "weak-password");
      } else if (e.code == 'email-already-in-use') {
        flutterToast(Colors.white, Colors.red, 'email-already-in-use');
      }
    } catch (e) {
      flutterToast(Colors.white, Colors.red, '$e');
    }
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    isLoading = true;
  }
}








