import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myyapp/main.dart';
import 'package:myyapp/provider/my_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  late final String image;
  late final String name;
  late final String price;
  late final String quantity;
  DetailScreen({required this.image, required this.name, required this.price});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var quantity = 1;


  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff2b2b2b),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        color: Color(0xff2b2b2b),
                        width: double.infinity,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(widget.image),
                        ),
                      ),
                      Positioned(
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15, top: 20),
                              child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  width: double.infinity,
                  color: Color(0xff383838),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Any time..',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      quantity == 1 ? quantity : quantity--;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    '$quantity ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  child: Text(
                                    quantity == null ? "$quantity": '${(quantity) * int.parse(widget.price)}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text(
                          'Description',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'pizza, dish of Italian origin consisting of a flattened disk of bread dough topped with some combination of olive oil, oregano, tomato, olives, mozzarella or other cheese and many other ingredients, baked quickly—usually, in a commercial setting, using a wood-fired oven heated to a very high temperature—and served hot ...',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                            color: Color(0xff2b2b2b),
                            borderRadius: BorderRadius.circular(15)),
                        child: RaisedButton(
                          padding: EdgeInsets.all(0),
                          color: Color(0xff3e3e3e),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () async {
                            var res = quantity * int.parse(widget.price);
                            await FirebaseFirestore.instance
                                .collection("add_to_cart")
                                .doc()
                                .set({
                              'image': widget.image,
                              'name': widget.name,
                              'price': widget.price,
                              'result': res
                            }).then((value) {
                              flutterToast(Colors.white, Colors.green,
                                  "Product added to cart");
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart, color: Colors.white),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Text(
                                  'Add to cart',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Widget bottomContainer({required Function onTab,required String image, required String name, required String price}) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 10),
  //     decoration: BoxDecoration(
  //         color: Color(0xff3e3e3e), borderRadius: BorderRadius.circular(10)),
  //     // height: 270,
  //     // width: 220,
  //     width: MediaQuery.of(context).size.width * 0.43,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         CircleAvatar(
  //           radius: 60,
  //           backgroundColor: Colors.transparent,
  //           backgroundImage: NetworkImage (image),
  //         ),
  //         ListTile(
  //           leading: Text(
  //             name,
  //             style:
  //             TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
  //           ),
  //           trailing: Text(
  //             price,
  //             style:
  //             TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(left: 15, bottom: 5),
  //           child: Row(
  //             children: [
  //               Icon(
  //                 Icons.star,
  //                 color: Colors.white,
  //               ),
  //               Icon(
  //                 Icons.star,
  //                 color: Colors.white,
  //               ),
  //               Icon(
  //                 Icons.star,
  //                 color: Colors.white,
  //               ),
  //               Icon(
  //                 Icons.star,
  //                 color: Colors.white,
  //               ),
  //               Icon(
  //                 Icons.star,
  //                 color: Colors.white,
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
