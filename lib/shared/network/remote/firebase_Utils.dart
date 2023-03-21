import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales/screens/login/model/my_user.dart';
import '../../../models/myUser.dart';
import '../../../screens/products/models_products/prodacts_model.dart';

class FirebaseUtils {
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
   static Future<RodinaKidsUser?> readUserFromFirestore(String id)async {
     DocumentSnapshot<RodinaKidsUser> rodinaKids=await getUserCollection().doc(id).get();
    var myRodinaKids=rodinaKids.data();
    return myRodinaKids;
  }
  ///get all Users
  static Future<QuerySnapshot<RodinaKidsUser>> readAllUserFromFirestore()async {
    QuerySnapshot<RodinaKidsUser> rodinaKids=await getUserCollection().get();
  return rodinaKids;
  }
}
