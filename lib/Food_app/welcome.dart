



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myyapp/Food_app/sign_up.dart';

import 'log_in.dart';

class Welcome extends StatefulWidget {

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child:
            Image.
            network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGeertJftlhCWw7IoesZdabfKHiK9Ok9uDQ&usqp=CAU", fit: BoxFit.cover,)),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Welcome to tastee', style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                ),),
                Column(
                  children: [
                    Text('Order food from our resturent',style: TextStyle(

                        fontWeight: FontWeight.w700
                    ),),
                    Text('Make reseration in real time',style: TextStyle(

                        fontWeight: FontWeight.w700
                    ),),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  height: 40,
                  width: 300,
                  child: RaisedButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey)

                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>LogIn()));
                    },
                    child:  Text("Log In",style: TextStyle(
                      color: Colors.white
                    ),),
                  ),
                ),
                Container(
                  height: 40,
                  width: 300,
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));
                    },
                    child:  Text("Sign Up", style: TextStyle(
                        color: Colors.green
                    ),),
                  ),
                )
              ],
            ),),
          ],
        ),
      ),
    );
  }
}
