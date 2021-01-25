import 'package:bkinternacionalizacao/components/centered_message.dart';
import 'package:bkinternacionalizacao/components/progress.dart';
import 'package:bkinternacionalizacao/http/webclients/transaction_webclient.dart';
import 'package:bkinternacionalizacao/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting: // ainda esta carregando
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transactions = snapshot.data;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        color: Color.fromRGBO(220, 228, 239, 1),
                        child: ListTile(
                          leading: Icon(Icons.monetization_on, color: Colors.green,),
                          title: Text(
                            'R\$: ' + transaction.value.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Conta: '+ transaction.contact.accountNumber.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              return CenteredMessage('No transactions found',
                  icon: Icons.warning);
              break;
          }
          return CenteredMessage('Unknown error');
          // se não cair em nenhum dos cases, este alerta sera acionado, retornando uma menssagem de erro
        },
      ),
    );
  }
}
