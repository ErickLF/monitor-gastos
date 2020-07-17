import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './barra.dart';

class Grafica extends StatelessWidget {
  final List<Transaccion> transacciones;

  Grafica(this.transacciones);

  //Metodo para obtener los dias de la semana
  List<Map<String, Object>> get transaccionesSemana {
    return List.generate(7, (index) {
      //Vamos restando dias 0 -> hoy , 1 ayer, ...
      final diaSemana = DateTime.now().subtract(Duration(days: index));
      double sumaDiaTotal = 0.0;
      // recorremos todas las transacciones
      for (var i = 0; i < transacciones.length; i++) {
        //checamos de todas las transacciones las de el dia actual del generate
        if (transacciones[i].fecha.year == diaSemana.year &&
            transacciones[i].fecha.month == diaSemana.month &&
            transacciones[i].fecha.day == diaSemana.day) {
          sumaDiaTotal += transacciones[i].precio;
        }
      }
      return {'dia': DateFormat.E().format(diaSemana), 'total': sumaDiaTotal};
    }).reversed.toList();
  }

  double get maxGastosSemana {
    //Recorremos la lista de 7 dias generado
    return transaccionesSemana.fold(0.0, (sum, item) {
      return sum += item['total']; //Hacemos referencia al objeto que regresamos
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Text('Gastos realizados en los últimos 7 días'),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: transaccionesSemana.map((item) {
                return Flexible(
                  fit: FlexFit
                      .tight, //forzamos de que cada item sea del mismo tamaño
                  child: Barra(
                    item['dia'],
                    item['total'],
                    maxGastosSemana == 0.0
                        ? 0.0
                        : (item['total'] as double) /
                            maxGastosSemana, //evitamos divicion entre 0
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
