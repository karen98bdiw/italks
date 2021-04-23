class Message {
  String id;
  final String senderId;
  final String receiverId;
  final String text;

  Message({this.receiverId, this.senderId, this.text, this.id});

  factory Message.fromJson(json) {
    return Message(
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      text: json["text"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();
    data["senderId"] = this.senderId;
    data["receiverId"] = this.receiverId;
    data["text"] = this.text;
    data["id"] = this.id == null ? DateTime.now().toString() : this.id;
    return data;
  }
}
