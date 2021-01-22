import 'package:bkinternacionalizacao/components/container.dart';
import 'package:bkinternacionalizacao/models/name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameContainer extends BlocContainer{
  @override
  Widget build(BuildContext context) {
  return NameView();
  }
}

class NameView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    //Aghora não tem problema essa abordagem
    // pois não vamos fazer um rebuild quando o estado é alteradoi
    _nameController.text = context.bloc<NameCubit>().state;

    return Scaffold(
        appBar: AppBar(title: const Text("Change name")),
        body: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Desired name: ",
              ),
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text("Change"),
                  onPressed: () {
                    final name = _nameController.text;
                    context.bloc<NameCubit>().change(name);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
