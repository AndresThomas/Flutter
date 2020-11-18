import 'package:cotiza/homeScreen.dart';
import 'package:cotiza/operation.dart';
import 'package:cotiza/productClass.dart';
import 'package:flutter/material.dart';
import 'dialogs.dart';
import 'headTable.dart';

class productScreen extends StatefulWidget {
  double ancho, largo;
  productScreen(this.ancho, this.largo, {Key key}) : super(key: key);

  @override
  productScreenState createState() => productScreenState(ancho, largo);
}

List<Product> results = [];

class productScreenState extends State<productScreen> {
  double ancho, largo;
  final formKey = GlobalKey<FormState>();

  productScreenState(
    this.ancho,
    this.largo,
  );

  _loadData() async {
    List<Product> query = await Operation.getProducts();
    setState(() {
      results = query;
    });
    results.forEach((element) {
      print(element.id.toString() + ":" + element.folio);
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

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
                //color: Colors.red,
                width: ancho,
                child: Column(
                  children: [
                    Container(
                      //color: Colors.blue,
                      width: ancho,
                      height: largo / 12,
                      child: ProductheadTable(),
                    ),
                    Container(
                      width: ancho,
                      height: largo / 1.8,
                      //color: Colors.yellow,
                      //Lista dinamica en la cual se muestran los articulos
                      child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, position) {
                          //Widget que hace a los items dismissibles, es decir
                          //se pueden borrar al deslizarlos a un lado
                          return Dismissible(
                            key: Key(results[position].toString()),
                            background: Container(
                              color: Colors.red,
                              padding: EdgeInsets.only(left: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            //metodo para borrar por deslizamiento
                            onDismissed: (direction) {
                              print("id:" + results[position].id.toString());
                              Operation.delete(results[position]);

                              results.removeAt(position);
                            },
                            //widget fila, el cual muestra la informacion del articulo
                            child: rowProduct(
                              product: results[position],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      //color: Colors.blue,
                      width: ancho,
                      height: largo / 5,
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

                          //boton de agregar articulos
                          Container(
                            width: ancho,
                            height: largo / 10,
                            child: boton(
                              text: "Agregar",
                              mKey: 1, //id del boton
                              mColor: Colors.blue,
                              context: context,
                              formKey: formKey,
                              onBotonChange: () => _loadData(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class boton extends StatelessWidget {
  final int mKey;
  final String text;
  final Color mColor;
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final Function() onBotonChange;
  boton(
      {this.mKey,
      this.text,
      this.mColor,
      this.context,
      this.formKey,
      this.onBotonChange});

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
        if (mKey == 0) {
          final action = await Dialogs.sDialog(context, text);
          print(action);
        } else {
          final action = await Dialogs.addDialog(context, text, formKey);
          onBotonChange();
        }
      },
    );
  }
}

class rowProduct extends StatelessWidget {
  Product product;
  final formKey = GlobalKey<FormState>();

  rowProduct({this.product});
  @override
  Widget build(BuildContext context) {
    print("folio:" + product.folio + " id:" + product.id.toString());
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: Column(
          children: [
            InkWell(
              splashColor: Colors.white,
              onLongPress: () {
                print(this.product.toMap());
                final action = Dialogs.updateDialog(
                    formKey: formKey,
                    context: context,
                    title: "Actualizar",
                    product: this.product);
              },
              onTap: () {
                print(this.product.folio);
              },
              child: Container(
                height: 40,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 70,
                        //color: Colors.brown,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 70,
                              //color: Colors.cyan,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.folio,
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
                        //color: Colors.lime,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.costo.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 30,
                                width: 70,
                                //boton en el cual esta expresada la cantidad del articulo
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Text(
                                    product.descripcion,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 30,
                                width: 70,
                                //boton en el cual esta expresada la cantidad del articulo
                                child: Center(
                                  child: Text(
                                    product.cantidad.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )),
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
