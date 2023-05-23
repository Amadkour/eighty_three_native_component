part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class AppInitial extends GlobalState {}

class LanguageChanged extends GlobalState {}

class TextFieldChanged extends GlobalState {}

class GlobalInitial extends GlobalState {}
class GlobalButtonLoading extends GlobalState {}

class GlobalButtonLoaded extends GlobalState {}
