import 'package:flutter/material.dart';
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

  void onTapVaciar() {
    print("vaciando");
    setState(() {
      myItems.clear();
    });
  }

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
              child: ListView.builder(
                itemCount: myItems.length,
                itemBuilder: (context, position) {
                  return Dismissible(
                    key: Key(myItems[position].toString()),
                    onDismissed: (direction) {
                      myItems.removeAt(position);
                    },
                    child: rowItem(
                      myItems[position].cantidad,
                      myItems[position].folio,
                      myItems[position].precioUnitario,
                    ),
                  );
                },
              ),
            ),
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
                      mKey: 0,
                      context: context,
                    ),
                  ),
                  Container(
                      width: ancho,
                      height: largo / 10,
                      child: boton(
                        text: "Vaciar",
                        mKey: 1,
                        mColor: Colors.red,
                        context: context,
                        onBotonChange: () => onTapVaciar(),
                      )),
                  Container(
                    width: ancho,
                    height: largo / 10,
                    child: boton(
                      text: "Agregar",
                      mKey: 2,
                      mColor: Colors.blue,
                      context: context,
                    ),
                  ),
                  Container(
                    width: ancho,
                    height: largo / 10,
                    child: boton(
                      text: "Cotizar",
                      mKey: 3,
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

Widget headTable() {
  return DataTable(
    columnSpacing: 15,
    columns: const <DataColumn>[
      DataColumn(
        label: Text(
          'Cantidad',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
        ),
      ),
      DataColumn(
        label: Text(
          'Folio',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
        ),
      ),
      DataColumn(
        label: Text(
          'PrecioU.',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
        ),
      ),
      DataColumn(
        label: Text(
          'PrecioT.',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
        ),
      ),
    ],
    rows: <DataRow>[],
  );
}

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
                                child: FloatingActionButton(
                                  onPressed: () async {
                                    final action = await Dialogs.cDialog(
                                      context,
                                      "Cantidad",
                                    );
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
                            Text(
                              folio,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
      onPressed: () async {
        if (mKey == 1) {
          final action = await Dialogs.vDialog(context, text);
          print("action:$action");
          onBotonChange();
        } else {
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

void handleCantidad(
  folio,
  cantidad,
) {
  if (cantidadProducto.text.isNotEmpty) {
    if (int.parse(cantidadProducto.text) == 0)
      myItems.removeWhere((element) => element.folio == folio);
    else
      myItems.forEach((element) {
        if (element.folio == folio)
          element.cantidad = cantidad = int.parse(cantidadProducto.text);
      });
  } else
    cantidad = 1;
}

void handleButton(mKey) {
  if (mKey == 0) {
    print("buscar");
  }
  if (mKey == 1) {
    print("Vaciar");
    print(myItems.length);

    myItems.clear();

    print(myItems.length);
  }
  if (mKey == 2) {
    print("Agregar");
    if (producTxt.text.isNotEmpty) {
      productName = producTxt.text;
      myItems.add(rowItem(
        1,
        productName,
        25.0,
      ));
      productName = "";
      producTxt.clear();
    }
  }
  if (mKey == 3) print("Cotizando");
}
