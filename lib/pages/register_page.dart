import 'package:flutter/material.dart';

import 'package:chat_app/widgets/blueButton.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:chat_app/widgets/custom_input.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: SafeArea(
          child: ListView(physics: const BouncingScrollPhysics(), children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(
                    title: 'Register',
                  ),
                  SingleChildScrollView(child: _Fom()),
                  Labels(
                    label: 'Ya tienes cuenta?',
                    lableButton: 'Inicia Seccion',
                    route: 'login',
                  ),
                  Text("Terminos y condiciones de uso",
                      style: TextStyle(fontWeight: FontWeight.w300))
                ],
              ),
            ),
          ]),
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
    final passCrtl = TextEditingController();
    final nameCrtl = TextEditingController();
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomInput(
                icon: Icons.person_outline,
                placeholder: 'Name',
                keyBoarType: TextInputType.name,
                textController: nameCrtl),
            CustomInput(
                icon: Icons.mail_outline,
                placeholder: 'Email',
                keyBoarType: TextInputType.emailAddress,
                textController: emailCrtl),
            CustomInput(
              icon: Icons.lock_outline,
              placeholder: 'Contrasena',
              keyBoarType: TextInputType.visiblePassword,
              textController: passCrtl,
              isPassword: true,
            ),
            BlueButton(
              text: 'Summit',
              onPressed: () =>
                  print('Email ${emailCrtl.text}  pass ${passCrtl.text}'),
            ), // TODo Crear boton
          ],
        ),
      ),
    );
  }
}
