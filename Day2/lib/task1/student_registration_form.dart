import 'package:flutter/material.dart';

class StudentRegistrationForm extends StatefulWidget {
  const StudentRegistrationForm({super.key});

  @override
  State<StudentRegistrationForm> createState() =>
      _StudentRegistrationFormState();
}

class _StudentRegistrationFormState
    extends State<StudentRegistrationForm> {

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final List<Map<String, String>> students = [];

  void addStudent() {

    String name = nameController.text.trim();
    String email = emailController.text.trim();

    if (name.isEmpty) {
      showMessage("Name cannot be empty");
      return;
    }

    if (email.isEmpty) {
      showMessage("Email cannot be empty");
      return;
    }

    if (!email.contains("@")) {
      showMessage("Invalid email");
      return;
    }

    setState(() {
      students.add({
        "name": name,
        "email": email,
      });
    });

    nameController.clear();
    emailController.clear();

    showMessage("Student added successfully");
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Registration"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Student Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: addStudent,
                child: const Text("Add Student"),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: students.length,

                itemBuilder: (context, index) {

                  return Card(
                    child: ListTile(
                      leading:
                          const Icon(Icons.person),

                      title: Text(
                        students[index]["name"]!,
                      ),

                      subtitle: Text(
                        students[index]["email"]!,
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