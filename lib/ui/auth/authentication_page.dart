import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_list_coodesh_app/repository/word/word_repository_interface.dart';
import 'package:word_list_coodesh_app/ui/home_page.dart';
import 'package:word_list_coodesh_app/usecase/word_usecase_interface.dart';
import 'package:word_list_coodesh_app/utils/firebase_manager.dart';
import 'package:word_list_coodesh_app/widgets/base_error_dialog.dart';

class AuthenticationPage extends StatelessWidget {
  AuthenticationPage({super.key});

  final FirebaseManager firebase = FirebaseManager();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        //height: double.infinity,
        padding: EdgeInsets.only(
          right: 16.0,
          left: 16.0,
          top: MediaQuery.paddingOf(context).top + 24.0,
          bottom: 24.0,
        ),
        color: Colors.white54,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network('https://www.truckpag.com.br/img/truck-image.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
              child: Text(
                'Informe seu usuário e senha abaixo para acessar a plataforma.',
                style: GoogleFonts.nunito(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      label: Text(
                        'Usuário',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      hintText: 'Informe seu nome de usuário',
                      hintStyle: GoogleFonts.nunito(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      label: Text(
                        'Senha',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      hintText: 'Informe sua senha',
                      hintStyle: GoogleFonts.nunito(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                firebase.signIn(emailController.text, passwordController.text).then((credential) {
                  if (credential == null) {
                    showDialog(
                      context: context,
                      builder: (_) => const BaseErrorDialog(),
                    );
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
                  }
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color(0xFF4AF8AA),
                ),
                child: Text(
                  'ENTRAR',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'CADASTRE-SE',
                  style:
                      GoogleFonts.nunito(fontWeight: FontWeight.w400, color: const Color(0xFF14545C), fontSize: 14.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
