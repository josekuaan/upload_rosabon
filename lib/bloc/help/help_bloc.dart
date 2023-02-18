import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/response_models/help_response.dart';
import 'package:rosabon/repository/feedback_repository.dart';

part 'help_event.dart';
part 'help_state.dart';

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  final FeedBackRepository _feedBackRepository = FeedBackRepository();
  HelpBloc() : super(HelpInitial()) {
    on<HelpEvent>((event, emit) async {
      if (event is Help) {
        await fetchhelp(event, emit);
      }
    });
  }

  Future<void> fetchhelp(Help event, Emitter<HelpState> emit) async {
    try {
      emit(const HelpLoading());

      var res = await _feedBackRepository.fetchHelp();
      if (res.baseStatus) {
        emit(HelpSuccess(helpResponse: res));
      }
    } catch (e) {}
  }
}
