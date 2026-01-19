import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;
  final String description; // new field

  const TodoEntity({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.description = '',
  });

  TodoEntity copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    String? description,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [id, title, isCompleted, description];
}
