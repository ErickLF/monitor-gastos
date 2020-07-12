import 'package:flutter/foundation.dart';

class Transaccion {
  String id;
  String titulo;
  double precio;
  DateTime fecha;

  //Definimos el constructor de la clase por nombres
  Transaccion({
    @required this.id, 
    @required this.titulo, 
    @required this.precio,
    @required this.fecha
  });
}