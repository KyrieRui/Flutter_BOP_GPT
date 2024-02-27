import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bop_gpt_ios/models/chat_message_model.dart';
import 'package:bop_gpt_ios/repos/chat_repo.dart';
import 'package:meta/meta.dart';

part 'chat_bloc_event.dart';
part 'chat_bloc_state.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  ChatBlocBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextEvent>(chatGenerateNewTextEvent);
  }
  List<ChatMessageModel> messages = [];
  bool generating = false;

  FutureOr<void> chatGenerateNewTextEvent(
      ChatGenerateNewTextEvent event, Emitter<ChatBlocState> emit) async {
    messages.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.inputMessage)]));
    emit(ChatSuccessState(messages: messages));

    generating = true;

    String generatedText = await BopRepo.chatTextGenerationRepo(messages);
    if (generatedText.length > 0) {
      messages.add(ChatMessageModel(
          role: 'model', parts: [ChatPartModel(text: generatedText)]));
      emit(ChatSuccessState(messages: messages));
    }

    generating = false;
  }
}
