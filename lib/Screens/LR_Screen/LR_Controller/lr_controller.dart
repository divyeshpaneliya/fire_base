import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class lr_con extends GetxController {
  String msg="";
  Future<String?> creat_user(String email, String password) async{
    var firebaseauth = FirebaseAuth.instance;
    try{
    var res=await firebaseauth.createUserWithEmailAndPassword(email: email, password: password);
      msg="Success";
    } on FirebaseAuthException catch(e){
      if(e.code=="weak-password"){
        msg="Password is too short";
      }else if(e.code=="email-already-in-us"){
        msg="You are already user";
      }
    }
    return msg;
  }

  Future<String> login_user(String email,String password)async{
    var firebaseauth = FirebaseAuth.instance;
    try{
      var res= await firebaseauth.signInWithEmailAndPassword(email: email, password: password);
      msg="Success";
    }on FirebaseAuthException catch (e){
      if(e.code=='user-not-found'){
        msg="No such user found";
      }else if(e.code=='wrong-password'){
        msg="Password is incorrect";
      }
    }
    return msg;
  }

  bool check_user(){
    var firebaseauth = FirebaseAuth.instance;
    var user=firebaseauth.currentUser;
    if(user==null){
      return true;
    }
    else{
      return false;
    }
  }

  void signout(){
    var firebaseauth = FirebaseAuth.instance;
    firebaseauth.signOut();
}
}
