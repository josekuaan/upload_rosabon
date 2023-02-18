import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/personal_information_request.dart';
import 'package:rosabon/model/response_models/employment_response.dart';
import 'package:rosabon/repository/general_repository.dart';

part 'employment_details_event.dart';
part 'employment_details_state.dart';

class EmploymentDetailsBloc
    extends Bloc<EmploymentDetailsEvent, EmploymentDetailsState> {
  final GeneralRepository _generalRepository = GeneralRepository();
  EmploymentDetailsBloc() : super(EmploymentDetailsInitial()) {
    on<EmploymentDetailsEvent>((event, emit) async {
      if (event is SubmitDetails) {
        await employmentDetails(event, emit);
      }
    });
  }

  Future<void> employmentDetails(
      SubmitDetails event, Emitter<EmploymentDetailsState> emit) async {
    try {
      emit(const EmploymentLoading());
      PersonalInformationRequest personalInformationRequest =
          event.personalInformationRequest;
      var res = await _generalRepository
          .employmentDetails(personalInformationRequest);

      if (res.baseStatus) {
        emit(EmploymentSuccess(employmentResponse: res));
      }
    } catch (e) {}
  }
}
