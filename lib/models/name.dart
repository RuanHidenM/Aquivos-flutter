import 'package:flutter_bloc/flutter_bloc.dart';


//O Estado é uma única string
//Poderia ser um Perfil com vários valores
class NameCubit extends Cubit<String> {
  NameCubit(String name) : super(name);

  void change(String name) => emit(name);
}