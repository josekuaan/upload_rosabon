import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/bank_request.dart';
import 'package:rosabon/model/request_model/personal_information_request.dart';
import 'package:rosabon/model/request_model/verify_account_request.dart';
import 'package:rosabon/model/response_models/accountnumber_response.dart';
import 'package:rosabon/model/response_models/bank_response.dart';
import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/update_account_response.dart';
import 'package:rosabon/model/response_models/verifyaccount_response.dart';
import 'package:rosabon/model/response_models/virtualacount_response.dart';
import 'package:rosabon/repository/general_repository.dart';

part 'bank_event.dart';
part 'bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  final GeneralRepository _generalRepository = GeneralRepository();
  BankBloc() : super(const BankInitial()) {
    on<BankEvent>((event, emit) async {
      if (event is FetchBanks) {
        await bank(event, emit);
      }
      if (event is VerifyAccount) {
        await verifyBank(event, emit);
      }

      if (event is UpdateBankAccount) {
        await updateBankAccount(emit, event);
      }
      if (event is FetchBankAccount) {
        await fetchBankAccount(event, emit);
      }
      if (event is Otp) {
        await postotpCode(event, emit);
      }
      if (event is ValidateOtp) {
        await validateOtp(event, emit);
      }
      if (event is ValidatePhone) {
        print("got here");
        await validatePhone(event, emit);
      }
      if (event is VirtualAccount) {
        await fetchVirtualAccount(event, emit);
      }
      if (event is ViewBankDetail) {
        await viewbankdetails(event, emit);
      }
    });
  }

  Future<void> bank(FetchBanks event, Emitter<BankState> emit) async {
    try {
      emit(const FetchBankLoading());

      var res = await _generalRepository.banks();

      if (res.success!) {
        emit(FetchBankSuccess(banksResponse: res));
      }
    } catch (e) {}
  }

  Future<void> fetchBankAccount(
      FetchBankAccount event, Emitter<BankState> emit) async {
    try {
      emit(const FetchBankLoading());

      var res = await _generalRepository.fetchBankAccount();

      if (res.baseStatus) {
        emit(FetchAccountSuccess(bankAccountResponse: res));
      }
    } catch (e) {
      emit(VerifyAccountError(error: e.toString()));
    }
  }

  Future<void> viewbankdetails(
      ViewBankDetail event, Emitter<BankState> emit) async {
    try {
      emit(const FetchBankLoading());

      var res = await _generalRepository.viewbankdetails(event.id);

      if (res.baseStatus) {
        emit(VirtualAccountSuccess(virtualAccountResponse: res));
      }
    } catch (e) {
      emit(VerifyAccountError(error: e.toString()));
    }
  }

  Future<void> fetchVirtualAccount(
      VirtualAccount event, Emitter<BankState> emit) async {
    try {
      emit(const FetchBankLoading());

      var res =
          await _generalRepository.virtualAccount(event.planName, event.action);

      if (res.baseStatus) {
        emit(VirtualAccountSuccess(virtualAccountResponse: res));
      }
    } catch (e) {}
  }

  Future<void> postotpCode(Otp event, Emitter<BankState> emit) async {
    try {
      // emit(const FetchBankLoading());

      var res = await _generalRepository.postOtpCode();

      if (res.baseStatus) {
        emit(OtpSuccess(baseResponse: res));
      } else {
        emit(OtpError(error: res.message));
      }
    } catch (e) {
      emit(OtpError(error: e.toString()));
    }
  }

  Future<void> validateOtp(ValidateOtp event, Emitter<BankState> emit) async {
    try {
      emit(const OtpLoading());

      var res = await _generalRepository.validateOtp(event.otp);

      if (res.baseStatus) {
        emit(OtpSuccess(baseResponse: res));
      } else {
        emit(OtpError(error: res.message));
      }
    } catch (e) {
      emit(OtpError(error: e.toString()));
    }
  }

  Future<void> validatePhone(
      ValidatePhone event, Emitter<BankState> emit) async {
    try {
      print("ddddddddddddddddd");
      var res = await _generalRepository
          .validatePhone(event.personalInformationRequest!.secondaryPhone!);

      if (res.baseStatus) {
        emit(PhoneVerified(baseResponse: res));
      } else {
        emit(OtpError(error: res.message));
      }
    } catch (e) {
      emit(OtpError(error: e.toString()));
    }
  }

  Future<void> verifyBank(VerifyAccount event, Emitter<BankState> emit) async {
    try {
      emit(const VerifyAccountLoading());

      VerifyAccountRequest verifyAccountRequest = event.verifyAccountRequest;

      var res = await _generalRepository.verifyBank(verifyAccountRequest);

      if (res.baseStatus) {
        emit(VerifyAccountSuccess(verifyAccountResponse: res));
      } else {
        emit(VerifyAccountError(error: res.message));
      }
    } catch (e) {
      emit(VerifyAccountError(error: e.toString()));
    }
  }

  Future<void> updateBankAccount(
      Emitter<BankState> emit, UpdateBankAccount event) async {
    try {
      emit(const BankLoading());

      BankRequest bankRequest = event.bankRequest;

      var res = await _generalRepository.updateBankAccount(bankRequest);

      if (res.baseStatus) {
        emit(BankSavedSuccess(updateAccountResponse: res));
      } else {
        emit(BankSavedError(error: res.message));
      }
    } catch (e) {
      emit(BankSavedError(error: e.toString()));
    }
  }
}
