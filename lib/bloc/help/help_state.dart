part of 'help_bloc.dart';

abstract class HelpState extends Equatable {
  const HelpState();

  @override
  List<Object> get props => [];
}

class HelpInitial extends HelpState {}

class HelpLoading extends HelpState {
  const HelpLoading();
}

class HelpSuccess extends HelpState {
  final HelpResponse helpResponse;
  const HelpSuccess({required this.helpResponse});
  @override
  List<Object> get props => [helpResponse];
}
