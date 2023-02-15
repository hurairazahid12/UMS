import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:ums/Boxes/schedule_box.dart';
import 'package:ums/models/schedule_model.dart';


class TeacherHomePage extends StatefulWidget {
  @override
  _TeacherHomePageState createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {

  var data;

  TextEditingController sbjinput = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController starttimeinput = TextEditingController();
  TextEditingController endtimeinput = TextEditingController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Side'),
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Image.asset('assets/images/1.png',height: 150, width: 200),

          SizedBox(height: 20,),
          Expanded(
              flex: 1,
              child: Text('Welcome in Teacher Admin Pannel',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          ValueListenableBuilder<Box<ScheduleModel>>(
            valueListenable: ScheduleBoxes.getData().listenable(),
            builder: (context, box, _){
              var data = box.values.toList().cast<ScheduleModel>();
              return Expanded(
                flex: 5,
                child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index].subjectName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text('${data[index].date} | ${data[index].startTime} - ${data[index].endTime}'),
                                 Row(
                                   children: [
                                     InkWell(
                                         onTap: (){
                                           _delete(data[index]);
                                         },
                                         child: Icon(Icons.delete, size: 20 ,color: Colors.redAccent,)
                                     ),
                                     Switch(
                                       value: data[index].isPresent,
                                       onChanged: (value) {
                                         setState(() {
                                           data[index].isPresent = value;
                                         });
                                       },
                                     ),
                                   ],
                                 ),
                               ],
                             )
                            ],
                          )
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          add();
        },
        child: Icon(Icons.add),
      ),
    );
  }

// **************************** User Define Functions  ************************************//

  void _delete(ScheduleModel scheduleModel) async{
    await scheduleModel.delete();
  }
  Future<void> add() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Schedule'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: sbjinput,
                    decoration: InputDecoration(
                      icon: Icon(Icons.book_outlined), //icon of text field
                        labelText: "Enter Subject Name" //label text of field
                    ),
                  ),
                  TextField(
                      controller: dateinput,
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter Date" //label text of field
                          ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            dateinput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      }),
                  TextField(
              controller: starttimeinput, //editing controller of this TextField
              decoration: InputDecoration(
                  icon: Icon(Icons.timer), //icon of text field
                  labelText: "Start Time" //label text of field
              ),
              readOnly: true,  //set it true, so that user will not able to edit text
              onTap: () async {
                TimeOfDay? pickedTime =  await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                if(pickedTime != null ){
                  print(pickedTime.format(context));   //output 10:51 PM
                  DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                  //converting to DateTime so that we can further format on different pattern.
                  print(parsedTime); //output 1970-01-01 22:53:00.000
                  String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                  print(formattedTime); //output 14:59:00
                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                  setState(() {
                    starttimeinput.text = formattedTime; //set the value of text field.
                  });
                }else{
                  print("Time is not selected");
                }
              },
              ),
                  TextField(
                    controller: endtimeinput, //editing controller of this TextField
                    decoration: InputDecoration(
                        icon: Icon(Icons.timer), //icon of text field
                        labelText: "End Time" //label text of field
                    ),
                    readOnly: true,  //set it true, so that user will not able to edit text
                    onTap: () async {
                      TimeOfDay? pickedTime =  await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if(pickedTime != null ){
                        print(pickedTime.format(context));   //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          endtimeinput.text = formattedTime; //set the value of text field.
                        });
                      }else{
                        print("Time is not selected");
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {

                    data= ScheduleModel(subjectName: sbjinput.text, date: dateinput.text, startTime: starttimeinput.text, endTime: endtimeinput.text, isPresent: true);
                    final box = ScheduleBoxes.getData();
                    box.add(data);
                    data.save();

                    sbjinput.clear();
                    dateinput.clear();
                    starttimeinput.clear();
                    endtimeinput.clear();

                    Navigator.pop(context);
                  },
                  child: Text('Add')),
            ],
          );
        });
  }
}
