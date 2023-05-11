import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  TextEditingController searchBarController=TextEditingController();

 void onClearText(){
    searchBarController.text='';
    emit(FetchLoadedState());
  }

  ContactsCubit() : super(FetchLoadingState()) {
    getContactPermission();
  }

  List<Color> colorsList = <Color>[
    const Color(0xffDE86D1),
    const Color(0xff8A9AD8),
    const Color(0xffD1DDAA),
    const Color(0xff8AD8AB),
    Colors.blueGrey,
  ];
  List<Contact> contactsList = <Contact>[];

  Future<void> getContactPermission() async {
    emit(FetchLoadingState());
    if (await Permission.contacts.isDenied) {
      await Permission.contacts.request();
    }
    contactsList = await ContactsService.getContacts();
    emit(FetchLoadedState());
  }

  String selectContact(int index) {
    return presentedContacts[index].phones?.first.value??'';
  }

  List<Contact> get presentedContacts  =>
     contactsList.where((Contact element) => searchBarController.text.isEmpty || ((element.givenName??'').toLowerCase()).contains(searchBarController.text.toLowerCase())).toList();



  void search() {
    emit(FetchLoadedState());
  }}
