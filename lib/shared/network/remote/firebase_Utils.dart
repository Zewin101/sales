import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../screens/products/models_products/prodacts_model.dart';

class FirebaseUtils {







  CollectionReference<Products_Model> getProductsCollection() {
    return FirebaseFirestore.instance
        .collection(Products_Model.COLLECTION_NAME)
        .withConverter<Products_Model>(
          fromFirestore: (snapshot, options) =>
              Products_Model.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  void addInvoiceInFireBaseFirestore(Products_Model product) {
    var collection = getProductsCollection();
    var docRef = collection.doc();
    product.id = docRef.id;
  }
}
