import 'package:dolistify/data/scheduled_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScheduledData {
  final _box = Hive.box('myBox');
  Map<DateTime, List<ScheduledItem>> scheduledOnDate = {};

  void addScheduled(ScheduledItem scheduledItem) {
    scheduledOnDate[scheduledItem.date] =
        scheduledOnDate[scheduledItem.date] ?? [];
    scheduledOnDate[scheduledItem.date]!.add(scheduledItem);
  }

  void removeScheduled(ScheduledItem scheduledItem) {
    scheduledOnDate[scheduledItem.date]!.remove(scheduledItem);
  }

  void updateScheduled(ScheduledItem oldScheduled, ScheduledItem newScheduled) {
    for (var scheduled in scheduledOnDate[oldScheduled.date]!) {
      if (scheduled.title == oldScheduled.title &&
          scheduled.description == oldScheduled.description &&
          scheduled.date == oldScheduled.date &&
          scheduled.timeStarted == oldScheduled.timeStarted &&
          scheduled.timeReminded == oldScheduled.timeReminded &&
          scheduled.category == oldScheduled.category &&
          scheduled.isDone == oldScheduled.isDone) {
        scheduledOnDate[oldScheduled.date]!.remove(scheduled);
        break;
      }
    }
    scheduledOnDate[newScheduled.date] =
        scheduledOnDate[newScheduled.date] ?? [];
    scheduledOnDate[newScheduled.date]!.add(newScheduled);
  }

  void loadData() {
    Map? scheduledOnDateFormated = _box.get('scheduledOnDate');

    if (scheduledOnDateFormated != null) {
      for (var date in scheduledOnDateFormated.keys) {
        List<ScheduledItem> scheduledOnDateFormatedList = [];
        for (var scheduled in scheduledOnDateFormated[date]) {
          scheduledOnDateFormatedList.add(ScheduledItem(
            title: scheduled["title"],
            description: scheduled["description"],
            date: scheduled["date"],
            timeStarted: scheduled["timeStarted"],
            timeReminded: scheduled["timeReminded"],
            category: scheduled["category"],
            isDone: scheduled["isDone"],
          ));
        }
        scheduledOnDate[date] = scheduledOnDateFormatedList;
      }
    }
  }

  void updateData() {
    Map scheduledOnDateFormated = {};

    for (var date in scheduledOnDate.keys) {
      List scheduledOnDateFormatedList = [];
      for (var scheduled in scheduledOnDate[date]!) {
        scheduledOnDateFormatedList.add({
          "title": scheduled.title,
          "description": scheduled.description,
          "date": scheduled.date,
          "timeStarted": scheduled.timeStarted,
          "timeReminded": scheduled.timeReminded,
          "category": scheduled.category,
          "isDone": scheduled.isDone,
        });
      }
      scheduledOnDateFormated[date] = scheduledOnDateFormatedList;
    }
    _box.put('scheduledOnDate', scheduledOnDateFormated);
  }

  void initialData() {
    ScheduledItem scheduledItem = ScheduledItem(
      title: "Your first scheduled",
      description: "Your first scheduled description",
      date: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      timeStarted: DateTime.now(),
      timeReminded: null,
      category: "Work",
      isDone: false,
    );
    ScheduledItem scheduledItem2 = ScheduledItem(
      title: "Your second scheduled",
      description: "Your second scheduled description",
      date: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      timeStarted: DateTime.now(),
      timeReminded: null,
      category: "Study",
      isDone: false,
    );
    addScheduled(scheduledItem);
    addScheduled(scheduledItem2);
  }
}
