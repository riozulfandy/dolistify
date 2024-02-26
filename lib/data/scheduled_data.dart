class SceduledTasks {
  String title;
  String description;
  String category;
  DateTime timeStarted;
  DateTime timeEnded;
  bool isFinished;

  SceduledTasks({
    required this.title,
    required this.description,
    required this.category,
    required this.timeStarted,
    required this.timeEnded,
    required this.isFinished,
  });

  getTitle() {
    return title;
  }

  getDescription() {
    return description;
  }

  getCategory() {
    return category;
  }

  getTimeStarted() {
    return timeStarted;
  }

  getTimeEnded() {
    return timeEnded;
  }

  getIsFinished() {
    return isFinished;
  }

  setTitle(String title) {
    this.title = title;
  }

  setDescription(String description) {
    this.description = description;
  }

  setCategory(String category) {
    this.category = category;
  }

  setTimeStarted(DateTime timeStarted) {
    this.timeStarted = timeStarted;
  }

  setTimeEnded(DateTime timeEnded) {
    this.timeEnded = timeEnded;
  }

  setIsFinished(bool isFinished) {
    this.isFinished = isFinished;
  }
}

class SceduledTasksData {
  Map<DateTime, List<SceduledTasks>> tasks = {};
  Map<DateTime, List<SceduledTasks>> getTasks() {
    return tasks;
  }

  List<SceduledTasks> getTasksByDate(DateTime date) {
    return tasks[date]!;
  }

  void addTask(SceduledTasks task) {
    if (tasks[task.getTimeStarted()] == null) {
      tasks[task.getTimeStarted()] = [];
    }
    tasks[task.getTimeStarted()]!.add(task);
  }

  void removeTask(SceduledTasks task) {
    tasks[task.getTimeStarted()]!.remove(task);
  }

  void updateTask(SceduledTasks oldTask, SceduledTasks newTask) {
    tasks[oldTask.getTimeStarted()]!.remove(oldTask);
    addTask(newTask);
  }
}
