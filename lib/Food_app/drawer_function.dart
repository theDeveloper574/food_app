
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myyapp/main.dart';
import 'package:myyapp/screens/add_to_cart_Screen.dart';

import 'log_in.dart';

class DrawerWid extends StatefulWidget {

  @override
  _DrawerWidState createState() => _DrawerWidState();
}

class _DrawerWidState extends State<DrawerWid> {
  late final User _user;
  late final DocumentSnapshot _userData;

  @override
  void initState() {
    super.initState();
    _initUser();
    setState(() {
    });
  }

  void _initUser() async {
    _user = FirebaseAuth.instance.currentUser!;
    try {
      _userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .get();
      print(_user.email);
    } catch (e) {
      print("something went wrong");
    }
  }
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color(0xff3e3e3e), //This will change the drawer background to blue.
        //other styles
      ),
      child: Drawer(
        child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff525252),
                      boxShadow: [
                        // BoxShadow(
                        //   color: Color(0xff525252),
                        //    offset: Offset.fromDirection(0.9),
                        //   blurRadius: 9
                        // )
                      ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtBnl_BvkYiPuzZWj_tpe-9SMBW_SC6MFFdA&usqp=CAU'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 5),
                                child: Text("Welcome!", style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                ),),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width *0.3,),
                              _user == null ? Text("Null"):
                              Padding(
                                padding: const EdgeInsets.only(left: 5, bottom: 20,top: 5),
                                child: Text('${_user.email}', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700
                                ),),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person, color: Colors.white,size: 30,),
                        title: Text("Profile",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18
                        ),),
                      ),
                      InkWell(
                        onTap:()=>
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>AddToCart())),
                        child: ListTile(
                          leading: Icon(Icons.backpack_outlined, color: Colors.white,size: 30,),
                          title: Text("Cart Items",style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18
                          ),),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.backpack_outlined, color: Colors.white,size: 30,),
                        title: Text("Order",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18
                        ),),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_balance_wallet_outlined, color: Colors.white,size: 30,),
                        title: Text("About",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18
                        ),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      Divider(color: Colors.white,thickness: 2,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        child: Text("Communications", style: TextStyle(
                            color: Colors.white,
                            fontSize: 19
                        ),),
                      ),
                      ListTile(
                        leading: Icon(Icons.lock, color: Colors.white,size: 30,),
                        title: Text("Change",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18
                        ),),
                      ),
                      GestureDetector(
                        onTap: ()async{
                          setState(() {
                            isLoading =true;
                          });
                          flutterToast(Colors.white, Colors.red, "Log Out Successful");
                          await FirebaseAuth.instance.signOut().then((value){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>LogIn()));
                          });
                          setState(() {
                            isLoading =false;
                          });
                        },
                        child: ListTile(
                          leading: Icon(Icons.account_balance_wallet, color: Colors.white,size: 30,),
                          title: Text("Log Out",style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18
                          ),),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        ),
      )
    );
  }
}