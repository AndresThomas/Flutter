import 'package:cotiza/descuentoClass.dart';
import 'package:cotiza/homeScreen.dart';
import 'package:cotiza/productClass.dart';
import 'package:cotiza/productScreen.dart';
import 'package:cotiza/rowProduct.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'operation.dart';

enum DialogAction {
  yes,
  no,
}

List<Product> productSelected = [];
List<Descuento> descuentoSelected = [];

class Dialogs {
  // Cuadro emergente con entrada de texto para
  //introducir los productos, realizar busquedas
  static Future<DialogAction> mDialog(
    BuildContext context,
    String title,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title), //titulo dinamico: buscar o agregar
            content: TextField(
              controller: producTxt,
              maxLength: 10,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  hintText: title,
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  alignLabelWithHint: true),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.no),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop(DialogAction.yes);
                },
                child: const Text("Aceptar"),
              ),
              RaisedButton(
                onPressed: () {
                  handleButton(mKey: 2);
                },
                child: const Text("Agregar"),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogAction.no;
  }

  //Ventana emergente para controlar la cantidad de productos
  // requeridos
  static Future<DialogAction> cDialog(
    BuildContext context,
    String title,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title), //titulo : Cantidad
            content: TextField(
              keyboardType: TextInputType.number,
              controller: cantidadProducto,
              maxLength: 10,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  hintText: title,
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  alignLabelWithHint: true),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.no),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop(DialogAction.yes);
                },
                child: const Text("Aceptar"),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogAction.no;
  }

  //Ventana emergente para limpiar la lista de articulos
  static Future<DialogAction> vDialog(
    BuildContext context,
    String title,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title),
            content: Text(
              "¿Desea vaciar la lista de articulos?",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.no),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop(DialogAction.yes);
                },
                child: const Text("Aceptar"),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogAction.no;
  }

  static Future<DialogAction> addDialog(BuildContext context, String title,
      final GlobalKey<FormState> formKey) async {
    var producTxt = TextEditingController();
    var costoTxt = TextEditingController();
    var descripcionTxt = TextEditingController();
    var cantidadTxt = TextEditingController();

    bool state = false;

    var action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title), //titulo dinamico: buscar o agregar
            content: Container(
              height: 280,
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Ingrese el folio";
                        }
                        return null;
                      },
                      controller: producTxt,
                      maxLength: 10,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: "Folio",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          alignLabelWithHint: true),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Ingrese el costo";
                        }
                        return null;
                      },
                      controller: costoTxt,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: "Costo",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          alignLabelWithHint: true),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Ingrese la descripcion";
                        }
                        return null;
                      },
                      controller: descripcionTxt,
                      maxLength: 255,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: "Descripcion",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          alignLabelWithHint: true),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Ingrese la cantidad";
                        }
                        if (value.contains('.')) {
                          return "Ingrese numeros enteros";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: cantidadTxt,
                      maxLength: 10,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: "Cantidad",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          alignLabelWithHint: true),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.no),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    print("Guardando");
                    Product product = new Product(
                        folio: producTxt.text,
                        costo: double.parse(costoTxt.text),
                        descripcion: descripcionTxt.text,
                        cantidad: int.parse(cantidadTxt.text));
                    Operation.insert(product);
                    state = true;
                  }
                  Navigator.of(context).pop(DialogAction.yes);
                },
                child: const Text("Aceptar"),
              ),
              RaisedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    print("Guardando");
                    Product product = new Product(
                        folio: producTxt.text,
                        costo: double.parse(costoTxt.text),
                        descripcion: descripcionTxt.text,
                        cantidad: int.parse(cantidadTxt.text));
                    Operation.insert(product);
                    state = true;
                  }
                },
                child: const Text("Agregar"),
              ),
            ],
          );
        });
    if (state)
      action = DialogAction.yes;
    else
      action = DialogAction.no;
    return action;
  }

  static Future<DialogAction> addDialog2(BuildContext context, String title,
      final GlobalKey<FormState> formKey) async {
    var descuentoTxt = TextEditingController();
    var valor = TextEditingController();

    bool state = false;

    var action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title), //titulo dinamico: buscar o agregar
            content: Container(
              height: 150,
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Ingrese el nombre";
                        }
                        return null;
                      },
                      controller: descuentoTxt,
                      maxLength: 10,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: "Nombre",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          alignLabelWithHint: true),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Ingrese el valor";
                        }
                        return null;
                      },
                      controller: valor,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: "Valor",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          alignLabelWithHint: true),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.no),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    print("Guardando");
                    Descuento descuento = new Descuento(
                      descuento: descuentoTxt.text,
                      valor: double.parse(valor.text),
                    );
                    Operation.insert2(descuento);
                    state = true;
                  }
                  Navigator.of(context).pop(DialogAction.yes);
                },
                child: const Text("Aceptar"),
              ),
              RaisedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    print("Guardando");
                    Descuento descuento = new Descuento(
                      descuento: descuentoTxt.text,
                      valor: double.parse(valor.text),
                    );
                    Operation.insert2(descuento);
                    state = true;
                  }
                },
                child: const Text("Agregar"),
              ),
            ],
          );
        });
    if (state)
      action = DialogAction.yes;
    else
      action = DialogAction.no;
    return action;
  }

  static Future<DialogAction> sDialog({
    BuildContext context,
    String title,
    final GlobalKey<FormState> formKey,
    int idScreen,
  }) async {
    var search = TextEditingController();
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title), //titulo dinamico: buscar o agregar
            content: Form(
              key: formKey,
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "ingrese un folio";
                  }
                  return null;
                },
                controller: search,
                maxLength: 10,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    hintText: title,
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    alignLabelWithHint: true),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.no),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () async {
                  List<dynamic> item;
                  if (formKey.currentState.validate()) {
                    if (search.text.compareTo("cleanDataBase") == 0) {
                      Operation.clean();
                      Operation.clean2();
                    } else {
                      item = await Operation.search(search.text, idScreen);
                      //{0:[instance of class],1:idScreen}
                      //return item;
                    }

                    if (item[1] == 2) {
                      print("search descuento");
                      List<Descuento> item;
                      item.forEach((element) {
                        item.add(element);
                      });
                      //listDialogDescount(item,context);
                    } else {
                      print("Search producto");
                      var action = listDialog(
                          item: item[0],
                          context: context,
                          idScreen: idScreen,
                          typeView: 3);
                      if (action == DialogAction.yes) {
                        Navigator.of(context).pop(DialogAction.yes);
                      }
                    }
                  }
                },
                child: const Text("Aceptar"),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogAction.no;
  }

  static Future<DialogAction> listDialog(
      {List<Product> item,
      BuildContext context,
      int idScreen,
      int typeView}) async {
    print("map:" + item.asMap().toString());
    var action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text("Seleccion"), //titulo dinamico: buscar o agregar
            content: ListView.builder(
                itemCount: item.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      //color: Colors.transparent,
                      width: 300,
                      child: Column(
                        children: [
                          rowProduct(
                            product: item[index],
                            sizeContainer: 200,
                            size2: 45,
                            windowKey: idScreen,
                            typeView: typeView,
                            fontColor: Colors.black,
                          ),
                        ],
                      ));
                }),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.no),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop(DialogAction.yes);
                },
                child: const Text("Aceptar"),
              ),
            ],
          );
        });
    return action;
  }

  static Future<DialogAction> detailDialog(
      {Product product, BuildContext context}) async {
    print("map:" + product.toMap().toString());
    var action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Detalles"),
            content: Container(
              //color: Colors.blue,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Folio: " + product.folio,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("Descripcion: " + product.descripcion,
                      style: TextStyle(fontSize: 20)),
                  Text("Costo: " + product.costo.toString(),
                      style: TextStyle(fontSize: 20)),
                  Text("En existencia:" + product.cantidad.toString(),
                      style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.no),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () {
                  print("close details");
                  Navigator.of(context).pop(DialogAction.yes);
                },
                child: const Text("Aceptar"),
              ),
            ],
          );
        });
  }

  static Future<DialogAction> updateDialog(
      {BuildContext context,
      String title,
      final GlobalKey<FormState> formKey,
      Product product}) async {
    var producTxt = TextEditingController();
    var costoTxt = TextEditingController();
    var descripcionTxt = TextEditingController();
    var cantidadTxt = TextEditingController();

    bool state = false;

    producTxt.text = product.folio;
    costoTxt.text = product.costo.toString();
    descripcionTxt.text = product.descripcion;
    cantidadTxt.text = product.cantidad.toString();

    var action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title), //titulo dinamico: buscar o agregar
            content: Container(
              height: 280,
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Ingrese el folio";
                        }
                        return null;
                      },
                      controller: producTxt,
                      maxLength: 10,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: "Folio",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          alignLabelWithHint: true),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Ingrese el costo";
                        }
                        return null;
                      },
                      controller: costoTxt,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: "Costo",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          alignLabelWithHint: true),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Ingrese la descripcion";
                        }
                        return null;
                      },
                      controller: descripcionTxt,
                      maxLength: 255,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: "Descripcion",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          alignLabelWithHint: true),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Ingrese la cantidad";
                        }
                        if (value.contains('.')) {
                          return "Ingrese numeros enteros";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: cantidadTxt,
                      maxLength: 10,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: "Cantidad",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          alignLabelWithHint: true),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.no),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    print("Guardando");
                    product.folio = producTxt.text;
                    product.costo = double.parse(costoTxt.text);
                    product.cantidad = int.parse(cantidadTxt.text);
                    product.descripcion = descripcionTxt.text;
                    Operation.update(product);
                    state = true;
                  }
                  Navigator.of(context).pop(DialogAction.yes);
                },
                child: const Text("Aceptar"),
              ),
            ],
          );
        });
    if (state)
      action = DialogAction.yes;
    else
      action = DialogAction.no;
    return action;
  }
}
