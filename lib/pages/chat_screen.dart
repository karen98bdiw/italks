import 'package:cloud_firestore/cloud_firestore.dart';
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
    getChat();
    super.initState();
  }

  getChat() async {
    setState(() {
      isLoading = true;
    });
    ITalkBase().chatServices.getChatById(id: widget.chatId).then((value) {
      if (value != null) {
        setState(() {
          curentChat = value;
          text = value.users[1].email;
          isLoading = false;
        });
      } else {
        print("chat is not fined");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(isLoading);
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                StreamBuilder(
                  builder: (c, AsyncSnapshot<QuerySnapshot> s) {
                    print(s.connectionState);
                    if (s.connectionState == ConnectionState.active) {
                      return s.data.docs.length == 0
                          ? Center(child: Text("Chat is Empty"))
                          : Container(
                              height: 400,
                              child: ListView.builder(
                                itemBuilder: (c, i) {
                                  var m = Message.fromJson(s.data.docs[i]);
                                  return messageItemView(
                                    m.text,
                                  );
                                },
                                itemCount: s.data.docs.length,
                              ),
                            );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  stream: ITalkBase()
                      .chatServices
                      .getMessages(id: curentChat.chatId),
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
