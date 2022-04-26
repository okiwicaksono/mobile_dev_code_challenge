class MessageModel {
  int? id;
  String? body;
  String? attachment;
  String? timestamp;
  String? from;
  String? to;

  MessageModel(
      {this.id,
      this.body,
      this.attachment,
      this.timestamp,
      this.from,
      this.to});

  factory MessageModel.fromJson(dynamic json) {
    return MessageModel(
      id: castInt(json['id']),
      body: castString(json['body']),
      attachment: castString(json['attachment']),
      timestamp: castString(json['timestamp']),
      from: castString(json['from']),
      to: castString(json['to']),
    );
  }
}

String? castString(var object, [String? defaultValue]) {
  defaultValue = "";

  if (object == null && defaultValue == null) return null;

  return object == null ? defaultValue : object as String;
}

int? castInt(var object, [int? defaultValue]) {
  defaultValue = 0;

  if (object == null && defaultValue == null) return null;

  if (object == null) {
    return defaultValue;
  } else {
    if (object is num) {
      return (object).toInt();
    } else if (object is String) {
      return int.tryParse(object);
    } else {
      return null;
    }
  }
}
