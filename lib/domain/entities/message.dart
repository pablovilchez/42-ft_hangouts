class Message {
  final int id;
  final String content;
  final int senderId;
  final int receiverId;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': content,
      'senderId': senderId,
      'receiverId': receiverId,
      'createdAt': createdAt,
    };
  }
}
