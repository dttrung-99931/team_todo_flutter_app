import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

abstract class FirestoreService extends GetxService {
  final fs = FirebaseFirestore.instance;
  CollectionReference get collection => getCollection(getCollectionPath());

  CollectionReference getCollection(String name) {
    return fs.collection(name);
  }

  Future<QuerySnapshot> getQuerySnap() async {
    return await fs.collection(getCollectionPath()).get();
  }

  Future<List<DocumentSnapshot>> getAllDocSnaps() async {
    var querysnap = await getQuerySnap();
    return querysnap.docs;
  }

  Future<DocumentSnapshot> getDocSnap(String id) {
    return getDocRef(id).get();
  }

  DocumentReference getDocRef(String id) {
    return collection.doc(id);
  }

  String getCollectionPath();
}
