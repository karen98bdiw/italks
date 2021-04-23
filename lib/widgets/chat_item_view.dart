import 'package:flutter/material.dart';
import 'package:italk/models/user.dart';

class ChatItemView extends StatelessWidget {
  final User receiver;
  ChatItemView({
    this.receiver,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: receiver.image != null
            ? NetworkImage(receiver.image)
            : AssetImage("assets/images/dummyProfile.png"),
        backgroundColor: Colors.grey[300],
      ),
      title: Text(
        receiver.name + " " + receiver.surname,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        "You: What’s man! · 9:40 AM ",
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.5),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
