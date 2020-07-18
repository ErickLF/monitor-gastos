import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import './widgets/lista_transacciones.dart';
import './widgets/nueva_transaccion.dart';
import './models/transaction.dart';
import './widgets/grafica.dart';

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
        primarySwatch: Colors.pink,
        //Color secundario
        accentColor: Colors.black,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontSize: 18,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold),
              button: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontSize: 18,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                )),
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
  List<Transaccion> transacciones = [];
  void _agregarNuevaTransaccion(
      String descripcion, double precio, DateTime fecha) {
    final transaccion = Transaccion(
        id: 'tran' + (transacciones.length + 1).toString(),
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

  void _eliminarTransaccion(String id) {
    setState(() {
      transacciones.removeWhere((item) {
        return item.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    Intl.defaultLocale = 'es';
    // La hacemos variable para poder tomar en cuenta su altura
    final appBar = AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _modalNuevaTransaccion(context),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context)
                            .padding
                            .top) * //padding que agrega flutter automaticamente arriba donde viene iconos de wifi
                    0.4,
                child: Grafica(transacciones)),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.6,
                child: ListaTransaccion(transacciones, _eliminarTransaccion)),
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
