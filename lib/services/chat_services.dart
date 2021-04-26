import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:italk/models/chat.dart';
import 'package:italk/models/message.dart';
import 'package:italk/services/i_talk_base.dart';
import 'package:italk/utils/api_paths.dart';
import '../models/user.dart' as custom;

class ChatServices {
  final FirebaseAuth auth;
  final FirebaseFirestore store;
  Chat currentChat;

  ChatServices({this.auth, this.store});

  Future<Chat> createChat({
    custom.User firstUser,
    custom.User secondUser,
  }) async {
    try {
      var chat = Chat(
        chatId: DateTime.now().toString(),
      );
      chat.users.add(firstUser);
      chat.users.add(secondUser);

      await store.collection(chatsPath).doc(chat.chatId).set(chat.toJson());

      var res =
          await getChatWithUser(firstUser: firstUser, secondUser: secondUser);
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Chat> getChatWithUser({
    custom.User firstUser,
    custom.User secondUser,
  }) async {
    try {
      var res = await store.collection(chatsPath).get();
      var chat = res.docs.firstWhere((element) {
        if (Chat.fromJson(element).users[0].userId == firstUser.userId &&
                Chat.fromJson(element).users[1].userId == secondUser.userId ||
            Chat.fromJson(element).users[1].userId == firstUser.userId &&
                Chat.fromJson(element).users[0].userId == secondUser.userId) {
          return true;
        }
        return false;
      }, orElse: () => null);
      var curent = Chat.fromJson(chat);
      var a = [];
      var mes = await store
          .collection(chatsPath)
          .doc(curent.chatId)
          .collection("mess")
          .get();
      for (int i = 0; i < mes.docs.length; i++) {
        a.add(Message.fromJson(mes.docs[i]));
      }
      curent.messages = a;
      return curent;
    } catch (e) {
      print("error while get chat with user" + e.toString());
      return null;
    }
  }

  Future<Chat> getChatById({String id}) async {
    try {
      var res = await store.collection(chatsPath).doc(id).get();

      return Chat.fromJson(res.data());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Chat>> getUserAllChats() async {
    try {
      var res = await store.collection(chatsPath).get();
      List<Chat> chats = [];

      res.docs.forEach((element) {
        var chat = Chat.fromJson(element);
        chat.users.forEach((e) {
          if (e.userId == ITalkBase().profileService.curentUser.userId) {
            chats.add(Chat.fromJson(element));
          }
        });
      });
      print("chats length in future ${res.docs.length}");
      return chats;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<bool> sendMessage({String chatId, Message message}) async {
    try {
      var res = store
          .collection(chatsPath)
          .doc(chatId)
          .collection("mess")
          .add(message.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  getMessages({String id}) {
    print(id);
    var res =
        store.collection(chatsPath).doc(id).collection("mess").snapshots();

    // List<Message> a = [];

    // for (int i = 0; i < res.docs.length; i++) {
    //   a.add(Message.fromJson(res.docs[i]));
    // }

    return res;
  }
}
