import 'package:flutter/material.dart';

class Barra extends StatelessWidget {
  final String label;
  final double totalDia;
  final double acumuladoGastos;

  //Constructor para inicializar
  Barra(this.label, this.totalDia, this.acumuladoGastos);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 10,
          child: FittedBox(
            child: Text('\$ ${totalDia}'),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 55,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: acumuladoGastos,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(label),
      ],
    );
  }
}
