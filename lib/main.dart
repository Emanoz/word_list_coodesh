import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:word_list_coodesh_app/data/collection/word_collection.dart';
import 'package:word_list_coodesh_app/data/datasource/isar_database.dart';
import 'package:word_list_coodesh_app/repository/word/word_repository.dart';
import 'package:word_list_coodesh_app/repository/word/word_repository_interface.dart';
import 'package:word_list_coodesh_app/ui/auth/authentication_page.dart';
import 'package:word_list_coodesh_app/ui/home_page.dart';
import 'package:word_list_coodesh_app/utils/base_state_controller/state_controller.dart';
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
    try {
      Map<String, dynamic> data = jsonDecode(await rootBundle.loadString('wordsfile/words_dictionary.json'));
      List<WordCollection> wordList = [];

      data.forEach(
        (key, value) => wordList.add(
          WordCollection(
            id: wordList.length + 1,
            word: key,
            meanings: [],
            pronunciation: '',
            uid: [],
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
  StateController<bool> isLogged = StateController(value: false);

  @override
  void initState() {
    super.initState();
    firebase.setAuthListeners(
      onSuccess: (isLogged) {
        this.isLogged.update(isLogged);
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
        useMaterial3: true,
      ),
      home: Observer(builder: (context) {
        return isLogged.value ? const HomePage() : AuthenticationPage();
      }),
    );
  }
}
