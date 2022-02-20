part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];

}

class ChatInitial extends ChatState {}

class Loading extends ChatState {}

class Loaded extends ChatState{
  final List<ChatModel> listChat;

  const Loaded(this.listChat);

  @override
  List<Object> get props => [listChat];
}

class Error extends ChatState{
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
