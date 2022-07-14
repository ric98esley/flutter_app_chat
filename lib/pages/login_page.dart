import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/widgets/blueButton.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/helpers/show_warning.dart';

import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/auth_services.dart';

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
  final emailCrtl = TextEditingController();
  final passW = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

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
                text: 'Ingrese',
                onPressed: authService.auntenticando
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final loginOk = await authService.login(
                            emailCrtl.text.trim(), passW.text.trim());
                        if (loginOk) {
                          //Conectar a socket sevice
                          socketService.connect();
                          Navigator.pushReplacementNamed(context, 'users');
                          // Navegar pantalla
                        } else {
                          //mostrar alerta
                          showWarning(context, "Autenticacion incorrecto",
                              "Revise sus credenciales");
                        }
                      }), // TODo Crear boton
          ],
        ),
      ),
    );
  }
}
