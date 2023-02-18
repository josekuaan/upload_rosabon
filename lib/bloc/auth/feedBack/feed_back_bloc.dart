import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/request_model/createTicket_request.dart';
import 'package:rosabon/model/request_model/replychat_request.dart';
import 'package:rosabon/model/response_models/bank_response.dart';
import 'package:rosabon/model/response_models/ticketCategory_response.dart';
import 'package:rosabon/model/response_models/ticket_response.dart';
import 'package:rosabon/model/response_models/ticketchat_response.dart';
import 'package:rosabon/repository/feedback_repository.dart';

part 'feed_back_event.dart';
part 'feed_back_state.dart';

class FeedBackBloc extends Bloc<FeedBackEvent, FeedBackState> {
  final FeedBackRepository _feedBackRepository = FeedBackRepository();
  FeedBackBloc() : super(const FeedBackInitial()) {
    on<FeedBackEvent>((event, emit) async {
      if (event is CreateTicket) {
        await createTicket(event, emit);
      }
      if (event is FetchCategory) {
        await fetchCategory(event, emit);
      }
      if (event is OpenTicket) {
        await fetchOpenTickets(event, emit);
      }
      if (event is CloseTicket) {
        await fetchCloseTickets(event, emit);
      }
      if (event is TicketReply) {
        await ticketReply(event, emit);
      }
      if (event is ChatReply) {
        await replyChat(event, emit);
      }
    });
  }

  Future<void> createTicket(
      CreateTicket event, Emitter<FeedBackState> emit) async {
    try {
      emit(const CreateticketLoading());

      CreateTicketrequest createTicketrequest = event.createTicketrequest;

      var res = await _feedBackRepository.createTicket(createTicketrequest);
      if (res.success!) {
        emit(CreateticketSuccess(banksResponse: res));
      }
    } catch (e) {
      emit(CreatingticketError(error: e.toString()));
    }
  }

  Future<void> fetchCategory(
      FetchCategory event, Emitter<FeedBackState> emit) async {
    try {
      emit(const CategoryLoading());

      var res = await _feedBackRepository.fetchCategory();
      if (res.baseStatus) {
        emit(CategorySuccess(ticketCategoryResponse: res));
      }
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  Future<void> fetchOpenTickets(
      OpenTicket event, Emitter<FeedBackState> emit) async {
    try {
      emit(const CategoryLoading());

      var res = await _feedBackRepository.openTickets();
      if (res.baseStatus) {
        emit(OpenTicketSuccess(ticketResponse: res));
      }
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  Future<void> fetchCloseTickets(
      CloseTicket event, Emitter<FeedBackState> emit) async {
    try {
      emit(const CategoryLoading());

      var res = await _feedBackRepository.closeTickets();
      if (res.baseStatus) {
        emit(CloseTicketSuccess(ticketResponse: res));
      }
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  Future<void> ticketReply(
      TicketReply event, Emitter<FeedBackState> emit) async {
    try {
      emit(const ChatLoading());

      var res = await _feedBackRepository.ticketReply(event.id);
      if (res.baseStatus) {
        emit(ChatTicketSuccess(ticketChatResponse: res));
      }
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  Future<void> replyChat(ChatReply event, Emitter<FeedBackState> emit) async {
    try {
      // emit(const ChatLoading());
      ReplyCahtrequest replyCahtrequest = event.replyCahtrequest;
      var res = await _feedBackRepository.replyChat(replyCahtrequest);
      if (res.baseStatus) {
        emit(ReplySuccess(ticketChatResponse: res));
      }
    } catch (e) {}
  }
}
