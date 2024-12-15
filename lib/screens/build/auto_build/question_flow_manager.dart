import 'package:flutter/material.dart';
import 'questions/budget.dart';
import 'questions/use_case_screen.dart';
import 'questions/space_constraint_screen.dart';
import 'questions/noise_preference_screen.dart';
import 'questions/environment_screen.dart';
import 'questions/usage_pattern_screen.dart';
import 'questions/future_proofing_screen.dart';
import 'questions/special_requirements_screen.dart';
import 'questions/peripherals_screen.dart';

class QuestionFlowManager extends StatefulWidget {
  const QuestionFlowManager({super.key});

  @override
  State<QuestionFlowManager> createState() => _QuestionFlowManagerState();
}

class _QuestionFlowManagerState extends State<QuestionFlowManager> {
  int currentQuestionIndex = 0;
  final Map<String, dynamic> answers = {};

  final List<Widget> questions = [];

  @override
  void initState() {
    super.initState();
    _initializeQuestions();
  }

  void _initializeQuestions() {
    questions.addAll([
      BudgetScreen(onNext: (data) => _handleAnswer('budget', data)),
      UseCaseScreen(onNext: (data) => _handleAnswer('useCase', data)),
      SpaceConstraintScreen(onNext: (data) => _handleAnswer('spaceConstraints', data)),
      NoisePreferenceScreen(onNext: (data) => _handleAnswer('noisePreferences', data)),
      EnvironmentScreen(onNext: (data) => _handleAnswer('environment', data)),
      UsagePatternScreen(onNext: (data) => _handleAnswer('usagePattern', data)),
      FutureProofingScreen(onNext: (data) => _handleAnswer('futureProofing', data)),
      SpecialRequirementsScreen(onNext: (data) => _handleAnswer('specialRequirements', data)),
      PeripheralsScreen(onNext: (data) => _handleAnswer('peripherals', data)),
    ]);
  }

  void _handleAnswer(String questionKey, dynamic answer) {
    setState(() {
      answers[questionKey] = answer;
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        _finishQuestionnaire();
      }
    });
  }

  void _finishQuestionnaire() {
    // TODO: Process all answers and generate build configuration
    Navigator.pushReplacementNamed(
      context,
      '/auto_build_summary',
      arguments: answers,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PC Configuration'),
        leading: currentQuestionIndex > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    if (currentQuestionIndex > 0) {
                      currentQuestionIndex--;
                    }
                  });
                },
              )
            : null,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (currentQuestionIndex + 1) / questions.length,
          ),
          Expanded(
            child: questions[currentQuestionIndex],
          ),
        ],
      ),
    );
  }
} 