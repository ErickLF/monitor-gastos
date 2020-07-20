import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import './widgets/lista_transacciones.dart';
import './widgets/nueva_transaccion.dart';
import './models/transaction.dart';
import './widgets/grafica.dart';

void main() {
  //Inhabilitar el modo horizontal
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
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
      home: MyHomePage(title: 'Gestor de gastos personales'),
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

  bool _mostrarGrafica = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        mediaQuery.orientation == Orientation.landscape;
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
    final listaGastos = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: ListaTransaccion(transacciones, _eliminarTransaccion),
    );
    
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if(isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Mostrar gráfica', style: Theme.of(context).textTheme.title,),
                Switch(
                  value: _mostrarGrafica,
                  onChanged: (val) {
                    setState(() {
                      _mostrarGrafica = val;
                    });
                  },
                ),
              ],
            ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery
                            .padding
                            .top) * //padding que agrega flutter automaticamente arriba donde viene iconos de wifi
                    0.3,
                child: Grafica(transacciones),
              ),
            if (!isLandscape) listaGastos,
            if(isLandscape) _mostrarGrafica ? Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery
                            .padding
                            .top) * //padding que agrega flutter automaticamente arriba donde viene iconos de wifi
                    0.6,
                  child: Grafica(transacciones),
                  ) : listaGastos,
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
