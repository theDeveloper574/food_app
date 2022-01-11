








import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecpieScreen extends StatefulWidget {
  @override
  _RecpieScreenState createState() => _RecpieScreenState();
}

class _RecpieScreenState extends State<RecpieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2b2b2b),
        elevation: 0.0,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      backgroundColor: Color(0xff2b2b2b),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("foodCategories").doc('W2VKEayLjtbpQYlYsHc0').collection("recpie").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }else{
            return GridView.builder(
              shrinkWrap: false,
              itemCount:snapshot==null? 0: snapshot.data.docs.length,
              primary: false,
              physics: ScrollPhysics(),
              padding: EdgeInsets.all(20),
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data.docs[index];
                return bottomContainer(image: document['image'], name: document['name'], price: document['price']);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.7
              ),
            );
          }
        },
      ),
    );
  }
  Widget bottomContainer({required String image, required String name, required String price}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xff3e3e3e), borderRadius: BorderRadius.circular(10)),
      // height: 270,
      // width: 220,
      width: MediaQuery.of(context).size.width * 0.43,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage (image),
          ),
          ListTile(
            leading: Text(
              name,
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
            trailing: Text(
              price,
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
