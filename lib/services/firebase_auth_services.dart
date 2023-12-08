import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> singUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
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
    User? user = _firebaseAuth.currentUser;
    return user?.uid;
  }

  Future<void> singIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print("Şifre sıfırlama e-postası gönderildi.");
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

  Future<void> signOut()async {
    await _firebaseAuth.signOut();
  }

  Future<void> deleteUser()async{
    await _firebaseAuth.currentUser!.delete();
  }

  FirebaseAuth get firebaseAuth=>_firebaseAuth;

}
