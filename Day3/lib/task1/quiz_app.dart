import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What refreshes the UI in Flutter?",
      "options": ["SnackBar", "setState()", "Route", "Navigator"],
      "answer": "setState()",
    },
    {
      "question": "Which widget can change state?",
      "options": [
        "Container",
        "StatefulWidget",
        "Card",
        "Scaffold"
      ],
      "answer": "StatefulWidget",
    },
    {
      "question": "What opens a new screen?",
      "options": [
        "Navigator.push()",
        "Navigator.pop()",
        "SnackBar",
        "AlertDialog"
      ],
      "answer": "Navigator.push()",
    },
    {
      "question": "What returns to the previous screen?",
      "options": [
        "Navigator.push()",
        "setState()",
        "Navigator.pop()",
        "Route"
      ],
      "answer": "Navigator.pop()",
    },
    {
      "question": "What is a Route?",
      "options": [
        "Popup",
        "Screen/Page",
        "List",
        "Database"
      ],
      "answer": "Screen/Page",
    },
  ];

  void answerQuestion(String selectedAnswer) {
    if (selectedAnswer == questions[currentQuestion]["answer"]) {
      score++;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: score,
            totalQuestions: questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var question = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Question ${currentQuestion + 1}/${questions.length}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              question["question"],
              style: const TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            ...(question["options"] as List<String>).map(
              (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => answerQuestion(option),
                    child: Text(option),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Result"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Quiz Completed!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Score: $score / $totalQuestions",
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Restart Quiz"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}