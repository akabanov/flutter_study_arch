import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:vanilla/src/repo/core/todo_entity.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';

class TodoViewScreen extends StatefulWidget {
  static const k = Key('todo-view-screen');
  static const deleteBtnKey = Key('todo-view-screen-delete-btn');

  const TodoViewScreen({
    super.key = k,
    required this.todo,
    required this.updateTodo,
    required this.removeTodo,
  });

  final TodoEntity todo;
  final TodoAction updateTodo;
  final TodoAction removeTodo;

  @override
  State<TodoViewScreen> createState() => _TodoViewScreenState();
}

class _TodoViewScreenState extends State<TodoViewScreen> {
  late TodoEntity todo;

  @override
  void initState() {
    super.initState();
    todo = widget.todo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View task'),
        actions: [
          IconButton(
            key: TodoViewScreen.deleteBtnKey,
            onPressed: () {
              widget.removeTodo(todo);
              context.pop();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: todo.complete,
              onChanged: (complete) => setState(() {
                todo = todo.copyWith(complete: complete ?? false);
                widget.updateTodo(todo);
              }),
            ),
            Gap(16),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(8),
                Text(
                  todo.task,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Gap(16),
                Text(todo.note),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
