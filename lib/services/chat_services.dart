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

      await store.collection(chatsPath).doc().set(chat.toJson());

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

      return Chat.fromJson(chat) ?? null;
    } catch (e) {
      print("error while get chat with user" + e.toString());
      return null;
    }
  }

  Future<Chat> getChatById({String id}) async {
    try {
      var res = await store
          .collection(chatsPath)
          .where("chatId", isEqualTo: "$id")
          .get();
      if (res.docs.length > 0) {
        print(res.docs.length);
        return Chat.fromJson(res.docs[0].data());
      }
      return null;
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
      var res = await store
          .collection(chatsPath)
          .where("chatId", isEqualTo: "$chatId")
          .get();
      store.collection(chatsPath).doc(res.docs[0].id).update(
        {
          "messages": FieldValue.arrayUnion(
            [message.toJson()],
          )
        },
      );
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
