import 'package:cotiza/homeScreen.dart';
import 'package:flutter/material.dart';

enum DialogAction { yes, abort }

class Dialogs {
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
            title: Text(title),
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
                  handleButton(1);
                },
                child: const Text("Agregar"),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }

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
            title: Text(title),
            content: TextField(
              keyboardType: TextInputType.phone,
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
    return (action != null) ? action : DialogAction.abort;
  }

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
    return (action != null) ? action : DialogAction.abort;
  }
}
