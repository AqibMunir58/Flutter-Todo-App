import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/todo_entity.dart';

class TodoController extends GetxController {
  final RxList<TodoEntity> todos = <TodoEntity>[].obs;
  late Box box;

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  /// Load todos asynchronously from Hive
  Future<void> loadTodos() async {
    box = await Hive.openBox('todos'); // async open
    final storedTodos = box.get('todoList', defaultValue: []);
    todos.value = (storedTodos as List)
        .map(
          (e) => TodoEntity(
            id: e['id'],
            title: e['title'],
            description: e['description'] ?? "",
            isCompleted: e['isCompleted'] ?? false,
          ),
        )
        .toList();
  }

  /// Add todo and return it for AnimatedList
  TodoEntity addTodoAndReturn(String title, String description) {
    final todo = TodoEntity(
      id: DateTime.now().toIso8601String(),
      title: title,
      description: description,
      isCompleted: false,
    );

    todos.add(todo);
    saveToHive();
    return todo;
  }

 void toggleTodo(String id) {
  final index = todos.indexWhere((t) => t.id == id);
  if (index != -1) {
    todos[index] = todos[index].copyWith(
      isCompleted: !todos[index].isCompleted,
    );
    saveToHive();
  }
}

  void deleteTodo(String id) {
    todos.removeWhere((t) => t.id == id);
    saveToHive();
  }

  void saveToHive() {
    final todoMap = todos
        .map(
          (t) => {
            'id': t.id,
            'title': t.title,
            'description': t.description,
            'isCompleted': t.isCompleted,
          },
        )
        .toList();
    box.put('todoList', todoMap);
  }
}
