import 'package:flashcard/pages/home.dart';
import 'package:flashcard/pages/flashcard/create.dart';
import 'package:flashcard/pages/flashcard/edit.dart';
import 'package:flashcard/pages/flashcard/edit_card.dart';

// 一番最初に開かれるページ
const indexPage = '/';
const flashcardCreatePage = '/flashcard/create';
const flashcardEditPage = '/flashcard/edit';
const flashcardCardEditPage = '/flashcard/edit-card';

final routes = {
  indexPage: (context) => const MyHomePage(),
  flashcardCreatePage: (context) => const CreateFlashcardPage(),
  flashcardEditPage: (context) => const EditFlashcardPage(),
  flashcardCardEditPage: (context) => const EditFlashcardCardPage(),
};