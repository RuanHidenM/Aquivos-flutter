import 'package:bkinternacionalizacao/components/container.dart';
import 'package:bkinternacionalizacao/models/name.dart';
import 'package:bkinternacionalizacao/screens/contacts_list.dart';
import 'package:bkinternacionalizacao/screens/name.dart';
import 'package:bkinternacionalizacao/screens/transactions_list.dart';
import 'package:bkinternacionalizacao/components/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Ruan"),
      child: I18NLoadingContainer(
        viewkey: "dashboard",
        creator:(messages) => DashboardView(DashboardViewLazyI18N(messages)),
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18N _i18n;

  DashboardView(this._i18n);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //misturando uma bloc builder (que é um observer de eventos) ou UI
        title: Text('Bytebank Internazionalização'),
      ),
      body: Container(
        color: Color.fromRGBO(25, 39, 58, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Padding(
            //padding: const EdgeInsets.all(8.0),
            /* child:9*/
            Image.asset('images/bytebank_logo.png'),
            //),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 350,
                  height: 60,
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                      BlocBuilder<NameCubit, String>(
                        builder: (context, state) => Text(
                          _i18n.welcome_index + '$state',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                      )
                    ],
                  )),
            ),

            // title: BlocBuilder<NameCubit, String>(
            //   builder: (context, state) => Text('BK internacio - Walcome $state'),
            // ),

            SingleChildScrollView(
              child: Container(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _FeatureItem(
                      //'Transfer',
                      _i18n.transfer,
                      Icons.monetization_on,
                      onClick: () => _showContactsList(context),
                    ),
                    _FeatureItem(
                      //'Transaction Feed',
                      _i18n.transaction_feed,
                      Icons.description,
                      onClick: () => _showTransactionList(context),
                    ),
                    _FeatureItem(
                      //'Change name',
                      _i18n.change_name,
                      Icons.person_outline,
                      onClick: () => _showChangeName(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardViewLazyI18N {
  final I18NMessages _messages;

  DashboardViewLazyI18N(this._messages);

  String get transfer => _messages.get("transfer");

  String get transaction_feed => _messages.get("transaction_feed");

  String get change_name => _messages.get("change_name");

  String get welcome_index => _messages.get("welcome_index");
}

// class DashboardViewI18N extends ViewI18N {
//   DashboardViewI18N(BuildContext context) : super(context);
//
//   String get transfer => localize({"pt-br": "Transferir", "en": "Transfer"});
//
//   String get transaction_feed => localize({"pt-br": "Transações", "en": "Transaction Feed"});
//
//   String get change_name => localize({"pt-br": "Mudar nome", "en": 'Change name'});
//
//   String get walcome_index => localize({"pt-br": "Bem Vindo", "en": 'Walcome'});
// }

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _FeatureItem(this.name, this.icon, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
            width: 160,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Color.fromRGBO(73, 182, 237, 1),
                  width: 3.0,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 35.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showContactsList(BuildContext blocContext) {
  push(blocContext, ContactsListContainer());
}

void _showChangeName(BuildContext blocContext) {
  Navigator.of(blocContext).push(
    MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<NameCubit>(blocContext),
        child: NameContainer(),
      ),
    ),
  );
}

void _showTransactionList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ),
  );
}
