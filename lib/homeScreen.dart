import 'package:cotiza/productClass.dart';
import 'package:cotiza/rowProduct.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'headTable.dart';
import 'dialogs.dart';

var producTxt = TextEditingController();
var cantidadProducto = TextEditingController();
String productName = "";
List<Product> myItems = [];

class homeScreen extends StatefulWidget {
  double ancho, largo;
  homeScreen(this.ancho, this.largo, {Key key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState(ancho, largo);
}

class _homeScreenState extends State<homeScreen> {
  double ancho, largo;
  List<Product> myItems2 = [];
  final formKey = GlobalKey<FormState>();
  _homeScreenState(this.ancho, this.largo);

  //Funcion para vaciar la lista de articulos
  //previamente agregados
  void onTapVaciar() {
    setState(() {
      myItems.clear();
      myItems2.clear();
    });
  }

  loadData() {
    setState(() {
      myItems2 = myItems;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  //Widget principal
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
        body: ListView(
          children: [
            Container(
              width: ancho,
              height: largo / 12,
              child: headTable(),
            ),
            Container(
              width: ancho,
              height: largo / 2.62,
              //Lista dinamica en la cual se muestran los articulos
              child: ListView.builder(
                itemCount: myItems.length,
                itemBuilder: (context, position) {
                  //Widget que hace a los items dismissibles, es decir
                  //se pueden borrar al deslizarlos a un lado
                  return Dismissible(
                    key: Key(myItems[position].toString()),
                    //metodo para borrar por deslizamiento
                    onDismissed: (direction) {
                      myItems.removeAt(position);
                    },
                    //widget fila, el cual muestra la informacion del articulo
                    child: rowProduct(
                      typeView: 0,
                      cantidad: myItems[position].cantidad,
                      product: myItems[position],
                      fontColor: Colors.white,
                    ),
                  );
                },
              ),
            ),
            //Lista de los botones de accion
            // boton buscar
            Container(
              color: Colors.amber,
              width: ancho,
              height: largo / 2.5,
              child: Column(
                children: [
                  Container(
                    width: ancho,
                    height: largo / 10,
                    child: boton(
                      text: "Buscar",
                      mColor: Colors.amber,
                      mKey: 0, //id del boton
                      context: context,
                      formKey: formKey,
                    ),
                  ),
                  //Boton vaciar
                  Container(
                      width: ancho,
                      height: largo / 10,
                      child: boton(
                        text: "Vaciar",
                        mKey: 1, //id del boton
                        mColor: Colors.red,
                        context: context,
                        //llama a la funcion para vaciar la lista, cuando el boton es pulsado
                        onBotonChange: () => onTapVaciar(),
                      )),
                  //boton de agregar articulos
                  Container(
                    width: ancho,
                    height: largo / 10,
                    child: boton(
                      text: "Agregar",
                      mKey: 2, //id del boton
                      mColor: Colors.blue,
                      context: context,
                    ),
                  ),
                  Container(
                    width: ancho,
                    height: largo / 10,
                    child: boton(
                      text: "Cotizar",
                      mKey: 3, //id del boton
                      mColor: Colors.green,
                      context: context,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//widget boton
class boton extends StatelessWidget {
  final String text;
  final BuildContext context;
  final int mKey;
  final Color mColor;
  final Function() onBotonChange;
  final GlobalKey<FormState> formKey;

  boton(
      {this.text,
      this.mKey,
      this.mColor,
      this.context,
      this.onBotonChange,
      this.formKey});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: mColor,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      //cuando el boton es presionado se utiliza su id para saber
      //accion realizar
      onPressed: () async {
        //cuando el id es 1 es porque el usuario desea vaciar la lista de articulos
        if (mKey == 1) {
          final action = await Dialogs.vDialog(context, text);
          //metodo para llamar el metodo setState y repintar el widget principal
          //ya que ha sido modificado
          onBotonChange();
        }
        if (mKey == 0) {
          final action = await Dialogs.sDialog(
              context: context, title: text, formKey: formKey, idScreen: 0);
          print("action search:$action");
        }
        if (mKey == 2) {
          final action = await Dialogs.mDialog(context, text);
        }

        handleButton(mKey: mKey);
      },
    );
  }
}

//metodo para actualizar la cantidad del producto
void handleCantidad(
  folio,
  cantidad,
) {
  //se verifica que el texto ingresado no sea null
  if (cantidadProducto.text.isNotEmpty) {
    //si el usuario ingresa 0 entonces se elimina el articulo
    if (int.parse(cantidadProducto.text) == 0)
      myItems.removeWhere((element) => element.folio == folio);
    else
      //caso contrario se busca el articulo que ha solicitado la actualizacion
      //y modifica la cantidad por la que ingreso el usuario
      myItems.forEach((element) {
        if (element.folio == folio)
          element.cantidad = cantidad = int.parse(cantidadProducto.text);
      });
  } else //en caso que el usuario deje el texto en blanco o pulse cancelar se retorna 1
    cantidad = 1;
}

// metodo de control para saber que boton ha desatado un evento
void handleButton({int mKey, Product product, int idScreen, int dialogCall}) {
  print("Handle button");
  print("idScreen:$idScreen");
  if (idScreen == 0) {
    if (mKey == 0) {
      print("buscar");
      producTxt.clear();
    }
    //El boton vaciar desata un evento
    if (mKey == 1) {
      myItems.clear(); //vacia la lista de items
    }
    //El boton agregar ha desatado un evento
    if (mKey == 2) {
      if (dialogCall == 1) {
        print("add product");
        myItems.add(product);
      }

      // se verifica que la cadena recibida no sea null
      if (producTxt.text.isNotEmpty) {
        productName = producTxt.text;
        //verificacion que el articulo no este en lista

        if (myItems.isEmpty) {
          ///sdfdsf,
          ///,
          print("empty");
        } else {
          List<String> folios = [];

          /*
        realizamos un listado de folios, para despues analizar si dentro de la
        lista existe un folio similar o no, para asi realizar la operacion correspondiente
        */
          for (var item in myItems) {
            folios.add(item.folio.toLowerCase());
          }
          //si el folio esta en la lista de folios, procedemos a aumentar la cantidad en 1
          if (folios.contains(productName.toLowerCase())) {
            myItems.forEach((element) {
              if (element.folio.compareTo(productName) == 0)
                element.cantidad += 1;
            });
          }
          //caso contrario añadimos el nuevo elemento
          else {
            //
            print("not empty and");
          }
        }

        productName = "";
        producTxt.clear();
      }
    }
    // El boton cotizar ha desatado un evento
    if (mKey == 3) {
      print("Cotizando");
      double total2 = 0;

      /*for (var item in myItems) {
      total2 += (item.cantidad * item.precioUnitario);
      print(item.cantidad);
    }*/
      print("Total linea 397:$total2");
    }
  } else {}
}
