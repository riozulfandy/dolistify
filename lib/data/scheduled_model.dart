class ScheduledItem {
  String title;
  String description;
  DateTime date;
  DateTime timeStarted;
  DateTime? timeReminded;
  String category;
  bool isDone;
  ScheduledItem({
    required this.title,
    required this.description,
    required this.date,
    required this.timeStarted,
    required this.timeReminded,
    required this.category,
    required this.isDone,
  });
}
