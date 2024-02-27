part of 'chat_bloc_bloc.dart';

@immutable
sealed class ChatBlocEvent {}

class ChatGenerateNewTextEvent extends ChatBlocEvent {
  final String inputMessage;
  ChatGenerateNewTextEvent({
    required this.inputMessage,
  });
}
