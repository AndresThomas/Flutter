import 'package:cotiza/descuentoClass.dart';
import 'package:cotiza/homeScreen.dart';
import 'package:cotiza/productClass.dart';
import 'package:cotiza/productScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'operation.dart';

enum DialogAction {
  yes,
  no,
}

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
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Aceptar"),
              ),
              RaisedButton(
                onPressed: () {
                  handleButton(2);
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
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                onPressed: () => Navigator.of(context).pop(),
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
                  Navigator.of(context).pop();
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
                onPressed: () => Navigator.of(context).pop(),
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
                  Navigator.of(context).pop();
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

  static Future<DialogAction> sDialog(
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
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancelar"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Operation.clean();
                  Operation.clean2();
                },
                child: const Text("Aceptar"),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogAction.no;
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
                onPressed: () => Navigator.of(context).pop(),
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
                  Navigator.of(context).pop();
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
