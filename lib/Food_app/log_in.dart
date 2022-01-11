




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myyapp/Food_app/homeSc.dart';
import 'package:myyapp/Food_app/sign_up.dart';
import 'package:myyapp/Food_app/welcome.dart';
import 'package:myyapp/main.dart';

class LogIn extends StatefulWidget {

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
              children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Text("Log In", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26
                ),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.white
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      String pattern = r'\w+@\w+\.\w+';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value.toString())) return 'E-mail Address is required.';
                      return null;
                    }
                  },
                  controller: _email,
                  decoration: InputDecoration(
                      hintText: "Username",
                    focusColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.8
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.8
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white
                    ),
                    prefixIcon: Icon(Icons.person,color: Colors.white,)
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: TextFormField(
                  controller: _password,
                  style: TextStyle(
                    color: Colors.white
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      String pattern = r'\w+@\w+\.\w+';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value.toString())) return 'Password is required..';
                      return null;
                    }
                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.8
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.8
                        ),
                      ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                      prefixIcon: Icon(Icons.lock,color: Colors.white,),
                      hintText: "Password"
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: FlatButton(onPressed: () async{
                  setState(() {
                    isLoading = true;
                    errorMessage = '';
                  });
                  if(_formKey.currentState!.validate()){
                    try{
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text.toString().trim(),
                          password: _password.text.toString().trim()).then((value){
                        flutterToast(Colors.white, Colors.green, "Log In Successful");
                      }).then((value){
                            Navigator.push(context, MaterialPageRoute(builder: (_) =>HomeScreen()));
                      });
                    }on FirebaseException catch(e){
                      errorMessage = e.message!;
                      print(e);

                    }
                  }
                  setState(() => isLoading= false);
                },
                  child: isLoading ? CircularProgressIndicator(): Text("Log In", style: TextStyle(
                      color: Colors.white
                  ),),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New User?", style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));
                      },
                      child: Text("Register Now",style: TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40,
              width: double.infinity,
              child: Center(
                child: Text(errorMessage, style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),),
              ),)
            ],),
          ),
        ),
      ),
    );
  }
}
