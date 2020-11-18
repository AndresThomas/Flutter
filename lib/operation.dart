import 'dart:async';
import 'package:cotiza/productClass.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Operation {
  static Future<Database> openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'cotiza.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE productos(id INTEGER PRIMARY KEY AUTOINCREMENT, folio TEXT NOT NULL, costo DOUBLE , descripcion TEXT NOT NULL,cantidad INTEGER);",
      );
    }, version: 1);
  }

  static Future<void> insert(Product product) async {
    print("add in db");
    Database database = await openDB();
    //getProducts();
    return database.insert("productos", product.toMap());
  }

  static Future<void> delete(Product product) async {
    print("delete in db");
    print(product.id);
    Database database = await openDB();
    return database
        .delete("productos", where: 'id = ? ', whereArgs: [product.id]);
  }

  static Future<void> clean() async {
    print("clean db");
    Database database = await openDB();
    return database.delete("productos");
  }

  static Future<List<Product>> getProducts() async {
    Database database = await openDB();
    final List<Map<String, dynamic>> results =
        await database.query("productos");

    for (var n in results) {
      print("data:" + n['id'].toString());
    }

    return List.generate(
        results.length,
        (i) => Product(
            id: results[i]['id'],
            cantidad: results[i]['cantidad'],
            costo: results[i]['costo'],
            descripcion: results[i]['descripcion'],
            folio: results[i]['folio']));
  }

  static Future<void> update(Product product) async {
    print(product.toMap());
    Database database = await openDB();
    return database.update("productos", product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
  }
}
