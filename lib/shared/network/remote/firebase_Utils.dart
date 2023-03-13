import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sales/models/InvoiceItem.dart';

class FirebaseUtils{

  CollectionReference<InvoiceItem> getCollection(){
return FirebaseFirestore.instance.collection(InvoiceItem.COLLECTION).
withConverter<InvoiceItem>(
    fromFirestore: (snapshot, options) =>InvoiceItem.fromJson(snapshot.data()!) ,
    toFirestore: (value, options) => value.toJson(),);
  }
}

