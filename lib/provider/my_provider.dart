import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myyapp/models/cart_model.dart';
import 'package:myyapp/models/categories_model.dart';
import 'package:myyapp/models/food_categories_model.dart';
import 'package:myyapp/models/food_model.dart';

class MyProvider extends ChangeNotifier {
  List<CategoriesModel> burgerList = [];
  CategoriesModel? burgerModel;
  Future<void> getBurgerCategory() async {
    List<CategoriesModel> NewburgerList = [];
    QuerySnapshot querySnapshot = (await FirebaseFirestore.instance
        .collection('categories')
        .doc('bnPBtSiJ82dghaWtalsq')
        .collection('burger')
        .where('id', isEqualTo: 't4Sp2bYf4Ipb3qEESe2F')
        .get());
    querySnapshot.docs.forEach((element) {
      burgerModel =
          CategoriesModel(image: element['image'], name: element['name']);
      NewburgerList.add(burgerModel!);
      burgerList = NewburgerList;
    });
    notifyListeners();
  }

  get throwBurgerList {
    return burgerList;
  }

  ////////////////////////// 2nd Pizza List///////////
  List<CategoriesModel> pizzaList = [];
  CategoriesModel? pizzaModel;
  Future<void> getPizzaCategory() async {
    List<CategoriesModel> newPizzaList = [];
    QuerySnapshot querySnapshot = (await FirebaseFirestore.instance
        .collection('categories')
        .doc('bnPBtSiJ82dghaWtalsq')
        .collection('pizza')
        .where('id', isEqualTo: 'Fywyu8fnJaD2mO5LCyua')
        .get());
    querySnapshot.docs.forEach((element) {
      pizzaModel =
          CategoriesModel(image: element['image'], name: element['name']);
      newPizzaList.add(pizzaModel!);
      pizzaList = newPizzaList;
    });
    notifyListeners();
  }

  get throwPizzaList {
    return pizzaList;
  }

  ////////////recipe list 3rd////////

  List<CategoriesModel> recipeList = [];
  CategoriesModel? recipeModel;
  Future<void> getRecipeCategory() async {
    List<CategoriesModel> newRecipeList = [];
    QuerySnapshot querySnapshot = (await FirebaseFirestore.instance
        .collection('categories')
        .doc('bnPBtSiJ82dghaWtalsq')
        .collection('recipe')
        .where('id', isEqualTo: 'pR9xUTI1tcbdXFbr6Vl7')
        .get());
    querySnapshot.docs.forEach((element) {
      recipeModel =
          CategoriesModel(image: element['image'], name: element['name']);
      newRecipeList.add(recipeModel!);
      recipeList = newRecipeList;
    });
    notifyListeners();
  }

  get throwRecipeList {
    return recipeList;
  }

  //////////////all categories model 4th/////////

  List<CategoriesModel> allList = [];
  CategoriesModel? allModel;
  Future<void> getAllCategory() async {
    List<CategoriesModel> newRecipeList = [];
    QuerySnapshot querySnapshot = (await FirebaseFirestore.instance
        .collection('categories')
        .doc('bnPBtSiJ82dghaWtalsq')
        .collection('all')
        .where('id', isEqualTo: '4HfkRu1MYaqNr1U1rqBH')
        .get());
    querySnapshot.docs.forEach((element) {
      allModel =
          CategoriesModel(image: element['image'], name: element['name']);
      newRecipeList.add(allModel!);
      allList = newRecipeList;
    });
    notifyListeners();
  }

  get throwAllList {
    return allList;
  }

  /////////5th for food_model category////////
  /////////Single Food Item ////////////

  // List<FoodModel> foodModelList = [];
  // late FoodModel foodModel;
  // Future<void> getSingleFoodList() async {
  //   List<FoodModel> newFoodModelList = [];
  //   QuerySnapshot querySnapshot =
  //       await FirebaseFirestore.instance.collection("items").get();
  //   querySnapshot.docs.forEach((e) {
  //     foodModel = FoodModel(image: e['image'], name: e['name'], price: e['price']);
  //   });
  //   newFoodModelList.add(foodModel);
  //   foodModelList = newFoodModelList;
  //   notifyListeners();
  // }
  // get throwFoodModelListSingle{
  //   return foodModelList;
  // }

  ///getting food categories list///

  List<FoodCategoriesModel> burgerFoodCategoriesList = [];
  late FoodCategoriesModel burgerFoodCategoriesModel;
  Future<void> getBurgerCategooriesListFoodCategories() async {
    List<FoodCategoriesModel> newBurgerFoodCategoriesList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("collectionPath").get();
    querySnapshot.docs.forEach((e) {
      burgerFoodCategoriesModel = FoodCategoriesModel(
          image: e['image'], name: e['name'], price: e['price']);
    });
    newBurgerFoodCategoriesList.add(burgerFoodCategoriesModel);
    burgerFoodCategoriesList = newBurgerFoodCategoriesList;
  }

  get throwBurgerFoodCategoriesList {
    return burgerFoodCategoriesList;
  }

  /// add to cart model class///
  List<CartModel> cartList = [];
  List<CartModel> newCartList = [];
  CartModel? cartModel;
  void addToCart(
      {required String image,
      required String name,
      required String price,
      required String quantity}) {
      cartModel = CartModel(image: image, name: name, price: price, quantity: quantity);
      newCartList.add(cartModel!);
      cartList = newCartList;

  }
  get throwCartList{
    return cartList;
  }
}
