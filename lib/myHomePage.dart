import 'package:cotiza/discountScreen.dart';
import 'package:cotiza/productScreen.dart';
import 'package:cotiza/homeScreen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double largo;
  double ancho;
  int selectDrawerItem = 0;

  getDrawerItem(pos, ancho, largo) {
    switch (pos) {
      case 0:
        return homeScreen(ancho, largo);
        break;
      case 1:
        return productScreen(ancho, largo);
        break;
      case 2:
        return discountScreen(ancho, largo);
        break;
    }
  }

  void onSelectItem(pos) {
    setState(() {
      Navigator.of(context).pop();
      selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    ancho = MediaQuery.of(context).size.width;
    largo = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Container(
        width: ancho / 1.25,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Colors.blue, Colors.lightBlue])),
                child: Column(
                  children: <Widget>[
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "lib/img/img.jpg",
                          width: 80,
                          height: 80,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home),
                onTap: () {
                  onSelectItem(0);
                },
              ),
              ListTile(
                title: Text("Productos"),
                leading: Icon(Icons.add_box),
                onTap: () {
                  onSelectItem(1);
                },
              ),
              ListTile(
                title: Text("Descuentos"),
                leading: Icon(Icons.add_box),
                onTap: () {
                  onSelectItem(2);
                },
              ),
            ],
          ),
        ),
      ),
      body: getDrawerItem(selectDrawerItem, ancho, largo),
    );
  }
}
