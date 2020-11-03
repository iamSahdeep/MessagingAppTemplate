class Friend {
  Friend({
    this.friendId,
    this.name,
    this.lastMessage,
    this.avatar,
  });

  final int friendId;
  final String name;
  final String lastMessage;
  final String avatar;

  //Changed for Test
  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        friendId: json["id"],
        name: json["first_name"],
        lastMessage: json["last_name"],  //Used last_name as last message
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "friend_id": friendId,
        "name": name,
        "last_message": lastMessage,
        "avatar": avatar,
      };
}
