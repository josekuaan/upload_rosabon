part of 'feed_back_bloc.dart';

abstract class FeedBackEvent extends Equatable {
  const FeedBackEvent();

  @override
  List<Object> get props => [];
}

class CreateTicket extends FeedBackEvent {
  const CreateTicket({required this.createTicketrequest});
  final CreateTicketrequest createTicketrequest;
  @override
  List<Object> get props => [];
}

class FetchCategory extends FeedBackEvent {
  const FetchCategory();

  @override
  List<Object> get props => [];
}

class OpenTicket extends FeedBackEvent {
  const OpenTicket();

  @override
  List<Object> get props => [];
}

class CloseTicket extends FeedBackEvent {
  const CloseTicket();

  @override
  List<Object> get props => [];
}

class TicketReply extends FeedBackEvent {
  final int id;
  const TicketReply({required this.id});

  @override
  List<Object> get props => [id];
}

class ChatReply extends FeedBackEvent {
  final ReplyCahtrequest replyCahtrequest;
  const ChatReply({required this.replyCahtrequest});

  @override
  List<Object> get props => [replyCahtrequest];
}
