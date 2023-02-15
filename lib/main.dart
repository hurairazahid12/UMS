import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ums/models/schedule_model.dart';
import 'package:ums/student.dart';
import 'package:ums/teacher.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ScheduleModelAdapter());
  await Hive.openBox<ScheduleModel>('schedule');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  var sbtn = "Student";
  var tbtn = "Teacher";
  var student = StudentHomePage();
  var teacher = TeacherHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UMS"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(height: 120,),
          Text('Welcome in UMS',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
          SizedBox(height: 20,),
          Image.asset('assets/images/2.png',height: 150, width: 200),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>student ));
              }, child: Text(sbtn)),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>teacher ));
              }, child: Text(tbtn)),
            ],
          ),
        ],
      ),
    );
  }
}
