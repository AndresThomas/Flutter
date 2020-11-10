import 'package:flutter/material.dart';

class discountScreen extends StatelessWidget {
  double ancho, largo;

  discountScreen(this.ancho, this.largo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("lib/img/img.jpg"),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: Text("Hola")),
      ),
    );
  }
}
