import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/todo/presentation/screens/todo_screen.dart';
import '../../features/todo/presentation/screens/add_todo_screen.dart';

class AppRoutes {
  static const todo = '/';
  static const addTodo = '/add-todo';

  static GoRouter router = GoRouter(
    initialLocation: todo,
    routes: [
      GoRoute(
        path: todo,
        builder: (context, state) => const TodoScreen(),
      ),
      GoRoute(
        path: addTodo,
        builder: (context, state) => AddTodoScreen(),
      ),
    ],
  );
}