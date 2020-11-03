class Message {
  Message({
    this.name,
    this.text,
  });

  final String name;
  final String text;

  //Changed for Test
  factory Message.fromJson(Map<String, dynamic> json) => Message(
    name: json["name"],
    text: json["pantone_value"], // Used some date for text message.
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "text": text,
  };
}