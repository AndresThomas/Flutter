class Product {
  int id;
  String folio;
  double costo;
  String descripcion;
  int cantidad;

  Product({this.id, this.folio, this.cantidad, this.descripcion, this.costo});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "folio": folio,
      "costo": costo,
      "descripcion": descripcion,
      "cantidad": cantidad
    };
  }

  Product.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    folio = map['folio'];
    costo = map['costo'];
    descripcion = map['descripcion'];
    cantidad = map['cantidad'];
  }
}
