import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/response_models/base_response.dart';

import 'package:rosabon/model/response_models/director_response.dart';

import 'package:rosabon/repository/director_repository.dart';

part 'director_event.dart';
part 'director_state.dart';

class DirectorBloc extends Bloc<DirectorEvent, DirectorState> {
  final DirectorRepository _directorRepository = DirectorRepository();
  DirectorBloc() : super(const DirectorInitial()) {
    on<DirectorEvent>((event, emit) async {
      if (event is FetchDirector) {
        await fetchDirectors(event, emit);
      }
      if (event is SendOtpDirector) {
        await sendOtpDirectors(event, emit);
      }
      if (event is SaveDirector) {
        await saveDirector(event, emit);
      }
      if (event is DeleteDirector) {
        await deleteDirector(event, emit);
      }
    });
  }

  Future<void> fetchDirectors(
      FetchDirector event, Emitter<DirectorState> emit) async {
    try {
      emit(const DirectorLoading());

      var res = await _directorRepository.fetchDirectors();

      if (res.baseStatus) {
        emit(DirectorSuccess(directorResponse: res));
      }
    } catch (e) {
      emit(DirectorError(error: e.toString()));
    }
  }

  Future<void> sendOtpDirectors(
      SendOtpDirector event, Emitter<DirectorState> emit) async {
    try {
      emit(const SendingOtp());

      var res = await _directorRepository.sendOtpDirectors();

      if (res.baseStatus) {
        emit(OtpRecieved(baseResponse: res));
      }
    } catch (e) {
      emit(DirectorError(error: e.toString()));
    }
  }

  Future<void> saveDirector(
      SaveDirector event, Emitter<DirectorState> emit) async {
    try {
      emit(const DirectorLoading());

      var res = await _directorRepository.saveDirector(event.directorRequest);

      if (res.baseStatus) {
        emit(DirectorSuccess(directorResponse: res));
      } else {
        emit(DirectorError(error: res.message));
      }
    } catch (e) {
      emit(DirectorError(error: e.toString()));
    }
  }

  Future<void> deleteDirector(
      DeleteDirector event, Emitter<DirectorState> emit) async {
    try {
      // emit(const DirectorLoading());
      var res = await _directorRepository.deleteDirector(event.id);
      if (res.baseStatus) {
        // emit(DeleteSuccess(baseResponse: res));
      } else {
        emit(DirectorError(error: res.message));
      }
    } catch (e) {
      emit(DirectorError(error: e.toString()));
    }
  }
}
