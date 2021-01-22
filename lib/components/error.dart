import 'package:bkinternacionalizacao/components/response_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Menssagen de erro quando a senha for informado incorretamente
class ErrorView extends StatelessWidget {
  final String _message;

  const ErrorView(this._message);

  @override
  Widget build(BuildContext context) {
    return FailureDialog('Algo deu errado, tente novamente !',
        icon: Icons.error);
  }
}

//
// style: TextStyle(fontSize: 24.0),
