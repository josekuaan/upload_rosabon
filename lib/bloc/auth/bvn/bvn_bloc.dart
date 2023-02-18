import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/bvn_request.dart';
import 'package:rosabon/model/request_model/updateBvnName.dart';
import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/bvn_response.dart';
import 'package:rosabon/repository/auth_repository.dart';

part 'bvn_event.dart';
part 'bvn_state.dart';

class BvnBloc extends Bloc<BvnEvent, BvnState> {
  final AuthRepository _authRepository = AuthRepository();
  BvnBloc() : super(const BvnInitial()) {
    on<BvnEvent>((event, emit) async {
      if (event is BVN) {
        await bvn(event, emit);
      }
      if (event is UpdateBvnName) {
        await updateBvnName(event, emit);
      }
    });
  }

  Future<void> bvn(BVN event, Emitter<BvnState> emit) async {
    try {
      emit(const BvnLoading());

      BvnRequest bvnRequest = event.bvnRequest;

      var response = await _authRepository.bvn(bvnRequest);

      if (response.success!) {
        emit(BvnSuccess(bvnResponse: response));
      } else {}
    } catch (e) {
      if (e.toString().contains("BVN Validation failed")) {
        emit(const BvnError(
            error: "BVN validation failed, please provide correct details"));
      } else {
        emit(BvnError(error: e.toString()));
      }
    }
  }

  Future<void> updateBvnName(
      UpdateBvnName event, Emitter<BvnState> emit) async {
    try {
      emit(const BvnLoading());

      var response =
          await _authRepository.updateBvnName(event.updateBvnNameRequest);

      if (response.baseStatus) {
        emit(BvnUpdateSuccess(baseResponse: response));
      } else {
        emit(BvnError(error: response.message));
      }
    } catch (e) {
      emit(BvnError(error: e.toString()));
    }
  }
}
