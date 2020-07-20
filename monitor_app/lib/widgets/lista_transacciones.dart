import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class ListaTransaccion extends StatelessWidget {
  final List<Transaccion> transaccion;
  final Function eliminarTransaccion;
  ListaTransaccion(this.transaccion, this.eliminarTransaccion);
  @override
  Widget build(BuildContext context) {
    return transaccion.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No hay transacciones',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
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
                  title: Text(
                    transaccion[index].titulo,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transaccion[index].fecha)),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                          textColor: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
                          label: Text("Eliminar"),
                          onPressed: () =>
                              eliminarTransaccion(transaccion[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              eliminarTransaccion(transaccion[index].id),
                        ),
                ),
              );
            },
            itemCount: transaccion.length,
          );
  }
}
