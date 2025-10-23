import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Question {
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;

  Question({ String? id, required this.title, required this.choices, required this.goodChoice, this.points = 1}) : id = id ?? uuid.v4();
}

class Answer {
  final String id;
  final String questionId;
  final String answerChoice;

  Answer({ String? id, required this.questionId, required this.answerChoice}) : id = id ?? uuid.v4();
}

class Submission {
  final String id;
  final String playerName;
  List<Answer> answers;

  Submission({ String? id, required this.playerName, List<Answer>? answers }) : id = id ?? uuid.v4(), answers = answers ?? [];

  void addAnswer(Answer asnwer) {
     this.answers.add(asnwer);
  }

  int getScore(Quiz quiz) {
    int totalSCore = 0;
    for(Answer answer in answers){
      Question question = quiz.getQuestionById(answer.questionId);
      if (answer.answerChoice == question.goodChoice) {
        totalSCore += question.points;
      }
    }
    return totalSCore;
  }

  int getScorePercentage(Quiz quiz) {
    return ((getScore(quiz) / quiz.getTotalPoints()) * 100).toInt();
  }
}

class Quiz {
  String id;
  List<Question> questions;
  List<Submission> submissions;

  Quiz({String? id, required this.questions, List<Submission>? submissions}) : id = id ?? uuid.v4(), submissions = submissions ?? [];

  Question getQuestionById(String questionId) {
    return questions.firstWhere((question) => question.id == questionId);
  }

  void addSubmission(Submission submission) {
    this.submissions.add(submission);
  }

  int getTotalPoints () {
    int totalPoints = 0;
    for (Question question in questions) {
      totalPoints += question.points;
    }
    return totalPoints;
  }
}