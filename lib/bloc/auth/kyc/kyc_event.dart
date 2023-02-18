part of 'kyc_bloc.dart';

abstract class KycEvent extends Equatable {
  const KycEvent();

  @override
  List<Object> get props => [];
}

class Kyc extends KycEvent {
  final KycRequest kycRequest;
  const Kyc({required this.kycRequest});
  @override
  List<Object> get props => [kycRequest];
}

class FetchGender extends KycEvent {
  const FetchGender();
  @override
  List<Object> get props => [];
}
