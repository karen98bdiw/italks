import 'package:italk/models/message.dart';
import 'package:italk/models/user.dart';

class Chat {
  final chatId;
  List<User> users = [];
  List<Message> messages = [];

  Chat({this.chatId});

  factory Chat.fromJson(json) {
    List<Message> chatMessages = [];
    json["messages"] != null
        ? (json["messages"] as List)
            .forEach((e) => chatMessages.add(Message.fromJson(e)))
        : chatMessages = [];

    var chat = Chat(
      chatId: json["chatId"],
    );
    chat.users = json["users"] != null
        ? (json["users"] as List).map((e) => User.fromJson(e)).toList()
        : [];

    chat.messages = chatMessages;
    return chat;
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();

    data["users"] = this.users.map((e) => e.toJson()).toList();
    data["messages"] = this.messages.map((e) => e.toJson()).toList();
    data["chatId"] = this.chatId;
    return data;
  }
}
