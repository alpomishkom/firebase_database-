import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Service1 {
  static var id = TextEditingController();
  static var name = TextEditingController();
  static var phoneNumber = TextEditingController();
  static var address = TextEditingController();
  static var company = TextEditingController();
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<DocumentReference<Map<String, dynamic>>> serviceSV({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    DocumentReference<Map<String, dynamic>> documet =
        await db.collection(collectionPath).add(data);
    return documet;
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> GET(
      {required String collectionPath}) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documets = [];
    await db.collection(collectionPath).get().then(
      (value) {
        for (var doc in value.docs) {
          documets.add(doc);
        }
      },
    );
    return documets;
  }

  static Future<void> DELET(
      {required String collectionPath, required String documentId}) async {
    await db.collection(collectionPath).doc(documentId).delete().then((value) {
      debugPrint("DELET");
    });
  }

  static Future<void> PUT({required String collectionPath, required String documentId, required Map<String,dynamic> data}) async {
    await db.collection(collectionPath).doc(documentId).update(data).then((value) {
      debugPrint("PUT QILDI");
    });
  }
}
