import 'package:flutter/material.dart';

class GradeCalculatorApp extends StatelessWidget {
  const GradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grade Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const GradeCalculatorScreen(),
    );
  }
}

class GradeCalculatorScreen extends StatefulWidget {
  const GradeCalculatorScreen({super.key});

  @override
  State<GradeCalculatorScreen> createState() => _GradeCalculatorScreenState();
}

class _GradeCalculatorScreenState extends State<GradeCalculatorScreen> {
  final List<TextEditingController> _gradeControllers = List.generate(
    3,
    (_) => TextEditingController(),
  );

  double? _average;
  String? _status;

  @override
  void dispose() {
    for (final controller in _gradeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _calculateAverage() {
    final enteredGrades =
        _gradeControllers.map((controller) => controller.text.trim()).toList();

    if (enteredGrades.any((grade) => grade.isEmpty)) {
      _showValidationError('Please enter all three grades.');
      return;
    }

    final parsedGrades = enteredGrades.map(double.tryParse).toList();
    if (parsedGrades.any((grade) => grade == null || !grade.isFinite)) {
      _showValidationError('Please enter valid numbers for all grades.');
      return;
    }

    final validGrades = parsedGrades.cast<double>();
    final calculatedAverage =
        validGrades.reduce((total, grade) => total + grade) /
            validGrades.length;

    setState(() {
      _average = calculatedAverage;
      _status = calculatedAverage >= 50 ? 'Kalon' : 'Duhet përmirësim';
    });
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grade Calculator'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.calculate_outlined,
                    size: 72,
                    color: Colors.indigo,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Enter Your Grades',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add three numeric grades to calculate your average.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  for (var index = 0;
                      index < _gradeControllers.length;
                      index++) ...[
                    TextField(
                      controller: _gradeControllers[index],
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Grade ${index + 1}',
                        hintText: 'Enter a numeric value',
                        prefixIcon: const Icon(Icons.edit_outlined),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: _calculateAverage,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Calculate Average'),
                  ),
                  if (_average != null && _status != null) ...[
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Average',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _average!.toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _status!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: _average! >= 50
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
