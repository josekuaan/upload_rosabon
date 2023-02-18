import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/identity_response.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/repository/auth_repository.dart';
import 'package:rosabon/repository/profile_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository _authRepository = AuthRepository();
  final ProfileRepository _profileRepository = ProfileRepository();
  UserBloc() : super(const UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is FetchUser) {
        await user(event, emit);
      }
      if (event is IndividualOtp) {
        await individaulOtp(event, emit);
      }
      if (event is GeneralOtp) {
        await generalOtp(event, emit);
      }
      if (event is IdentificationType) {
        await identificationType(event, emit);
      }
    });
  }

  Future<void> user(FetchUser event, Emitter emit) async {
    try {
      var res;
      emit(const UserLoading());

      res = await _authRepository.userDetails(event);

      if (res.baseStatus) {
        _authRepository.persistReferralCode(res.myReferralCode ?? "");
        _authRepository.persistReferralLink(res.referralLink ?? "");
        _authRepository.persistPhone(res.phone ?? "");
        // _authRepository.persistSourceOthers(res.sourceOthers.name ?? "");

        if (res.role == "COMPANY") {
          // var user = json.encode({
          //   "bank_details": res.bank ?? "",
          // });
          // SessionManager().userDataVal = user;

          _authRepository.persistCompanyName(res.company.name);

          _authRepository.persistSource(res.source!);
          _authRepository.persistStatus(res.status!);
          _authRepository.persistUsage(res.usage!);
          _authRepository.persistUserId(res.company.id ?? 0);
        } else {
          _authRepository.persistUserId(res.individualUser.id);
          _authRepository.persistFirstName(res.individualUser.firstName);

          _authRepository.persistLastName(res.individualUser.lastName);
          // _authRepository.persistTotalnetworth(res.individual.)
        }
        print("==========================");
        print(res);
        print("=====================");
        emit(FetchUserSuccess(userResponse: res));
        print("==========================");
        print(res);
        print("=====================");
        print(res);
      } else {
        emit(UserError(error: res.message));
      }
    } catch (e) {
      emit(UserError(error: e.toString()));
    }
  }

  Future<void> identificationType(
      IdentificationType event, Emitter emit) async {
    try {
      var res;
      emit(const UserLoading());

      res = await _profileRepository.identificationType();

      if (res.baseStatus) {
        emit(IdentificationSuccess(identityReponse: res));
      } else {
        emit(UserError(error: res.message));
      }
    } catch (e) {
      emit(UserError(error: e.toString()));
    }
  }

  Future<void> individaulOtp(IndividualOtp event, Emitter emit) async {
    try {
      BaseResponse res;

      res = await _profileRepository.individualOtp();

      if (res.baseStatus) {
        emit(OtpSuccess(baseResponse: res));
      } else {
        emit(OtpError(error: res.message));
      }
    } catch (e) {
      emit(OtpError(error: e.toString()));
    }
  }

  Future<void> generalOtp(GeneralOtp event, Emitter emit) async {
    try {
      BaseResponse res;

      res = await _profileRepository.generalOtp(event.message!);

      if (res.baseStatus) {
        emit(OtpSuccess(baseResponse: res));
      } else {
        emit(OtpError(error: res.message));
      }
    } catch (e) {
      emit(OtpError(error: e.toString()));
    }
  }
}
