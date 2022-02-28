import 'package:flashcard/pages/home.dart';
import 'package:flashcard/pages/flashcard/create.dart';

// 一番最初に開かれるページ
const indexPage = '/';
const flashcardCreatePage = '/flashcard/create';

final routes = {
  indexPage: (context) => const MyHomePage(),
  flashcardCreatePage: (context) => const CreateFlashcardPage(),
};