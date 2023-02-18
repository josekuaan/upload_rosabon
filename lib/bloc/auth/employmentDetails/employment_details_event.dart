part of 'employment_details_bloc.dart';

abstract class EmploymentDetailsEvent extends Equatable {
  const EmploymentDetailsEvent();

  @override
  List<Object> get props => [];
}

class SubmitDetails extends EmploymentDetailsEvent {
  const SubmitDetails(this.personalInformationRequest);
  final PersonalInformationRequest personalInformationRequest;
  @override
  List<Object> get props => [personalInformationRequest];
}
