



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myyapp/Food_app/homeSc.dart';
import 'package:myyapp/Food_app/log_in.dart';
import 'package:myyapp/provider/my_provider.dart';
import 'package:provider/provider.dart';
import 'Food_app/welcome.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}
flutterToast(Color color, Color backColor, String mesg){
  Fluttertoast.showToast(
      msg: mesg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backColor,
      textColor: color,
      fontSize: 16.0
  );
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> MyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (
            BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.hasData){
                return HomeScreen();
              }else{
                return LogIn();
              }
        },)
      ),
    );
  }
}
