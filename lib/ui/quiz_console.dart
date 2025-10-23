import 'dart:io';
import '../domain/quiz.dart';
import '../data/quiz.repository.dart';

class QuizConsole {
  Quiz quiz;
  QuizRepository quizRepo;

  QuizConsole({required this.quiz, required this.quizRepo});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');

    String? nameInput;

    do {
      quiz.submissions.forEach((submission) => print('Player: ${submission.playerName} \t\t Score: ${submission.getScore(quiz)}'));
      stdout.write('Your name: ');
      nameInput = stdin.readLineSync();
      if(nameInput == '' || nameInput == null) break;
      Submission currentSubmission = Submission(playerName: nameInput);
      if(quiz.submissions.any((submission) => submission.playerName == currentSubmission.playerName)) {
        currentSubmission = quiz.submissions.firstWhere((submission) => submission.playerName == currentSubmission.playerName);
        currentSubmission.answers = [];
      }
      else quiz.addSubmission(currentSubmission);
      for (var question in quiz.questions) {
        print('Question: ${question.title} - ( ${question.points} points )');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(questionId: question.id, answerChoice: userInput);
          currentSubmission.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }
      }
      print('${currentSubmission.playerName}, your score in percentage: ${currentSubmission.getScorePercentage(quiz)}%');
      print('${currentSubmission.playerName}, your score in points: ${currentSubmission.getScore(quiz)}');
    } while (nameInput != '');

    quizRepo.writeQuiz(quiz);

    print('--- Quiz Finished ---');
  }
}
 