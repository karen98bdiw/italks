class User {
  String userId;
  String name;
  String surname;
  String email;
  String image;

  User({
    this.email,
    this.userId,
    this.image,
    this.name,
    this.surname,
  });

  factory User.fromJson(json) {
    return User(
      userId: json["userId"],
      email: json["email"],
      name: json["name"],
      surname: json["surname"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();

    data["userId"] = this.userId;
    data["email"] = this.email;
    data["name"] = this.name;
    data["surname"] = this.surname;
    data["image"] = this.image;
    return data;
  }
}
