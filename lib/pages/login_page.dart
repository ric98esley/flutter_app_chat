import 'package:flutter/material.dart';

import 'package:chat_app/widgets/blueButton.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:chat_app/widgets/custom_input.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(
                    title: 'Messeger',
                  ),
                  _Fom(),
                  Labels(
                    label: 'No tienes cuenta?',
                    lableButton: 'Registrate aqui',
                    route: 'register',
                  ),
                  Text("Terminos y condiciones de uso",
                      style: TextStyle(fontWeight: FontWeight.w300))
                ],
              ),
            ),
          ),
        ));
  }
}

class _Fom extends StatefulWidget {
  const _Fom({Key? key}) : super(key: key);

  @override
  State<_Fom> createState() => __FomState();
}

class __FomState extends State<_Fom> {
  @override
  Widget build(BuildContext context) {
    final emailCrtl = TextEditingController();
    final passW = TextEditingController();
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomInput(
                icon: Icons.mail_outline,
                placeholder: 'Email',
                keyBoarType: TextInputType.emailAddress,
                textController: emailCrtl),
            CustomInput(
              icon: Icons.lock_outline,
              placeholder: 'Contrasena',
              keyBoarType: TextInputType.visiblePassword,
              textController: passW,
              isPassword: true,
            ),
            BlueButton(
              text: 'Summit',
              onPressed: () =>
                  print('Email ${emailCrtl.text}  pass ${passW.text}'),
            ), // TODo Crear boton
          ],
        ),
      ),
    );
  }
}
