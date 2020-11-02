class Message {
  Message({
    this.name,
    this.text,
  });

  final String name;
  final String text;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    name: json["name"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "text": text,
  };
}