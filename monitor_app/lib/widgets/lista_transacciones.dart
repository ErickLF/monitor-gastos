import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class ListaTransaccion extends StatelessWidget {
  final List<Transaccion> transaccion;
  ListaTransaccion(this.transaccion);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transaccion.isEmpty
          ? Column(
              children: <Widget>[
                Text('No hay transacciones')
              ],
            )
          : ListView.builder(
              itemCount: transaccion.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          //Para que el precio no se salga del circulo
                          child: Text('\$ ${transaccion[index].precio}'),
                        ),
                      ),
                    ),
                    title: Text(transaccion[index].titulo),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transaccion[index].fecha)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ),
                );
              },
            ),
    );
  }
}
