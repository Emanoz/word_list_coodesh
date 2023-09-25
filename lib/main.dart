import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:word_list_coodesh_app/data/collection/word_collection.dart';
import 'package:word_list_coodesh_app/data/datasource/isar_database.dart';
import 'package:word_list_coodesh_app/repository/word/word_repository.dart';
import 'package:word_list_coodesh_app/repository/word/word_repository_interface.dart';
import 'package:word_list_coodesh_app/ui/auth/authentication_page.dart';
import 'package:word_list_coodesh_app/ui/home_page.dart';
import 'package:word_list_coodesh_app/utils/firebase_manager.dart';
import 'package:word_list_coodesh_app/widgets/base_error_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var firebase = FirebaseManager();
  await firebase.initialize();

  await IsarDatabase.initialize();
  WordRepositoryInterface ivar = WordRepository();
  int size = await ivar.getSize();

  if (size == 0) {
    //const filePath = 'wordsfile/words_dictionary.json';

    try {
      //final file = File(filePath);
      Map<String, dynamic> data = jsonDecode(await rootBundle.loadString('wordsfile/words_dictionary.json'));
      List<WordCollection> wordList = [];

      data.forEach(
        (key, value) => wordList.add(
          WordCollection(
            id: wordList.length + 1,
            word: key,
            meanings: [],
            pronunciation: '',
          ),
        ),
      );

      await ivar.saveAll(wordList);
    } catch (e) {
      print('Erro ao ler o arquivo: $e');
    }
  }

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  FirebaseManager firebase = FirebaseManager();

  @override
  void initState() {
    super.initState();
    firebase.setAuthListeners(
      onSuccess: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
      },
      onError: () {
        showDialog(context: context, builder: (_) => const BaseErrorDialog());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [DefaultMaterialLocalizations.delegate],
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: const Color(0xFF14545C),
        // hintColor: const Color(0xFF4AF8AA),
        useMaterial3: true,
      ),
      //home: RegisterPage(),
      home: AuthenticationPage(),
      //home: const HomePage(),
    );
  }
}
