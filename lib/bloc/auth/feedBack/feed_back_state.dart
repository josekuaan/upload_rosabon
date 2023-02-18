part of 'feed_back_bloc.dart';

abstract class FeedBackState extends Equatable {
  const FeedBackState();

  @override
  List<Object> get props => [];
}

class FeedBackInitial extends FeedBackState {
  const FeedBackInitial();
}

class CreateticketLoading extends FeedBackState {
  const CreateticketLoading();
}

class ChatLoading extends FeedBackState {
  const ChatLoading();
}

class CategoryLoading extends FeedBackState {
  const CategoryLoading();
}

class TicketLoading extends FeedBackState {
  const TicketLoading();
}

class CategorySuccess extends FeedBackState {
  final TicketCategoryResponse ticketCategoryResponse;
  const CategorySuccess({required this.ticketCategoryResponse});
  @override
  List<Object> get props => [ticketCategoryResponse];
}

class OpenTicketSuccess extends FeedBackState {
  final TicketResponse ticketResponse;
  const OpenTicketSuccess({required this.ticketResponse});
  @override
  List<Object> get props => [ticketResponse];
}

class ChatTicketSuccess extends FeedBackState {
  final TicketChatResponse ticketChatResponse;
  const ChatTicketSuccess({required this.ticketChatResponse});
  @override
  List<Object> get props => [ticketChatResponse];
}

class ReplySuccess extends FeedBackState {
  final TicketChatResponse ticketChatResponse;
  const ReplySuccess({required this.ticketChatResponse});
  @override
  List<Object> get props => [ticketChatResponse];
}

class CreateticketSuccess extends FeedBackState {
  final BanksResponse banksResponse;
  const CreateticketSuccess({required this.banksResponse});
  @override
  List<Object> get props => [banksResponse];
}

class CloseTicketSuccess extends FeedBackState {
  final TicketResponse ticketResponse;
  const CloseTicketSuccess({required this.ticketResponse});
  @override
  List<Object> get props => [ticketResponse];
}

class CreatingticketError extends FeedBackState {
  final String error;
  const CreatingticketError({required this.error});
  @override
  List<Object> get props => [error];
}

class ChatError extends FeedBackState {
  final String error;
  const ChatError({required this.error});
  @override
  List<Object> get props => [error];
}
