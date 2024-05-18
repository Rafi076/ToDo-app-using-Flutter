class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'walk', isDone: true),
      ToDo(id: '02', todoText: 'breakfast', isDone: true),
      ToDo(
        id: '03',
        todoText: 'email',
      ),
      ToDo(
        id: '04',
        todoText: 'lunch',
      ),
      ToDo(
        id: '05',
        todoText: 'coffee',
      ),
      ToDo(id: '06', todoText: 'dinner'),
    ];
  }
}
