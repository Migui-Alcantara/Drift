import 'package:flutter/material.dart';
import '../data/todo_task.dart';

class TodoScreen extends StatefulWidget {
  final List<TodoTask> tasks;
  final Function(int) onToggle;
  final Function(int) onDelete;
  final Future<void> Function() onAdd;

  const TodoScreen({
    super.key,
    required this.tasks,
    required this.onToggle,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Column(
      children: [
        // Fixed header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              _dragHandle(),

              const SizedBox(height: 16),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'To-do',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),

        // Scrollable task list
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                if (widget.tasks.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        'No tasks yet.',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                else
                  ...List.generate(
                    widget.tasks.length,
                    (index) => _todoRow(index),
                  ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),

        // Fixed add-task button
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          child: GestureDetector(
            onTap: () async {
              await widget.onAdd();
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1117),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Color(0xFFA78BFA),
                  ),

                  SizedBox(width: 12),

                  Text(
                    'Add a new task...',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _dragHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _todoRow(int index) {
    final task = widget.tasks[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1117),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              widget.onToggle(index);

              setState(() {});
            },
            child: Icon(
              task.completed
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: const Color(0xFFA78BFA),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              task.text,
              style: TextStyle(
                color: task.completed
                    ? Colors.white54
                    : Colors.white,
                fontSize: 14,
                decoration: task.completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: Colors.white54,
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              widget.onDelete(index);

              setState(() {});
            },
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.white54,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
