part of 'kyc_bloc.dart';

abstract class KycState extends Equatable {
  const KycState();

  @override
  List<Object> get props => [];
}

class KycInitial extends KycState {
  const KycInitial();
  List<Object?> get prop => [];
}

class KycLoading extends KycState {
  const KycLoading();
  List<Object?> get prop => [];
}

class KycSuccess extends KycState {
  final KycResponse kycResponse;
  const KycSuccess({required this.kycResponse});
  List<Object?> get prop => [kycResponse];
}

class GenderSuccess extends KycState {
  final GenderResponse genderResponse;
  const GenderSuccess({required this.genderResponse});
  List<Object?> get prop => [genderResponse];
}

class KycError extends KycState {
  final String error;
  const KycError({required this.error});
  @override
  List<Object> get props => [error];
}
