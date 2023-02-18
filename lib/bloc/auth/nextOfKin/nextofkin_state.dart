part of 'nextofkin_bloc.dart';

abstract class NextofkinState extends Equatable {
  const NextofkinState();

  @override
  List<Object> get props => [];
}

class NextofkinInitial extends NextofkinState {
  const NextofkinInitial();
}

class NextOfKinLoading extends NextofkinState {
  const NextOfKinLoading();
  @override
  List<Object> get props => [];
}

class FetchNextOfKinSuccess extends NextofkinState {
  const FetchNextOfKinSuccess({required this.employmentResponse});
  final EmploymentResponse employmentResponse;
  @override
  List<Object> get props => [employmentResponse];
}
