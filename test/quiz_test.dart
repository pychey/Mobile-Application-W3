import 'package:test/test.dart';
import '../lib/data/quiz.repository.dart';
import '../lib/domain/quiz.dart';

void main() {
  QuizRepository quizRepo = QuizRepository('quiz.json');
  Quiz quiz = quizRepo.readQuiz();

  setUp(() {
    quiz.submissions = [];
    print('Running Setup, Clearing Submissions');
  });

  test("QUIZ TEST 1", () {
    quiz.addSubmission(Submission(playerName: "pychey", answers: [
      Answer(questionId: quiz.questions[0].id, answerChoice: "Paris"),
      Answer(questionId: quiz.questions[1].id, answerChoice: "4" )
    ]));

    expect(quiz.submissions[0].getScore(quiz), equals(60));
    expect(quiz.submissions[0].getScorePercentage(quiz), equals(100));
  });

  test("QUIZ TEST 2", () {
    quiz.addSubmission(Submission(playerName: "finch", answers: [
      Answer(questionId: quiz.questions[0].id, answerChoice: "Paris"),
      Answer(questionId: quiz.questions[1].id, answerChoice: "1" )
    ]));

    expect(quiz.submissions[0].getScore(quiz), equals(10));
    expect(quiz.submissions[0].getScorePercentage(quiz), equals(16));
  });

  test("QUIZ TEST 3", () {
    quiz.addSubmission(Submission(playerName: "lightning", answers: [
      Answer(questionId: quiz.questions[0].id, answerChoice: "London"),
      Answer(questionId: quiz.questions[1].id, answerChoice: "4" )
    ]));

    expect(quiz.submissions[0].getScore(quiz), equals(50));
    expect(quiz.submissions[0].getScorePercentage(quiz), equals(83));
  });

  test("QUIZ TEST 4", () {
    quiz.addSubmission(Submission(playerName: "gago", answers: [
      Answer(questionId: quiz.questions[0].id, answerChoice: "London"),
      Answer(questionId: quiz.questions[1].id, answerChoice: "2" )
    ]));

    expect(quiz.submissions[0].getScore(quiz), equals(0));
    expect(quiz.submissions[0].getScorePercentage(quiz), equals(0));
  });
}