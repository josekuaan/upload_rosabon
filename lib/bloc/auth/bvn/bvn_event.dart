part of 'bvn_bloc.dart';

abstract class BvnEvent extends Equatable {
  const BvnEvent();

  @override
  List<Object> get props => [];
}

class BVN extends BvnEvent {
  final BvnRequest bvnRequest;
  const BVN({required this.bvnRequest});

  @override
  List<Object> get props => [bvnRequest];
}

class UpdateBvnName extends BvnEvent {
  final UpdateBvnNameRequest updateBvnNameRequest;
  const UpdateBvnName({required this.updateBvnNameRequest});
  @override
  List<Object> get props => [updateBvnNameRequest];
}
