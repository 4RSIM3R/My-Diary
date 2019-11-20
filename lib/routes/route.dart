import 'package:my_diary/data/task.dart';
import 'package:my_diary/view/add.dart';
import 'package:my_diary/view/detail.dart';
import 'package:my_diary/view/homepage.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static final sailor = Sailor();

  static void generateRoutes() {
    sailor.addRoutes([
      SailorRoute(
          name: "/home",
          builder: (context, args, params) {
            return MyHomePage();
          }),
      SailorRoute(
          name: "/add",
          builder: (context, args, params) {
            final date = params.param('date');
            return Add();
          },
          params: [
            SailorParam<DateTime>(
              name: 'date'
            )
          ]
          ),
      SailorRoute(
        name: "/detail",
        builder: (context, args, params) {
          final itemTask = params.param('itemTask');
          final title = params.param('title');
          final notes = params.param('notes');
          final date = params.param('date');
          return Detail();
        },
        params: [
          SailorParam<Task>(
            name: 'itemTask',
          ),
          SailorParam<String>(
            name: 'title',
          ),
          SailorParam<String>(
            name: 'notes',
          ),
          SailorParam<DateTime>(
            name: 'date',
          ),

        ],
      ),
    ]);
  }
}
