import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> singUp(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        print('Şifre çok zayıf.');
      } else if (e.code == 'email-already-in-use') {
        print('Bu mail kullanılıyor.');
      }
    } catch (e) {
      print(e);
    }
  }

  String? getUserUid() {
    User? user = firebaseAuth.currentUser;
    return user?.uid;
  }

  Future<void> singIn (String email, String password) async {
    try{
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch(e){
      if(e.code=='user-not-found'){
        print('Mail adresiniz kayıtlı değil.');
      }else if (e.code=='wrong-password') {
        print('Şifreniz yanlış.');
      }
    }
  }


  Future<void> signOut()async {
    await firebaseAuth.signOut();
  }


}
