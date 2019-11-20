import 'package:flutter/material.dart';
import 'package:my_diary/data/task.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    String title = Sailor.param<String>(context, 'title');
    String notes = Sailor.param<String>(context, 'notes');
    DateTime date = Sailor.param<DateTime>(context, 'date');
    Task task = Sailor.param<Task>(context, 'itemTask');
    final database = Provider.of<TaskDao>(context);
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(top: 36.0, left: 24.0, right: 24.0, bottom: 8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: title,
              style: TextStyle(fontSize: 28.0),
              decoration: InputDecoration(
                hintText: 'Type your title',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 28.0),
              ),
              onChanged: (val) {
                setState(() {
                  title = val;
                });
              },
            ),
            SizedBox(
              height: 8.0,
            ),
            TextFormField(
              initialValue: notes,
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                hintText: 'Type your note',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 18.0),
              ),
              onChanged: (val) {
                setState(() {
                  notes = val;
                });
                database.updateTask(
                    task.copyWith(title: title, note: notes, date: date));
              },
              onFieldSubmitted: (v) {},
            ),
          ],
        ),
      ),
    );
  }
}
