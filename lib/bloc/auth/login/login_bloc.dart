import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/login_request.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:rosabon/model/response_models/login_response.dart';
import 'package:rosabon/repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository = AuthRepository();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  LoginBloc() : super(const LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is Login) {
        await login(emit, event);
      }
    });
  }

  Future<void> login(Emitter<LoginState> emit, Login event) async {
    try {
      emit(const Loginloading());
      String deviceData = "";
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.androidInfo;
        deviceData = androidDeviceInfo.device!;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        deviceData = iosDeviceInfo.utsname.machine!;
      }

      Loginrequest loginrequest = event.loginrequest;
      _authRepository.persistUserDevice(deviceData);
      var response = await _authRepository.login(loginrequest);

      if (response.baseStatus) {
        // var user = json.encode({
        //   "email":response.email,
        //   "fullname":response.fullName,
        //   "role":response.role.name,
        // });

        _authRepository.persistToken(response.token ?? "");
        _authRepository.persistUserRole(response.role!.name ?? "");
        _authRepository.persistLoggedInVal(true);
        _authRepository.persistIsKyc(response.isKyc!);
        _authRepository.persistEmail(response.email ?? "");
        _authRepository.persistFullName(response.fullName ?? "");
        _authRepository.persistUserId(response.id!);

        _authRepository
            .persistvirtualAccountName(response.virtualAccountName ?? "");
        _authRepository
            .persistvirtualAccountNo(response.virtualAccountNo ?? "");
        if (response.role!.name.toString() == "INDIVIDUAL_USER") {
          _authRepository.persistEmail(response.email!);
          _authRepository.persistFullName(response.fullName!);
          _authRepository.persistFirstName(
              response.fullName!.split(" ")[0].isEmpty
                  ? ""
                  : response.fullName!.split(" ")[0]);
          _authRepository.persistLastName(
              response.fullName!.split(" ")[1].isEmpty
                  ? ""
                  : response.fullName!.split(" ")[1]);
        }
        
        emit(LoginSuccess(loginResponse: response));
      } else {
        emit(LoginError(error: response.message));
      }
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }
}
