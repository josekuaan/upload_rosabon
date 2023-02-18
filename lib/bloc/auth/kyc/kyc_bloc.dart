import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/kyc_request.dart';
import 'package:rosabon/model/response_models/gender_response.dart';
import 'package:rosabon/model/response_models/kyc_response.dart';
import 'package:rosabon/repository/auth_repository.dart';

part 'kyc_event.dart';
part 'kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  final AuthRepository _authRepository = AuthRepository();
  KycBloc() : super(const KycInitial()) {
    on<KycEvent>((event, emit) async {
      if (event is Kyc) {
        await kyc(event, emit);
      }

      if (event is FetchGender) {
        await gender(event, emit);
      }
    });
  }

  Future<void> kyc(Kyc event, Emitter<KycState> emit) async {
    try {
      emit(const KycLoading());

      KycRequest kycRequest = event.kycRequest;

      var response = await _authRepository.kyc(kycRequest);

      if (response.baseStatus) {
        _authRepository.persistIsKyc(event.kycRequest.isKyc!);
        emit(KycSuccess(kycResponse: response));
      } else {
        emit(KycError(error: response.message));
      }
    } catch (e) {
      emit(KycError(error: e.toString()));
    }
  }

  Future<void> gender(FetchGender event, Emitter emit) async {
    try {
      var res;
      // emit(const UserLoading());

      res = await _authRepository.gender();

      if (res.baseStatus) {
        emit(GenderSuccess(genderResponse: res));
      }
    } catch (e) {
      // emit(UserError(error: e.toString()));
    }
  }
}
