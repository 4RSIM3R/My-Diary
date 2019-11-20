import 'package:moor_flutter/moor_flutter.dart';
part 'task.g.dart';

class Tasks extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get note => text()();
  DateTimeColumn get date => dateTime()();
}

@UseMoor(tables : [Tasks], daos: [TaskDao])
class TasksDatabase extends _$TasksDatabase {
  TasksDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(
    path : 'db.sqlite', logStatements: true
  ));

  @override
  int get schemaVersion => 1;


}
    //DAO Here
@UseDao(tables : [Tasks])
class TaskDao extends DatabaseAccessor<TasksDatabase> with _$TaskDaoMixin {
  final TasksDatabase db;
  TaskDao(this.db) : super(db);
  //And here the magic of moor
  //TODO :  Replace with where
  Stream<List<Task>> getAlltask(DateTime date){
    return (
      select(tasks)..where((t) => t.date.day.equals(date.day))
      ..where((t) => t.date.month.equals(date.month))
      ..where((t) => t.date.year.equals(date.year))
    ).watch();
  } 
  Future insertTask(Insertable<Task> task) => into(tasks).insert(task);
  Future updateTask(Insertable<Task> task) => update(tasks).replace(task);
  Future deleteTask(Insertable<Task> task) => delete(tasks).delete(task);

}