import 'package:flutter/material.dart';
import 'package:italk/models/chat.dart';
import 'package:italk/models/user.dart';
import 'package:italk/services/i_talk_base.dart';
import 'package:italk/widgets/chat_item_view.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final user = ITalkBase().profileService.curentUser;

  List<Chat> userChats = [];
  List<User> allUsers = [];
  bool isLaoding = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    setState(() {
      isLaoding = true;
    });

    userChats = await ITalkBase().chatServices.getUserAllChats();
    print("user chats length:${userChats.length}");
    allUsers = await ITalkBase().profileService.getAllUsers();

    setState(() {
      isLaoding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isLaoding
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  appBar(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (c, i) => userViewItem(allUsers[i]),
                      itemCount: allUsers.length,
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: userChats.length == 0
                          ? Center(
                              child: Text(
                                "You dont have chats yet...",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (e, i) => ChatItemView(
                                receiver: userChats[i].users.firstWhere(
                                      (element) =>
                                          element.userId != user.userId,
                                    ),
                              ),
                              itemCount: userChats.length,
                            )),
                ],
              ),
      ),
    );
  }

  Widget userViewItem(User user) => GestureDetector(
        onTap: () async {
          setState(() {
            isLaoding = true;
          });
          var res = await ITalkBase().chatServices.createChat(
                firstUser: ITalkBase().profileService.curentUser,
                secondUser: user,
              );
          if (res != null) {
            userChats = await ITalkBase().chatServices.getUserAllChats();
          }
          setState(() {
            isLaoding = false;
            print(res != null ? "chat is created" : "somehting wenth wrong");
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: user.image != null
                    ? NetworkImage(user.image)
                    : AssetImage("assets/images/dummyProfile.png"),
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                user.name + " " + user.surname,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      );

  Widget appBar() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: user.image != null
                    ? NetworkImage(user.image)
                    : AssetImage("assets/images/dummyProfile.png"),
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "Chats",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.camera_alt,
                size: 30,
              ),
              SizedBox(
                width: 12,
              ),
              Icon(
                Icons.online_prediction_rounded,
                size: 30,
              ),
            ],
          ),
        ],
      );
}
