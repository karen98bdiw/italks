import 'package:flutter/material.dart';
import 'package:italk/i_talk_app.dart';
import 'package:italk/models/chat.dart';
import 'package:italk/models/message.dart';
import 'package:italk/services/i_talk_base.dart';
import 'package:italk/widgets/inputs.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;

  ChatScreen({this.chatId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var text = "placeholde";
  Chat curentChat;
  bool isLoading = false;

  var messageController = TextEditingController();
  @override
  void initState() {
    ITalkBase().chatServices.getChatById(id: widget.chatId).then((value) {
      if (value != null) {
        setState(() {
          curentChat = value;
          text = value.users[1].email;
        });
      } else {
        print("chat is not fined");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            builder: (c, s) {
              print(s.connectionState.toString());
              if (s.connectionState == ConnectionState.done) {
                print("this is called");
                print(s.data.messages.length);
                return s.data.messages.length == 0
                    ? Center(child: Text("Chat is Empty"))
                    : Container(
                        height: 400,
                        child: ListView.builder(
                          itemBuilder: (c, i) => messageItemView(
                            s.data.messages[i].text,
                          ),
                          itemCount: s.data.messages.length,
                        ),
                      );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            future: ITalkBase().chatServices.getChatById(id: widget.chatId),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: MainInput(
                      controller: messageController,
                      hint: "Message",
                    ),
                  ),
                  isLoading
                      ? CircularProgressIndicator()
                      : IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                              ITalkBase().chatServices.sendMessage(
                                    chatId: widget.chatId,
                                    message: Message(
                                      senderId: ITalkBase()
                                          .profileService
                                          .curentUser
                                          .userId,
                                      receiverId: curentChat.users
                                          .firstWhere((element) =>
                                              element.userId !=
                                              ITalkBase()
                                                  .profileService
                                                  .curentUser
                                                  .userId)
                                          .userId,
                                      text: messageController.text,
                                    ),
                                  );
                            });
                            setState(() {
                              isLoading = false;
                            });
                          }),
                ],
              ))
        ],
      ),
    );
  }

  Widget messageItemView(text) => Text(text);
}
