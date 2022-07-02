import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String label;
  final String lableButton;
  final String route;
  const Labels(
      {Key? key,
      required this.route,
      required this.label,
      required this.lableButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
          SizedBox(
            height: 2.5,
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, route);
              },
              child: Text(
                lableButton,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
