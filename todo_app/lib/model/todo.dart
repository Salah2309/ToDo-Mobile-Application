class ToDo {
  //WARN: with enough time passed epoch time can pass Int size!
  //Crash ETA: January 19, 2038. 3:14:01 AM GMT
  int? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });
  static List<ToDo> todoList() {
    // populate list via API
    return [
      ToDo(id: 10, todoText: 'Kill a rat', isDone: true),
      ToDo(id: 9, todoText: 'Climb Mountain Everst'),
      ToDo(id: 8, todoText: 'Chill'),
      ToDo(id: 7, todoText: 'Code'),
      ToDo(id: 6, todoText: 'Dinner', isDone: true),
      ToDo(id: 5, todoText: 'Work Out',),
      ToDo(id: 4, todoText: 'Team Meeting',),
      ToDo(id: 3, todoText: 'Check Emails', isDone: true),
      ToDo(id: 2, todoText: 'Buy Groceries', isDone: true),
      ToDo(id: 1, todoText: 'Morning Exercise', isDone: true),
    ];
  }
}
