import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presentacion/core/utilities/shared_preferences_util.dart';

SharedPreferencesUtil sharedPreference = new SharedPreferencesUtil();

Future<bool> signIn(String email, String password) async {
  try {

    var isuser = await isDBUser(email);

    if(isuser){
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    }



    return false;

  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

bool isCurrentUser(){
  var user = FirebaseAuth.instance.currentUser;
  if( user != null ) return true;
  return false;
}

Future<bool> isDBUser( String email ) async{
  FirebaseFirestore _db = FirebaseFirestore.instance;
  var users = await _db.collection('Users').where('username' , isGreaterThanOrEqualTo: email ).get().then((snapshot) => snapshot.docs);
  sharedPreference.setUserName(users.first.data()['name']);
  print( users );
  return !users.isEmpty;
}


