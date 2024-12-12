import '../../domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.id,
    required super.content,
    required super.senderId,
    required super.receiverId,
    required super.createdAt,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      content: map['content'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      createdAt: map['createdAt'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'receiverId': receiverId,
      'createdAt': createdAt,
    };
  }

  Message toEntity() {
    return Message(
      id: id,
      content: content,
      senderId: senderId,
      receiverId: receiverId,
      createdAt: createdAt,
    );
  }
}
