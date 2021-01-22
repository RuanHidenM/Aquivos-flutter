import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {

  final Function(String password) onConfirm;
  TransactionAuthDialog({
    @required this.onConfirm
  });

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {

  final TextEditingController _passwordControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(//Esta informando que sera uma tipo AlertDialog
      title: Text('Your password!'),// informando o titulo do Alert
      content: TextField(
        controller: _passwordControler,
        obscureText: true,// esconde as letras no imputs tipo password
        maxLength: 4, //limita a quantidade permitida em um imput
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        textAlign: TextAlign.center, // deixa o texto no centro da tela
        keyboardType: TextInputType.number,// define que apenas o teclado numero sera chamado.
        style:TextStyle(fontSize: 64, letterSpacing: 24),// altera o tamanho do texto
      ),
      actions: [
        FlatButton(
          onPressed: () =>Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        FlatButton(
          onPressed: () {
            widget.onConfirm(_passwordControler.text);
            Navigator.pop(context);
          },
          child: Text('Confirmar'),
        )
      ],
    );
  }
}
