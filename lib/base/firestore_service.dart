import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

abstract class FirestoreService extends GetxService {
  final fs = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> get collection =>
      getCollection(getCollectionPath());

  CollectionReference<Map<String, dynamic>> getCollection(String name) {
    return fs.collection(name);
  }

  Query<Map<String, dynamic>> getCollectionGroup(String name) {
    return fs.collectionGroup(name);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getQuerySnap() async {
    return await fs.collection(getCollectionPath()).get();
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getAllDocSnaps() async {
    var querysnap = await getQuerySnap();
    return querysnap.docs;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocSnap(String id) {
    return getDocRef(id).get();
  }

  DocumentReference<Map<String, dynamic>> getDocRef(String id) {
    return collection.doc(id);
  }

  String getCollectionPath();
}
