import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_list_coodesh_app/ui/home_page.dart';
import 'package:word_list_coodesh_app/ui/word_list_page.dart';
import 'package:word_list_coodesh_app/utils/base_state_controller/state_controller.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF14545C),
        hintColor: const Color(0xFF4AF8AA),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
