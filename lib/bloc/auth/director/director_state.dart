part of 'director_bloc.dart';

abstract class DirectorState extends Equatable {
  const DirectorState();

  @override
  List<Object> get props => [];
}

class DirectorInitial extends DirectorState {
  const DirectorInitial();
}

class DirectorLoading extends DirectorState {
  const DirectorLoading();
}

class SendingOtp extends DirectorState {
  const SendingOtp();
}

class DirectorSuccess extends DirectorState {
  const DirectorSuccess({required this.directorResponse});
  final DirectorResponse directorResponse;
  @override
  List<Object> get props => [directorResponse];
}

class DeleteSuccess extends DirectorState {
  const DeleteSuccess({required this.baseResponse});
  final BaseResponse baseResponse;
  @override
  List<Object> get props => [baseResponse];
}

class DirectorError extends DirectorState {
  final String error;
  const DirectorError({required this.error});

  @override
  List<Object> get props => [error];
}

class OtpRecieved extends DirectorState {
  const OtpRecieved({required this.baseResponse});
  final BaseResponse baseResponse;
  @override
  List<Object> get props => [baseResponse];
}
