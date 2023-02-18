import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/company_details_update_request.dart';
import 'package:rosabon/model/request_model/kyc_request.dart';
import 'package:rosabon/model/response_models/base_response.dart';
import 'package:rosabon/model/response_models/kyc_response.dart';
import 'package:rosabon/repository/auth_repository.dart';
import 'package:rosabon/repository/profile_repository.dart';

part 'company_kyc_event.dart';
part 'company_kyc_state.dart';

class CompanyKycBloc extends Bloc<CompanyKycEvent, CompanyKycState> {
  final AuthRepository _authRepository = AuthRepository();
  final ProfileRepository _profileRepository = ProfileRepository();
  CompanyKycBloc() : super(CompanyKycInitial()) {
    on<CompanyKycEvent>((event, emit) async {
      if (event is CompanyKyc) {
        await companyKyc(event, emit);
      }
      if (event is CompanyUpdate) {
        await companyUpdate(event, emit);
      }
    });
  }

  Future<void> companyKyc(
      CompanyKyc event, Emitter<CompanyKycState> emit) async {
    try {
      emit(const CompanyKycLoading());

      KycRequest kycRequest = event.kycRequest;

      var response = await _authRepository.kyc(kycRequest);

      if (response.baseStatus) {
        _authRepository.persistIsKyc(event.kycRequest.isKyc!);
        emit(CompanyKycSuccess(kycResponse: response));
      } else {
        emit(CompanyKycError(error: response.message));
      }
    } catch (e) {
      emit(CompanyKycError(error: e.toString()));
    }
  }

  Future<void> companyUpdate(
      CompanyUpdate event, Emitter<CompanyKycState> emit) async {
    try {
      emit(const CompanyKycLoading());

      CompanyDetailsUpdateequest companyDetailsUpdateequest =
          event.companyDetailsUpdateequest;

      var response =
          await _profileRepository.companyUpdate(companyDetailsUpdateequest);

      if (response.baseStatus) {
        
        emit(CompanyUpdateSuccess(baseResponse: response));
      } else {
        emit(CompanyKycError(error: response.message));
      }
    } catch (e) {
      emit(CompanyKycError(error: e.toString()));
    }
  }
}
