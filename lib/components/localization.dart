//localization e intenationalization
import 'package:bkinternacionalizacao/components/container.dart';
import 'package:bkinternacionalizacao/components/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LocalizationContainer extends BlocContainer {
  final Widget child;

  LocalizationContainer(@required Widget this.child);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: (context) => CurrentLocaleCubit(),
      child: this.child,
    );
  }
}

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super("en");
}

class ViewI18N {
  String _language;

  ViewI18N(BuildContext context) {
    //o problema dessa abordagem
    // é o rebuild quando voce troca a lingua
    //O que vc quer reconstruir quando trocar o currentlocalecubit?
    this._language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String localize(Map<String, String> values){
      assert(values != null);
      assert(values.containsKey(_language));
      return values[_language];
    }
  }


@immutable
abstract class I18NMessagesState{
  const I18NMessagesState();
}
@immutable
class LoadingI18NMessagesState extends I18NMessagesState{
  const LoadingI18NMessagesState();
}

@immutable
class InitI18NMessagesState extends I18NMessagesState{
  const InitI18NMessagesState();
}

@immutable
class LoadedI18NMessagesState extends I18NMessagesState{
  final LI18NMessages  _messages;
  
  const LoadedI18NMessagesState(this._messages);
}

class LI18NMessages  {
  final Map<String, String> _messages;
  LI18NMessages(this._messages);
  String get(String key){
    assert(key != null);
    assert(_messages.containsKey(key));
    return _messages[key];
  }
}

@immutable
class FatalErrorI18NMessagesState extends I18NMessagesState{
  const FatalErrorI18NMessagesState();
}
/*
class I18NLoadingView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
        builder: (context, state){
          if(state is InitI18NMessagesState || state is LoadingI18NMessagesState){
            return ProgressView();
          }
          if(state is LoadedI18NMessagesState){
            return Tela
          }
           return ErrorView('Erro buscando mensagens da tela');
        },
    );
  }
}

*/
/*teste*/