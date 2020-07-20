import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final _mostrarCalendario;
  final _texto;

  AdaptiveFlatButton(this._mostrarCalendario, this._texto);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              _texto,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: _mostrarCalendario,
          )
        : FlatButton(
            child: Text(
              _texto,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            textColor: Theme.of(context).primaryColor,
            onPressed: _mostrarCalendario,
          );
  }
}
