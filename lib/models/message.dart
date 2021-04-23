class Message {
  final String senderId;
  final String receiverId;
  final String text;

  Message({this.receiverId, this.senderId, this.text});

  factory Message.fromJson(json) {
    return Message(
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      text: json["text"],
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();
    data["senderId"] = this.senderId;
    data["receiverId"] = this.receiverId;
    data["text"] = this.text;
    return data;
  }
}
