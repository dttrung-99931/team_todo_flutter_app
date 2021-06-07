import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreService extends GetxService {
  final fs = FirebaseFirestore.instance;

  CollectionReference collection(String name) {
    return fs.collection(name);
  }
}
