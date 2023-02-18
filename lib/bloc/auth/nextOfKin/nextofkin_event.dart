part of 'nextofkin_bloc.dart';

abstract class NextofkinEvent extends Equatable {
  const NextofkinEvent();

  @override
  List<Object> get props => [];
}

class FetchNextOfKin extends NextofkinEvent {
  const FetchNextOfKin(this.id);
  final String id;
  @override
  List<Object> get props => [];
}

class NextOfKin extends NextofkinEvent {
  const NextOfKin(this.personalInformationRequest);
  final PersonalInformationRequest personalInformationRequest;
  @override
  List<Object> get props => [personalInformationRequest];
}
