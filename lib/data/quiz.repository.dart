import 'dart:io';
import 'dart:convert';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);

  Quiz readQuiz() {
    final file = File(filePath);
    final content = file.readAsStringSync();
    final data = jsonDecode(content);

    var quizId = data['id'] as String;

    var questionsJson = data['questions'] as List;
    var questions = questionsJson.map((q) {
      return Question(
        id: q['id'],
        title: q['title'],
        choices: List<String>.from(q['choices']),
        goodChoice: q['goodChoice'],
        points: q['points'],
      );
    }).toList();

    var submissionJson = data['submissions'] as List;
    var submissions = submissionJson.map((s) {
      return Submission(
        id: s['id'],
        playerName: s['playerName'],
        answers: (s['answers'] as List).map((a) => Answer(questionId: a['questionId'], answerChoice: a['answerChoice'])).toList()
      );
    }).toList();

    return Quiz(id: quizId ,questions: questions, submissions: submissions);
  }

  void writeQuiz(Quiz quiz) {
    final file = File(filePath);
    final json = {
      'id': quiz.id,
      'questions': quiz.questions.map((q) => {
        'id': q.id,
        'title': q.title,
        'choices': q.choices,
        'goodChoice': q.goodChoice,
        'points': q.points,
      }).toList(),
      'submissions': quiz.submissions.map((s) => {
        'id': s.id,
        'playerName': s.playerName,
        'answers': s.answers.map((a) => {
          'id': a.id,
          'questionId': a.questionId,
          'answerChoice': a.answerChoice,
        }).toList()
      }).toList(),
    };
    final content = JsonEncoder.withIndent('  ').convert(json);
    file.writeAsStringSync(content);
  }
}
