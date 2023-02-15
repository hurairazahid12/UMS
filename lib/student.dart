import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ums/Boxes/schedule_box.dart';
import 'package:ums/models/schedule_model.dart';

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Side'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Expanded(
              flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Welcome in Student Schedule',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                    SizedBox(height: 10,),
                    Text('Youn can see here your attendance & class schedule!',style: TextStyle( fontSize: 16)),
                  ],
                )),
            ValueListenableBuilder<Box<ScheduleModel>>(
              valueListenable: ScheduleBoxes.getData().listenable(),
              builder: (context, box, _){
                var data = box.values.toList().cast<ScheduleModel>();
                return Expanded(
                  flex: 5,
                  child: ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data[index].subjectName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${data[index].date} | ${data[index].startTime} - ${data[index].endTime}'),
                              Column(
                                children: [
                                  Text('present', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                                  Checkbox(
                                    value: data[index].isPresent,
                                    onChanged: (value) {
                                      setState(() {
                                        data[index].isPresent = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                            Divider(height: 10,),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }

            ),
          ],
        ),
      ),
    );
  }
}
