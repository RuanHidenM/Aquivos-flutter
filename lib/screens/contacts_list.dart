import 'package:bkinternacionalizacao/components/container.dart';
import 'package:bkinternacionalizacao/components/progress.dart';
import 'package:bkinternacionalizacao/database/dao/contact_dao.dart';
import 'package:bkinternacionalizacao/models/contact.dart';
import 'package:bkinternacionalizacao/screens/contact_form.dart';
import 'package:bkinternacionalizacao/screens/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
abstract class ContactsListState{
  const ContactsListState();
}
@immutable
class LoadingContactsListState extends ContactsListState{
  const LoadingContactsListState();
}

@immutable
class InitContextListState extends ContactsListState{
  const InitContextListState();
}

@immutable
class LoadedContactsListState extends ContactsListState{
  final List<Contact> _contacts;
  const LoadedContactsListState(this._contacts);
}

@immutable
class FatalErrorContactsListState extends ContactsListState{
  const FatalErrorContactsListState();
}

class ContactsListCubit extends Cubit<ContactsListState>{
  ContactsListCubit() : super(InitContextListState());

  void reload(ContactDao dao) async {
    emit(LoadingContactsListState());
    dao.findAll().then((contacts) => emit(LoadedContactsListState(contacts)));
  }
}

class ContactsListContainer extends BlocContainer{
  @override
  Widget build(BuildContext context) {
    final ContactDao dao = ContactDao();
    return BlocProvider<ContactsListCubit>(
        create:(BuildContext context){
          final cubit = ContactsListCubit();
          cubit.reload(dao);
          return cubit;
        },
        child: ContactsList(dao),
    );
  }
}

class ContactsList extends StatelessWidget{
  final ContactDao _dao;
  ContactsList(this._dao);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: BlocBuilder<ContactsListCubit, ContactsListState>(

        builder: (context, state) {
          if(state is InitContextListState || state is LoadingContactsListState){
            return Progress();
          }
          if(state is LoadedContactsListState){
              final contacts = state._contacts;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return _ContectItem(
                      contact,
                      onClick: () {
                        push(context ,TransactionFormContainer(contact));
                      },
                   );
                },
                itemCount: contacts.length,
              );
          }
          return const Text('Unknown error');
        },
      ),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          );
          update(context);
        },
        child: Icon(
          Icons.add,
        ));
  }

  void update(BuildContext context) {
    context.bloc<ContactsListCubit>().reload(_dao);
  }
}

class _ContectItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  _ContectItem(
    this.contact, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(220, 228, 239, 1),
      child: ListTile(
        onTap: () => onClick(),
        leading: Icon(
          Icons.people_outline,
          color: Color.fromRGBO(25, 39, 58, 1),
        ),
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 26.0),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
