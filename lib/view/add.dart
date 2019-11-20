import 'package:flutter/material.dart';
import 'package:my_diary/data/task.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:toast/toast.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  String title;
  String notes;
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TaskDao>(context);
    DateTime dateTime = Sailor.param<DateTime>(context, 'date');
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(top: 36.0, left: 24.0, right: 24.0, bottom: 8.0),
        child: Column(
          children: <Widget>[
            TextField(
              style: TextStyle(fontSize: 28.0),
              decoration: InputDecoration(
                hintText: 'What Happen ? ',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 28.0),
              ),
              onChanged: (value){
                setState(() {
                  title = value;
                });
              },
            ),
            SizedBox(height: 8.0,),
            TextField(
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                hintText: 'How your feel today ? ',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 18.0),
              ),
              onChanged: (value){
                setState(() {
                  notes = value;
                });
              },
              onSubmitted: (v){
                final task = Task(
                  date: dateTime,
                  title: title,
                  note: notes
                );
                database.insertTask(task);
                Toast.show("Added to your diary", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
              },
            ),
          ],
        ),
      ),
    );
  }
}
