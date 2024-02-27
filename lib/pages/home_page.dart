import 'package:bop_gpt_ios/bloc/chat_bloc_bloc.dart';
import 'package:bop_gpt_ios/models/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBlocBloc chatBlocBloc = ChatBlocBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBlocBloc, ChatBlocState>(
        bloc: chatBlocBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.95,
                    image: AssetImage('assets/wallpaper.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      height: 110,
                      // color: Color.fromARGB(161, 17, 198, 253),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "BOP Chat",
                            style: TextStyle(
                              fontSize: 33,
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                            ),
                          ),
                          // the search icon
                          InkWell(
                            child: Icon(
                              Icons.gpp_good_rounded,
                              size: 38,
                              color: Color.fromARGB(255, 0, 103, 119),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 12, left: 16, right: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color.fromARGB(255, 142, 142, 142)
                                  .withOpacity(0.7),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  messages[index].role == 'user'
                                      ? 'You'
                                      : 'Bop Chat',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: messages[index].role == 'user'
                                        ? Colors.blue.shade200
                                        : Colors.pink.shade200,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  messages[index].parts.first.text,
                                  style: TextStyle(height: 1.5),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    if (chatBlocBloc.generating)
                      Container(
                        height: 120,
                        width: 120,
                        child: Lottie.asset(
                          'assets/loader.json',
                        ),
                      ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                      // height: 120,
                      // color: Colors.blue,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                fillColor:
                                    const Color.fromARGB(255, 248, 248, 248),
                                hintText: "Type a message",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          InkWell(
                            onTap: () {
                              if (textEditingController.text.isNotEmpty) {
                                String text = textEditingController.text;
                                textEditingController.clear();
                                chatBlocBloc.add(
                                  ChatGenerateNewTextEvent(
                                    inputMessage: text,
                                  ),
                                );
                              }
                            },
                            child: const CircleAvatar(
                              radius: 34,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blueGrey,
                                child: Center(
                                  // the send icon
                                  child: Icon(
                                    Icons.fingerprint,
                                    color: Colors.white,
                                    size: 55,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
