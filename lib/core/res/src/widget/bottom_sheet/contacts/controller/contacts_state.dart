part of 'contacts_cubit.dart';

@immutable
abstract class ContactsState {}

class ContactsInitial extends ContactsState {}
class FetchLoadingState extends ContactsState {}
class FetchLoadedState extends ContactsState {}
