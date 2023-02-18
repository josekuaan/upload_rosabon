import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/personal_information_request.dart';

import 'package:rosabon/model/response_models/employment_response.dart';
import 'package:rosabon/repository/general_repository.dart';

part 'nextofkin_event.dart';
part 'nextofkin_state.dart';

class NextofkinBloc extends Bloc<NextofkinEvent, NextofkinState> {
  final GeneralRepository _generalRepository = GeneralRepository();
  NextofkinBloc() : super(const NextofkinInitial()) {
    on<NextofkinEvent>((event, emit) async {
      if (event is FetchNextOfKin) {
        // await getNetOfKin(event, emit);
      }
      if (event is NextOfKin) {
        await netOfKin(event, emit);
      }
    });
  }

  // Future<void> getNetOfKin(
  //     FetchNextOfKin event, Emitter<NextofkinState> emit) async {
  //   try {
  //     emit(const NextOfKinLoading());

  //     var res = await _generalRepository.individualPerson(event.id);
  //     print("======tt==========");
  //     print(res);
  //     print("================");
  //     if (res.success!) {
  //       emit(FetchNextOfKinSuccess(banksResponse: res));
  //       print("====eee============");
  //       print(res);
  //       print("================");
  //     }
  //   } catch (e) {}
  // }

  Future<void> netOfKin(NextOfKin event, Emitter<NextofkinState> emit) async {
    try {
      emit(const NextOfKinLoading());
      PersonalInformationRequest personalInformationRequest =
          event.personalInformationRequest;
      var res =
          await _generalRepository.saveNextOfKin(personalInformationRequest);

      if (res.baseStatus) {
        print("========================");
        print(res.nokDetail!.nokAddress);
        print("=======================");
        emit(FetchNextOfKinSuccess(employmentResponse: res));
      }
    } catch (e) {}
  }
}
