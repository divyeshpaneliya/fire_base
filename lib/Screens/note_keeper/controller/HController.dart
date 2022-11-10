import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class HController extends GetxController{
  RxInt cre_task=1.obs;
  int com_task=0;
  List tname=[];
  bool tsk_check=false;
  RxInt counter = 0.obs;
  RxInt index = 0.obs;

  RxList<modelfire> l1 = <modelfire>[].obs;



  String adddata({String? note,String? key,String? checked}){
    var fdbref=FirebaseDatabase.instance.ref();
    String msg;
    if(key==null){
      fdbref.child('Notes').push().set({'note':note,'checked':checked});
      msg="done";
    }else{
      fdbref.child('Notes').child(key).set({'note':note,'checked':checked});
      msg="done";
    }
    return msg;
  }

  Stream<DatabaseEvent> read_data(){
    var fdbref=FirebaseDatabase.instance.ref();
    return fdbref.child("Notes").onValue;
  }

  void remove(String key){
    var fdbref=FirebaseDatabase.instance.ref();
    fdbref.child("Notes").child(key).remove();
  }

}

class modelfire{
  String? note;
  String? key;
  String? isChecked;
  modelfire({this.note, this.key,this.isChecked});
}