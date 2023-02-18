part of 'bvn_bloc.dart';

abstract class BvnState extends Equatable {
  const BvnState();

  @override
  List<Object> get props => [];
}

class BvnInitial extends BvnState {
  const BvnInitial();
}

class BvnLoading extends BvnState {
  const BvnLoading();
  @override
  List<Object> get props => [];
}

class BvnSuccess extends BvnState {
  final BvnResponse bvnResponse;
  const BvnSuccess({required this.bvnResponse});
  @override
  List<Object> get props => [bvnResponse];
}

class BvnUpdateSuccess extends BvnState {
  final BaseResponse baseResponse;
  const BvnUpdateSuccess({required this.baseResponse});
  List<Object?> get prop => [baseResponse];
}

class BvnError extends BvnState {
  final String error;
  const BvnError({required this.error});
  @override
  List<Object> get props => [error];
}
