import 'package:flutter/material.dart';
import 'package:my_diary/data/task.dart';
import 'package:my_diary/routes/route.dart';
import 'package:my_diary/view/detail.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarController _calendarController;
  DateTime date;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final database = Provider.of<TaskDao>(context);
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(top: 36.0, left: 12.0, right: 12.0, bottom: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: height * 0.55,
              width: double.infinity,
              child: TableCalendar(
                headerStyle: HeaderStyle(
                    centerHeaderTitle: true, formatButtonVisible: false),
                calendarController: _calendarController,
                calendarStyle: CalendarStyle(
                  todayColor: Colors.teal,
                  selectedColor: Colors.tealAccent[700],
                  contentPadding: EdgeInsets.all(0),
                ),
                onDaySelected: (dateSelected, list) {
                  print("Tanggal Selected : ${date.day}");
                  setState(() {
                    date = dateSelected;
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: StreamBuilder(
                  stream: database.getAlltask(date),
                  builder: (context, AsyncSnapshot<List<Task>> snapshot) =>
                      ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                    itemBuilder: (context, index) {
                      final itemTask = snapshot.data[index];
                      return _buildList(context, itemTask, database);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Routes.sailor.navigate("/add", params: {
          'date' : date == DateTime.now() ? DateTime.now() : date
        }),
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

Widget _buildList(BuildContext context, Task itemTask, TaskDao database) {
  return GestureDetector(
    onTap: () => Routes.sailor.navigate('/detail', params: {
      'itemTask' : itemTask,
      'title' : itemTask.title,
      'notes' : itemTask.note,
      'date' : itemTask.date
    }),
    child: Container(
      margin: EdgeInsets.only(bottom: 8.0),
      width: double.infinity,
      height: 75.0,
      decoration: BoxDecoration(
          color: Colors.grey[700], borderRadius: BorderRadius.circular(10.0)),
      child: Center(
        child: ListTile(
          leading: GestureDetector(
            onTap: () => database.deleteTask(itemTask),
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          title: Text(
            itemTask.title,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            itemTask.note,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ),
  );
}
