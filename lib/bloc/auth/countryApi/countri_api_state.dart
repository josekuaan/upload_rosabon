part of 'countri_api_bloc.dart';

abstract class CountryApiState extends Equatable {
  const CountryApiState();

  @override
  List<Object> get props => [];
}

class CountriApiInitial extends CountryApiState {
  const CountriApiInitial();
}

class FetchLoading extends CountryApiState {
  const FetchLoading();
  @override
  List<Object> get props => [];
}

class FetchSuccess extends CountryApiState {
  final CountryResponse countryResponse;
  const FetchSuccess({required this.countryResponse});

  @override
  List<Object> get props => [countryResponse];
}

class FetchStateSuccess extends CountryApiState {
  final StateResponse stateResponse;
  const FetchStateSuccess({required this.stateResponse});

  @override
  List<Object> get props => [stateResponse];
}
