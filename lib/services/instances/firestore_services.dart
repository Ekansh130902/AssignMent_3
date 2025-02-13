
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test3/services/models/user_model.dart';

class FirestoreService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUser(UserModel user) async{
    await _db.collection("users").doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async{
    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    if(doc.exists){
      return UserModel.fromMap(doc.data() as Map<String,dynamic>);
    }
    return null;
  }

}