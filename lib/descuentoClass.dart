class Descuento {
  int id;
  double valor;
  String descuento;

  Descuento({this.id, this.descuento, this.valor});

  Map<String, dynamic> toMap() {
    return {"id": id, "descuento": descuento, "valor": valor};
  }

  Descuento.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    descuento = map['descuento'];
    valor = map['valor'];
  }
}
