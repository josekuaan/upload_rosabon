import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/response_models/country_response.dart';
import 'package:rosabon/model/response_models/state_response.dart';
import 'package:rosabon/repository/auth_repository.dart';

part 'countri_api_event.dart';
part 'countri_api_state.dart';

class CountryApiBloc extends Bloc<CountryApiEvent, CountryApiState> {
  final AuthRepository _authRepository = AuthRepository();
  CountryApiBloc() : super(const CountriApiInitial()) {
    on<CountryApiEvent>((event, emit) async {
      if (event is Fetch) {
        await fetchCountries(event, emit);
      }
    });
  }

  Future<void> fetchCountries(
      Fetch event, Emitter<CountryApiState> emit) async {
    try {
      var res;
      emit(const FetchLoading());

      if (event.name == "country") {
        res = await _authRepository.fetchCountries(event);
        if (res.baseStatus) {
          emit(FetchSuccess(countryResponse: res));
        }
      } else {
        res = await _authRepository.fetchState(event);

        if (res.baseStatus) {
          emit(FetchStateSuccess(stateResponse: res));
        }
      }
    } catch (e) {}
  }
}
