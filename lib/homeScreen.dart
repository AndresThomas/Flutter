import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'headTable.dart';
import 'dialogs.dart';

var producTxt = TextEditingController();
var cantidadProducto = TextEditingController();
String productName = "";
List<rowItem> myItems = [];

class homeScreen extends StatefulWidget {
  double ancho, largo;
  homeScreen(this.ancho, this.largo, {Key key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState(ancho, largo);
}

class _homeScreenState extends State<homeScreen> {
  double ancho, largo;
  _homeScreenState(this.ancho, this.largo);

  //Funcion para vaciar la lista de articulos
  //previamente agregados
  void onTapVaciar() {
    print("vaciando");
    setState(() {
      myItems.clear();
    });
  }

  //Widget principal
  @override
  Widget build(BuildContext context) {
    print("largo:$largo");
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
                    child: rowItem(
                      myItems[position].cantidad,
                      myItems[position].folio,
                      myItems[position].precioUnitario,
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

//Widget fila
class rowItem extends StatelessWidget {
  int cantidad;
  String folio;
  double precioUnitario;
  double precioTotal;

  rowItem(
    this.cantidad,
    this.folio,
    this.precioUnitario,
  );
  @override
  Widget build(BuildContext context) {
    print("creadon row item");
    this.precioTotal = this.precioUnitario * this.cantidad;
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: Column(
          children: [
            InkWell(
              splashColor: Colors.white,
              onTap: () {},
              child: Container(
                height: 40,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 30,
                                width: 70,
                                //boton en el cual esta expresada la cantidad del articulo
                                child: FloatingActionButton(
                                  onPressed: () async {
                                    final action = await Dialogs.cDialog(
                                      context,
                                      "Cantidad",
                                    );
                                    //llamada al metodo para actualizar la cantidad
                                    handleCantidad(folio, cantidad);
                                  },
                                  child: Text(cantidad.toString()),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 70,
                        color: Colors.brown,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 70,
                              color: Colors.cyan,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  folio,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 70,
                        color: Colors.lime,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              precioUnitario.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 70,
                        color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              precioTotal.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ));
  }
}

//widget boton
class boton extends StatelessWidget {
  final String text;
  final BuildContext context;
  final int mKey;
  final Color mColor;
  final Function() onBotonChange;

  boton({
    this.text,
    this.mKey,
    this.mColor,
    this.context,
    this.onBotonChange,
  });

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
          print("action:$action");
          //metodo para llamar el metodo setState y repintar el widget principal
          //ya que ha sido modificado
          onBotonChange();
        }
        if (mKey == 0 || mKey == 2) {
          final action = await Dialogs.mDialog(
            context,
            text,
          );
        }

        handleButton(mKey);
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
void handleButton(mKey) {
  print("id:$mKey");
  //El boton busqueda desata un evento
  if (mKey == 0) {
    print("buscar");
    producTxt.clear();
  }
  //El boton vaciar desata un evento
  if (mKey == 1) {
    print("Vaciar");
    myItems.clear(); //vacia la lista de items
  }
  //El boton agregar ha desatado un evento
  if (mKey == 2) {
    print("Agregar");
    // se verifica que la cadena recibida no sea null
    if (producTxt.text.isNotEmpty) {
      productName = producTxt.text;
      //verificacion que el articulo no este en lista

      if (myItems.isEmpty) {
        myItems.add(rowItem(
          1,
          productName,
          25.0,
        ));
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
          myItems.add(rowItem(
            1,
            productName,
            25.0,
          ));
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

    for (var item in myItems) {
      total2 += (item.cantidad * item.precioUnitario);
      print(item.cantidad);
    }
    print("Total linea 397:$total2");
  }
}
