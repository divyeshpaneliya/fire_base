import 'package:fire_base/Screens/author/author_controller/author_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Author extends StatefulWidget {
  const Author({Key? key}) : super(key: key);

  @override
  _AuthorState createState() => _AuthorState();
}

class _AuthorState extends State<Author> {
  TextEditingController Aname = TextEditingController();
  TextEditingController Bname = TextEditingController();
  TextEditingController about_a = TextEditingController();
  TextEditingController about_b = TextEditingController();
  TextEditingController Publish_year = TextEditingController();
  TextEditingController img_link = TextEditingController();

  AController con = Get.put(AController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Browse",
          ),
          actions: [
            // add author
            IconButton(
              onPressed: () {
                adddata();
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: StreamBuilder(
            stream: con.read_data(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                List<modelfire_Author> l1 = [];

                DataSnapshot dataSnapshot = snapshot.data.snapshot;

                for (DataSnapshot data in dataSnapshot.children) {
                  String Author_Name =
                      data.child("Author_name").value.toString();
                  String Book_Name = data.child("Book_name").value.toString();
                  String About_Author =
                      data.child("About_Author").value.toString();
                  String About_Book = data.child("About_Book").value.toString();
                  String Publish_year =
                      data.child("Publish_year").value.toString();
                  String Image_link = data.child("Image_link").value.toString();
                  String key = data.key.toString();

                  modelfire_Author m1 = modelfire_Author(
                    key: key,
                    img_link: Image_link,
                    Aname: Author_Name,
                    Bname: Book_Name,
                    AboutA: About_Author,
                    AboutB: About_Book,
                    PYear: Publish_year,
                  );

                  l1.add(m1);
                }
                // return Text("Hello");
                return ListView.builder(
                    itemCount: l1.length,
                    itemBuilder: (context, index) {
                      return Container(
                      //  color: Colors.red,
                        height: 100,
                        width: 100,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            
                            //data
                            Card(
                              margin: EdgeInsets.only(left: 20),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(),
                                ),
                                padding: EdgeInsets.only(left: 55),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text("${l1[index].Bname}"),
                                    Text("${l1[index].Aname}"),
                                   // Text("${l1[index].AboutA}"),
                                   // Text("${l1[index].AboutB}"),
                                  ],
                                ),
                              ),
                            ),
                            //poster
                            Card(
                              child: Container(
                                height: 85,
                                width: 60,
                                decoration: BoxDecoration(
                                  border: Border(),
                                  //color: Colors.green,
                                ),
                              ),
                            ),
                            
                          ],
                          
                        ),
                      );
                    });
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  void adddata({String? key}) {
    Get.defaultDialog(
      title: "Add Book",
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: Aname,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Author Name"),
              prefixIcon: Icon(Icons.person),
            ),
          ),

          TextField(
            controller: Bname,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Book Name"),
              prefixIcon: Icon(Icons.book),
            ),
          ),
          TextField(
            controller: about_a,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("About Author"),
              prefixIcon: Icon(Icons.edit),
            ),
          ),
          TextField(
            controller: about_b,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Book Name"),
              prefixIcon: Icon(Icons.import_contacts),
            ),
          ),
          TextField(
            controller: Publish_year,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Publish year"),
              prefixIcon: Icon(Icons.calendar_today_outlined),
            ),
          ),
          TextField(
            controller: img_link,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Image Link"),
              prefixIcon: Icon(Icons.image),
            ),
          ),
        ],
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text("Cancel"),
      ),
      confirm: TextButton(
        onPressed: () {
          String data = con.creat_author(
              about_a: about_a.text,
              about_b: about_b.text,
              Aname: Aname.text,
              Bname: Bname.text,
              img_link: img_link.text,
              Publish_year: Publish_year.text,
              key: key);
          if (data == "done") {
            Get.back();
          }
        },
        child: Text("Finish"),
      ),
    );
  }
}
