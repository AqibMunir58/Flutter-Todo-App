import 'package:flutter/material.dart';
import 'package:flutter_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import 'add_todo_screen.dart';


class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoController controller = Get.put(TodoController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
  }

  /// Add a new todo
  void _addTodo() async {
    // Navigate to AddTodoScreen and get the newly added todo
    final newTodo = await Get.to(() => AddTodoScreen());

    if (newTodo != null) {
      // Insert directly into AnimatedList
      final index = controller.todos.indexOf(newTodo);
      if (index != -1) {
        _listKey.currentState?.insertItem(
          index,
          duration: const Duration(milliseconds: 350),
        );
      }
    }
  }

  /// Delete a todo at a given index
  void _deleteTodoAt(int index) {
    if (index < 0 || index >= controller.todos.length) return;

    final removedTodo = controller.todos[index];

    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: TodoCard(
          todo: removedTodo,
          onToggle: () {},
          onDelete: () {},
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );

    controller.deleteTodo(removedTodo.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('My Todos'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 4,
      ),
      body: Obx(() {
        final todos = controller.todos;

        if (todos.isEmpty) {
          return const Center(
            child: Text(
              'No todos yet 👋\nTap + to add one',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return AnimatedList(
          key: _listKey,
          initialItemCount: todos.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemBuilder: (context, index, animation) {
            if (index < 0 || index >= todos.length) return const SizedBox();
            final todo = todos[index];

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: FadeTransition(
                opacity: animation,
                child: TodoCard(
                  todo: todo,
                  onToggle: () => controller.toggleTodo(todo.id),
                  onDelete: () => _deleteTodoAt(index),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: _addTodo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}



class TodoCard extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoCard({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: todo.isCompleted
              ? [Colors.green.shade200, Colors.green.shade50]
              : [Colors.white, Colors.white],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),

        // ✅ Toggle button
        leading: GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: todo.isCompleted ? Colors.green : Colors.transparent,
              border: Border.all(
                color: todo.isCompleted
                    ? Colors.green
                    : Colors.deepPurple,
                width: 2,
              ),
            ),
            child: todo.isCompleted
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
        ),

        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration:
                todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),

        subtitle: todo.description.isEmpty
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  todo.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),

        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          color: Colors.redAccent,
          onPressed: onDelete,
        ),
      ),
    );
  }
}