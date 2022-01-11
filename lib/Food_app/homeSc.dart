import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myyapp/models/categories_model.dart';
import 'package:myyapp/provider/my_provider.dart';
import 'package:myyapp/screens/all.dart';
import 'package:myyapp/screens/burger_Screen.dart';
import 'package:myyapp/screens/detail_screen.dart';
import 'package:myyapp/screens/pizza_screen.dart';
import 'package:myyapp/screens/recpie_screen.dart';
import 'package:provider/provider.dart';

import 'drawer_function.dart';
import 'log_in.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);

    ///Burger list getting
    provider.getBurgerCategory();
    burgerList = provider.throwBurgerList;

    ///pizza list getting
    pizzaList = provider.throwPizzaList;
    provider.getPizzaCategory();

    ///recipe list getting
    recipeList = provider.throwRecipeList;
    provider.getRecipeCategory();

    ///all list getting
    allList = provider.throwAllList;
    provider.getAllCategory();

    ///single Food list getting
    // singleFood = provider.throwFoodModelListSingle;
    // provider.getSingleFoodList();
    return Scaffold(
      key: _key,
      backgroundColor: Color(0xff2b2b2b),
      drawer: Drawer(
          child: DrawerWid()),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Color(0xff2b2b2b),
        title: GestureDetector(
            onTap: () {
              _key.currentState!.openDrawer();
            },
            child: Icon(Icons.sort)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CircleAvatar(
              // radius: 20,
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtBnl_BvkYiPuzZWj_tpe-9SMBW_SC6MFFdA&usqp=CAU'),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "search food",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Color(0xff3e3e3e),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xff3e3e3e)))),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) =>BurgerScreen()));
                  },
                    child: burger()),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>pizzaScreen()));
                    },
                    child: pizza()),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>RecpieScreen()));
                    },
                    child: recipe()),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>AllScreen()));
                    },
                    child: all()),
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("items").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return GridView.builder(
                  shrinkWrap: false,
                  itemCount: snapshot.data.docs.length,
                  primary: false,
                  physics: ScrollPhysics(),
                  padding: EdgeInsets.all(20),
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot dcoument = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) =>DetailScreen(
                          image: dcoument['image'],
                          name: dcoument['name'],
                          price: dcoument['price'],
                        )));
                      },
                      child: bottomContainer(
                          image: dcoument['image'],
                          name: dcoument['name'],
                          price: dcoument['price']),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 0.7),
                );
              }
            },
          ))
        ],
      ),
    );
  }

  bool isLoading = false;

  Widget categoriesContainer({required String image, required String name}) {
    return Column(
      children: [
        Container(
          // height: 80,
          // width: 80,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            name,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
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
              backgroundImage: NetworkImage(image),
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

  List<CategoriesModel> burgerList = [];
  List<CategoriesModel> pizzaList = [];
  List<CategoriesModel> recipeList = [];
  List<CategoriesModel> allList = [];
  // List<FoodModel> singleFood = [];
  Widget burger() {
    return Row(
      children: burgerList
          .map((e) => categoriesContainer(name: e.name, image: e.image))
          .toList(),
    );
  }

  ///pizza list////
  Widget pizza() {
    return Row(
      children: pizzaList
          .map((e) => categoriesContainer(name: e.name, image: e.image))
          .toList(),
    );
  }

  ///recipe list///
  Widget recipe() {
    return Row(
      children: recipeList
          .map((e) => categoriesContainer(name: e.name, image: e.image))
          .toList(),
    );
  }

  ///all items list///
  Widget all() {
    return Row(
      children: allList
          .map((e) => categoriesContainer(name: e.name, image: e.image))
          .toList(),
    );
  }

  /// single Food List///

}
