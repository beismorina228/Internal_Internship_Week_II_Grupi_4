import 'package:flutter/material.dart';

void main() {
  runApp(const TaskTrackerApp());
}

class TaskItem {
  String title;
  bool completed;

  TaskItem({
    required this.title,
    this.completed = false,
  });
}

class TaskTrackerApp extends StatelessWidget {
  const TaskTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskTrackerScreen(),
    );
  }
}

class TaskTrackerScreen extends StatefulWidget {
  const TaskTrackerScreen({super.key});

  @override
  State<TaskTrackerScreen> createState() => _TaskTrackerScreenState();
}

class _TaskTrackerScreenState extends State<TaskTrackerScreen> {
  final List<TaskItem> tasks = [];

  final TextEditingController controller = TextEditingController();

  void addTask() {
    if (controller.text.trim().isEmpty) {
      return;
    }

    setState(() {
      tasks.add(
        TaskItem(title: controller.text.trim()),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Task Added"),
      ),
    );

    controller.clear();
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Task Deleted"),
      ),
    );
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].completed =
          !tasks[index].completed;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Status Updated"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int completedCount =
        tasks.where((task) => task.completed).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Tracker"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Task Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addTask,
                child: const Text("Add Task"),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              "Total Tasks: ${tasks.length}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Completed: $completedCount",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: tasks[index].completed,
                        onChanged: (value) {
                          toggleTask(index);
                        },
                      ),
                      title: Text(
                        tasks[index].title,
                        style: TextStyle(
                          decoration:
                              tasks[index].completed
                                  ? TextDecoration
                                      .lineThrough
                                  : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                        ),
                        onPressed: () {
                          deleteTask(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}