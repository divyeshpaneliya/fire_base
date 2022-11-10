import 'package:fire_base/utils/space.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:intl/intl.dart';

import '../../../utils/colors.dart';
import '../controller/HController.dart';

class note_keeper extends StatefulWidget {
  const note_keeper({Key? key}) : super(key: key);

  @override
  _note_keeperState createState() => _note_keeperState();
}

class _note_keeperState extends State<note_keeper> {
  HController con = Get.put(HController());
  TextEditingController note = TextEditingController();

  var formatter;
  var month;
  var day;
  String checked="false";

  @override
  void initState() {
    super.initState();
    formatter = DateFormat('MMM');
    month = formatter.format(DateTime.now());
    day = DateFormat('EEEE').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Note-Keeper"),),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //weekday
                    Text(
                      "${day},",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    //day
                    Text(
                      "${DateTime.now().day}",
                      style: TextStyle(fontSize: 25),
                    ),
                    //month
                    Text(
                      "${month}",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                H(25),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     //created task
                //     Column(
                //       // mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //
                //         //Obx(()=>Text("${con.counter}"),),
                //         GetBuilder<HController>(init: HController(),builder: (controller)=>Text("${controller.counter}"),),
                //         //con.cre_task
                //         Text(
                //           "Created tasks",
                //           style: TextStyle(color: grey),
                //         ),
                //       ],
                //     ),
                //     //completed task
                //     Column(
                //       children: [
                //         Obx(()=>Text("${con.com_task}"),),
                //         Text(
                //           "Completed tasks",
                //           style: TextStyle(color: grey),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                H(25),
                Expanded(
                  child: StreamBuilder(
                    stream: con.read_data(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {

                        con.l1.value.clear();
                        List<modelfire> temp= [];
                        DataSnapshot dataSnapshot = snapshot.data.snapshot;
                        con.com_task=0;
                        for (DataSnapshot data in dataSnapshot.children) {
                          String note = data.child("note").value.toString();
                          String checked = data.child("checked").value.toString();
                          if(checked=="true"){
                            con.com_task++;
                          }
                          String key = data.key.toString();

                          modelfire m1 = modelfire(note: note, key: key,isChecked: checked);
                          temp.add(m1);

                        }
                        con.l1=temp.obs;

                        return Column(
                          children: [
                            Container(
                              height: 50,
                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  //created task
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      //Obx(()=>Text("${con.counter}"),),
                                      Text("${con.l1.length}"),
                                      //con.cre_task
                                      Text(
                                        "Created tasks",
                                        style: TextStyle(color: grey),
                                      ),
                                    ],
                                  ),
                                  //completed task
                                  Column(
                                    children: [
                                      Text("${con.com_task}"),
                                      Text(
                                        "Completed tasks",
                                        style: TextStyle(color: grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: con.l1.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        // ==>check box
                                        leading:  Checkbox(
                                            value: con.l1[index].isChecked=="true"?true:false ,
                                            onChanged: (bool? value) {
                                              checked=value!.toString();
                                              con.adddata(key:con.l1[index].key,checked: checked,note: con.l1[index].note);

                                            },
                                          ),
                                        // ==>notes
                                        title: Text(
                                          "${con.l1[index].note}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        // ==>task
                                        trailing: SizedBox(
                                          width: 100,
                                          child: Row(
                                            children: [
                                              //==>edit button
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    note = TextEditingController(text: con.l1[index].note);
                                                  });
                                                  adddata(key: con.l1[index].key);
                                                },
                                                icon: Icon(Icons.edit),
                                              ),
                                              //==>remove button
                                              IconButton(
                                                onPressed: () {
                                                  con.remove(con.l1[index].key!);
                                                },
                                                icon: Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            note.clear();
            adddata();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void adddata({String? key}) {
    Get.defaultDialog(
      title: "Create Note",
      content: Column(
        children: [
          TextField(
            controller: note,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Note"),
              prefixIcon: Icon(Icons.insert_drive_file),
            ),
          ),
        ],
      ),
      cancel: Card(
        child: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Cancel"),
        ),
      ),
      confirm: Card(
        child: TextButton(
          onPressed: () {
         String data = con.adddata(note: note.text, key: key,checked: "false");
         if(data=="done"){
           Get.back();
         }
          },
          child: Text("Create"),
        ),
      ),
    );
  }

}


