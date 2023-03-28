import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales/screens/login/model/my_user.dart';
import '../../../models/myUser.dart';
import '../../../screens/products/models_products/category_products.dart';
import '../../../screens/products/models_products/prodacts_model.dart';

class FirebaseUtils {
  /// collection--Users
  static CollectionReference<RodinaKidsUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(RodinaKidsUser.COLLECTION_NAME)
        .withConverter<RodinaKidsUser>(
          fromFirestore: (snapshot, options) =>
              RodinaKidsUser.formJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  /// add user
  static Future<void> addRodinaKidsUserFirestore(
      RodinaKidsUser rodinaKidsUser) {
    return getUserCollection().doc(rodinaKidsUser.id).set(rodinaKidsUser);
  }

  ///read users
  static Future<RodinaKidsUser?> readUserFromFirestore(String id) async {
    DocumentSnapshot<RodinaKidsUser> rodinaKids =
        await getUserCollection().doc(id).get();
    var myRodinaKids = rodinaKids.data();
    return myRodinaKids;
  }

  ///get all Users
  static Future<QuerySnapshot<RodinaKidsUser>>
      readAllUserFromFirestore() async {
    QuerySnapshot<RodinaKidsUser> rodinaKids = await getUserCollection().get();
    return rodinaKids;
  }

  /// collection-- Product
  static CollectionReference<Products_Model> getProductCollection() {
    return FirebaseFirestore.instance.collection(Products_Model.COLLECTION_NAME)
        .withConverter<Products_Model>(
      fromFirestore: (snapshot, options) =>
          Products_Model.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }
  /// add Product

 static Future<void>addProductInCategoryInFireStore(Products_Model productsModel) {
  var docRef=getProductCollection().doc();
  productsModel.id=docRef.id;
  return docRef.set(productsModel);
  }

  /// read product

  static Future<Products_Model?> readProductFromFireStore(String id) async {
    DocumentSnapshot<Products_Model> products =
        await getProductCollection().doc(id).get();
    var Myproduct = products.data();
    return Myproduct;
  }

  /// delete product

  static Future<void> deleteProductFromFirestore(String id){
   return getProductCollection().doc(id).delete();
  }


  ///get all Products
  static Future<QuerySnapshot<Products_Model>> readAllProductsFromFirestore({String? search}) async {
    QuerySnapshot<Products_Model> allProducts =
        await getProductCollection().get(
          GetOptions(source: Source.cache)
        );
    return allProducts;
  }

  /// collection-- Category
  static CollectionReference<CategoryProducts> getCategoryCollection() {
    return FirebaseFirestore.instance
        .collection(CategoryProducts.COLLECTION_NAME)
        .withConverter<CategoryProducts>(
      fromFirestore: (snapshot, options) =>
          CategoryProducts.fromJson(snapshot.data()!),
      toFirestore: (category, options) =>category.toJson(),
    );
  }
  /// add Category
  static Future<void>addCategoryInFireStore(CategoryProducts category) {
    var collection=getCategoryCollection();
    var docRef=collection.doc();
    category.id=docRef.id;
    return docRef.set(category);
  }

  ///get all CategoryProducts
 static Future<QuerySnapshot<CategoryProducts>> readAllCategoryFromFirebaseFirestore()async{
    QuerySnapshot<CategoryProducts> allCategory=await getCategoryCollection().get();
    return allCategory;

  }

}
