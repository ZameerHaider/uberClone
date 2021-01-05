import 'package:flutter/material.dart';

class CustomDevider extends StatelessWidget {
  const CustomDevider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Divider(
      height: size.width * 0.01,
      color: Color(0xffe2e2e2),
      thickness: size.width * 0.0035,
    );
  }
}
