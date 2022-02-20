part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent extends Equatable{
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetListChat extends ChatEvent{
  @override
  List<Object> get props => [];
}
