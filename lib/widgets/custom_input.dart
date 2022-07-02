import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyBoarType;
  final bool isPassword;
  CustomInput(
      {Key? key,
      required this.icon,
      required this.placeholder,
      required this.textController,
      required this.keyBoarType,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]),
      child: Center(
        child: TextField(
            controller: textController,
            textAlignVertical: TextAlignVertical.center,
            autocorrect: false,
            obscureText: isPassword,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                prefixIcon: Icon(icon),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: placeholder)),
      ),
    );
  }
}
