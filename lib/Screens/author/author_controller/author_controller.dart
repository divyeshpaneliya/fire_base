import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class AController extends GetxController {

  String creat_author(
      {String? Aname,
      String? Bname,
      String? about_a,
      String? about_b,
      String? Publish_year,
      String? img_link,
      String? key}) {

    var fdbref = FirebaseDatabase.instance.ref();
    String msg;
    fdbref.child('Author').push().set({
        'Author_name': Aname,
        'Book_name': Bname,
        'About_Author': about_a,
        'About_Book': about_b,
        'Publish_year':Publish_year,
        'Image_link':img_link,
      });
      msg = "done";
    return msg;
  }

  Stream<DatabaseEvent> read_data(){
    var fdbref=FirebaseDatabase.instance.ref();
    return fdbref.child("Author").onValue;
  }


}



class modelfire_Author{
  String? Aname;
  String? Bname;
  String? AboutA;
  String? AboutB;
  String? PYear;
  String? img_link;
  String? key;

  modelfire_Author(
      {this.Aname,
      this.Bname,
      this.AboutA,
      this.AboutB,
      this.PYear,
      this.img_link,
      this.key});
}