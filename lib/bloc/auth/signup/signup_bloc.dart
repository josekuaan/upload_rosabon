import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/register_token_request.dart';
import 'package:rosabon/model/request_model/sign_up_request.dart';
import 'package:rosabon/model/response_models/sign_up_response.dart';
import 'package:rosabon/model/response_models/source_response.dart';
import 'package:rosabon/repository/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository _authRepository = AuthRepository();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  SignupBloc() : super(const SignupInitial()) {
    on<SignupEvent>((event, emit) async {
      if (event is SignuUp) {
        await signup(emit, event);
      }
      if (event is RequesterTokn) {
        await requesterTokn(event, emit);
      }
      if (event is FetchSource) {
        await getSource(event, emit);
      }
    });
  }

  Future<void> signup(Emitter<SignupState> emit, SignuUp event) async {
    try {
      emit(const SignupLoading());
      String deviceData = "";
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.androidInfo;
        deviceData = androidDeviceInfo.device!;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        deviceData = iosDeviceInfo.utsname.machine!;
      }
      SignUpRequest signUpRequest = event.signUpRequest;

      final response = await _authRepository.signup(signUpRequest);
      if (response.baseStatus) {
        _authRepository.persistEmail(response.email!);
        _authRepository.persistPhone(response.phone!);
        _authRepository.persistUserRole(response.role!);
        _authRepository.persistIsKyc(response.isKyc!);
        _authRepository.persistNewsletter(response.isNewsLetters ?? false);
        _authRepository.persistAssited(response.isAssited ?? false);
        _authRepository.persistReferralCode(response.referralCode ?? "");
        // _authRepository.persistSourceOthers(response.sourceOthers ?? "");
        _authRepository.persistSource(response.source!);
        _authRepository.persistStatus(response.status!);
        _authRepository.persistUsage(response.usage!);
        _authRepository.persistUserDevice(deviceData);
        emit(SignupSuccess(signUpReponse: response));
      } else {
        emit(SignupError(error: response.message));
      }
    } catch (e) {
      emit(SignupError(error: e.toString()));
    }
  }

  Future<void> getSource(FetchSource event, Emitter emit) async {
    try {
      var res;
      // emit(const UserLoading());

      res = await _authRepository.getSource();

      if (res.baseStatus) {
        emit(SourceSuccess(sourceResponse: res));
      }
    } catch (e) {
      // emit(UserError(error: e.toString()));
    }
  }

  Future<void> requesterTokn(RequesterTokn event, Emitter emit) async {
    try {
      var res;
      // emit(const UserLoading());

      res = await _authRepository.requesterTokn(event.registerTokenRequest);
    } catch (e) {
      // emit(UserError(error: e.toString()));
    }
  }
}
