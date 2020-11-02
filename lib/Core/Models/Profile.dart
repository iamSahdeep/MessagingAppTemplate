class Profile {
  Profile({
    this.id,
    this.email,
    this.name,
    this.avatar,
  });

  final int id;
  final String email;
  final String name;
  final String avatar;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        email: json["email"],
        name: json["first_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "avatar": avatar,
      };
}
