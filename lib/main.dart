import 'package:bkinternacionalizacao/components/theme.dart';
import 'package:bkinternacionalizacao/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bkinternacionalizacao/components/localization.dart';

void main() {
  runApp(BytebankApp());
  //print(Uuid().v4());
}
class LogObserver extends BlocObserver{
 @override
  void onChange(Cubit cubit, Change change) {
   print("${cubit.runtimeType} > $change");
    super.onChange(cubit, change);
  }
}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //na prática evitar de usar log do genero, pois pode vazar informações sensíveis para o log
    Bloc.observer  = LogObserver();

    return MaterialApp(
      theme: bytebankTheme,
      home: LocalizationContainer(
        DashboardContainer(),
      ),
    );
  }
}
