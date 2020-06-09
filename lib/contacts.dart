import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  Iterable<Contact> _contacts;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    final Iterable<Contact> contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      _contacts = contacts;
      print(_contacts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contacts != null
          ? ListView.builder(
              itemCount: _contacts?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Contact contact = _contacts?.elementAt(index);
                var numbers = contact.phones.toList();
                return Column(
                  children: <Widget>[
                    Text(contact.displayName),
                    Container(
                      height: 20.0,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: numbers?.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Text(contact.phones.elementAt(i).value);
                        },
                      ),
                    )
                  ],
                );
              },
            )
          : Center(child: const CircularProgressIndicator()),
    );
  }
}
