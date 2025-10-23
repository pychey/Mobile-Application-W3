 
import 'data/quiz.repository.dart';
import 'domain/quiz.dart';
import 'ui/quiz_console.dart';

void main() {

  QuizRepository quizRepo = QuizRepository('quiz.json');
  Quiz quiz = quizRepo.readQuiz();
  QuizConsole console = QuizConsole(quiz: quiz, quizRepo: quizRepo);

  console.startQuiz();
}
