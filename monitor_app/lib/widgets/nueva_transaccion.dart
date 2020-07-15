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
  DateTime _fechaSeleccionada;

  void _submit(){
    String titulo = inputDescripcionController.text;
    //Convertimos a doble
    double precio = double.parse(inputPrecioController.text);

    if (precio < 0.0 || titulo.isEmpty || _fechaSeleccionada == null){
      return;
    }
    widget.guardarTransaccion(titulo,precio,_fechaSeleccionada);

    //Cerramos el modal despues de guardar
    Navigator.of(context).pop();
  }

  void _mostrarCalendario(){
    showDatePicker(
      //Esta global el contexto
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),//El limite es el dia de hoy
      firstDate: DateTime(2020),
    ).then((fecha) {
      //El usuario no selecciono nada
      if (fecha == null){
        return;
      }
      setState(() {
        _fechaSeleccionada = fecha;
      });
      
    });

  }
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
              onSubmitted: (_) => _submit(),//se tiene que mandar asi por que recibe un parametro
            ),
            TextField(
              decoration: InputDecoration(labelText: "Precio"),
              controller: inputPrecioController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submit(),
            ),
            Container(
              height: 70,
              
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_fechaSeleccionada == null
                        ? "No ha seleccionado fecha"
                        : DateFormat.yMMMd().format(_fechaSeleccionada)),
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text("Seleccionar fecha"),
                      onPressed: _mostrarCalendario,
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Agregar Transaccion'),
              onPressed: _submit,
            )
          ],
        ),
      ),
    );
  }
}
