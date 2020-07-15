import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NuevaTransaccion extends StatefulWidget {
  //Recibimos un puntero a la funcion del padre para guardar la transaccion
  final Function guardarTransaccion;
  NuevaTransaccion(this.guardarTransaccion);
  @override
  _NuevaTransaccionState createState() => _NuevaTransaccionState();
}

class _NuevaTransaccionState extends State<NuevaTransaccion> {
  final inputDescripcionController = TextEditingController();
  final inputPrecioController = TextEditingController();
  DateTime fechaSeleccionada;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Descripción"),
              controller: inputDescripcionController,
              //onSubmitted: (_) => {},
            ),
            TextField(
              decoration: InputDecoration(labelText: "Precio"),
              controller: inputPrecioController,
              keyboardType: TextInputType.number,
              //onSubmitted: (_) => {},
            ),
            Container(
              height: 70,
              
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(fechaSeleccionada == null
                        ? "No ha seleccionado fecha"
                        : DateFormat.yMMMd().format(fechaSeleccionada)),
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text("Seleccionar fecha"),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Agregar Transaccion'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
