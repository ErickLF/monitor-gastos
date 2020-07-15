import 'package:flutter/material.dart';
import './widgets/lista_transacciones.dart';
import './widgets/nueva_transaccion.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaccion> transacciones = [
    Transaccion(
        id: "t1", titulo: "Zapatos", precio: 900.99, fecha: DateTime.now())
  ];
  void _agregarNuevaTransaccion(
      String descripcion, double precio, DateTime fecha) {
    final transaccion = Transaccion(
        id: 'tran' + (transacciones.length).toString(),
        titulo: descripcion,
        precio: precio,
        fecha: fecha);
    //Agregamos la transaccion y repintamos widget
    setState(() {
      transacciones.add(transaccion);
    });
  }

  void _modalNuevaTransaccion(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bctx) {
          return GestureDetector(
            child: NuevaTransaccion(_agregarNuevaTransaccion),
            onTap: () {},
            behavior: HitTestBehavior
                .opaque, //Para que no se cierre el modal al tocarlo
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              child: Text("Grafica"),
            ),
            ListaTransaccion(transacciones),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _modalNuevaTransaccion(context),
      ),
    );
  }
}
