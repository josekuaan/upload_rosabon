part of 'countri_api_bloc.dart';

abstract class CountryApiEvent extends Equatable {
  const CountryApiEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends CountryApiEvent {
  const Fetch({required this.name, this.id});
  final String name;
  final int? id;
  @override
  List<Object> get props => [];
}
