part of 'employment_details_bloc.dart';

abstract class EmploymentDetailsState extends Equatable {
  const EmploymentDetailsState();

  @override
  List<Object> get props => [];
}

class EmploymentDetailsInitial extends EmploymentDetailsState {}

class EmploymentLoading extends EmploymentDetailsState {
  const EmploymentLoading();
  @override
  List<Object> get props => [];
}

class EmploymentSuccess extends EmploymentDetailsState {
  const EmploymentSuccess({required this.employmentResponse});
  final EmploymentResponse employmentResponse;
  @override
  List<Object> get props => [employmentResponse];
}
