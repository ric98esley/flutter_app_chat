import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;
  const Logo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 170,
          margin: EdgeInsets.only(top: 25),
          child: Column(
            children: [
              const Image(image: AssetImage('assets/tag-logo.png')),
              const SizedBox(
                height: 20,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 30),
              )
            ],
          )),
    );
  }
}
