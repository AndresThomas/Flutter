import 'package:flutter/material.dart';

class productScreen extends StatelessWidget {
  double ancho, largo;

  productScreen(this.ancho, this.largo, {Key key}) : super(key: key);

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
        body: Center(child: Text("Product Screen")),
      ),
    );
  }
}
