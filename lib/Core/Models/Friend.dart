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

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        friendId: json["friend_id"],
        name: json["name"],
        lastMessage: json["last_message"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "friend_id": friendId,
        "name": name,
        "last_message": lastMessage,
        "avatar": avatar,
      };
}
