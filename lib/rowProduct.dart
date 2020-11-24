import 'package:flutter/material.dart';

import 'dialogs.dart';
import 'homeScreen.dart';
import 'productClass.dart';

class rowProduct extends StatelessWidget {
  Product product;
  double totalSale;
  double sizeContainer, size2;
  int windowKey, cantidad, typeView;
  Color fontColor;
  final formKey = GlobalKey<FormState>();

  rowProduct(
      {this.product,
      this.cantidad,
      this.totalSale,
      this.typeView,
      this.sizeContainer,
      this.windowKey,
      this.fontColor,
      this.size2});
  @override
  Widget build(BuildContext context) {
    print("folio:" + product.folio + " id:" + product.id.toString());
    if (typeView == 3) {
      return Container(
          width: this.sizeContainer,
          height: this.size2,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: Column(
            children: [
              InkWell(
                splashColor: Colors.white,
                onLongPress: () {
                  print(this.product.toMap());
                  if (windowKey == 0 && typeView == 3) {
                    print("add to car");
                    //this.product.cantidad = 1;
                    handleButton(
                        mKey: 2,
                        product: this.product,
                        dialogCall: 1,
                        idScreen: 0);
                    //myItems.add(this.product);
                  } else {
                    final action = Dialogs.updateDialog(
                        formKey: formKey,
                        context: context,
                        title: "Actualizar",
                        product: this.product);
                  }
                },
                onTap: () {
                  print(this.product.folio);
                  Dialogs.detailDialog(context: context, product: this.product);
                },
                child: Container(
                  height: 40,
                  child: ListView(scrollDirection: Axis.horizontal,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        color: fontColor, fontSize: 20),
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
                                    TextStyle(color: fontColor, fontSize: 20),
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
                                          color: fontColor, fontSize: 20),
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
                                          color: fontColor, fontSize: 20),
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
    } else {
      return Container(
          width: this.sizeContainer,
          height: this.size2,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: Column(
            children: [
              InkWell(
                splashColor: Colors.white,
                onLongPress: () {
                  print(this.product.toMap());
                  if (windowKey == 0) {
                    print("add to car");
                    handleButton(mKey: 2, product: this.product);
                    //myItems.add(this.product);
                  } else {
                    final action = Dialogs.updateDialog(
                        formKey: formKey,
                        context: context,
                        title: "Actualizar",
                        product: this.product);
                  }
                },
                onTap: () {
                  print(this.product.folio);
                  Dialogs.detailDialog(context: context, product: this.product);
                },
                child: Container(
                  height: 40,
                  child: ListView(scrollDirection: Axis.horizontal,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                handleCantidad(this.product.folio, cantidad);
                              },
                              child: Text(cantidad.toString()),
                            )),
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
                                        color: fontColor, fontSize: 20),
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
                                    TextStyle(color: fontColor, fontSize: 20),
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
                                          color: fontColor, fontSize: 20),
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
                                          color: fontColor, fontSize: 20),
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
}
