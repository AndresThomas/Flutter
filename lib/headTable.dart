import 'package:flutter/material.dart';

//Widget cabecera de la tabla de articulos, en la cual se
// encuentra la cantidad de productos, el folio , precio por unidad
//y el total por el/los articulo/los

class headTable extends StatelessWidget {
  headTable();
  @override
  Widget build(BuildContext context) {
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
}

class ProductheadTable extends StatelessWidget {
  ProductheadTable();
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 26.0,
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Folio',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
          ),
        ),
        DataColumn(
          label: Text(
            'Costo',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
          ),
        ),
        DataColumn(
          label: Text(
            'Descripcion.',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
          ),
        ),
        DataColumn(
          label: Text(
            'Cantidad.',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
          ),
        ),
      ],
      rows: <DataRow>[],
    );
  }
}

class DiscounheadTable extends StatelessWidget {
  DiscounheadTable();
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 26.0,
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Id',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
          ),
        ),
        DataColumn(
          label: Text(
            'Descuento',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
          ),
        ),
        DataColumn(
          label: Text(
            'Valor.',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
          ),
        ),
      ],
      rows: <DataRow>[],
    );
  }
}
