part of 'get_messages_cubit.dart';

@immutable
abstract class GetMessagesState {}

class GetMessagesLoading extends GetMessagesState {}

class GetMessagesLoaded extends GetMessagesState {
  final List<MessageModel> messages;
  final List<List<MessageModel>> groupMessages;
  GetMessagesLoaded({
    required this.messages,
    required this.groupMessages,
  });
}

class GetMessagesError extends GetMessagesState {
  final String message;

  GetMessagesError(this.message);
}
