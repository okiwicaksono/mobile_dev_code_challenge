import 'dart:convert';

class Message {
  int id;
  String body;
  String? attachment;
  String timestamp;
  String from;
  String to;
  bool group;
  Message({
    required this.id,
    required this.body,
    this.attachment,
    required this.timestamp,
    required this.from,
    required this.to,
    required this.group,
  });

  DateTime get dateSend =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);

  Message copyWith({
    int? id,
    String? body,
    String? attachment,
    String? timestamp,
    String? from,
    String? to,
    bool? group,
  }) {
    return Message(
      id: id ?? this.id,
      body: body ?? this.body,
      attachment: attachment ?? this.attachment,
      timestamp: timestamp ?? this.timestamp,
      from: from ?? this.from,
      to: to ?? this.to,
      group: group ?? this.group,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': body,
      'attachment': attachment,
      'timestamp': timestamp,
      'from': from,
      'to': to,
      'group': group,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id']?.toInt() ?? 0,
      body: map['body'] ?? '',
      attachment: map['attachment'],
      timestamp: map['timestamp'] ?? '',
      from: map['from'] ?? '',
      to: map['to'] ?? '',
      group: map['group'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(id: $id, body: $body, attachment: $attachment, timestamp: $timestamp, from: $from, to: $to, group: $group)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.id == id &&
        other.body == body &&
        other.attachment == attachment &&
        other.timestamp == timestamp &&
        other.from == from &&
        other.to == to &&
        other.group == group;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        body.hashCode ^
        attachment.hashCode ^
        timestamp.hashCode ^
        from.hashCode ^
        to.hashCode ^
        group.hashCode;
  }
}

List<Message> messageList =
    List<Message>.from(dataList['data'].map((e) => Message.fromMap(e)))
      ..sort((a, b) => a.dateSend.compareTo(b.dateSend));

Map<String, dynamic> dataList = {
  "data": [
    {
      "id": 1,
      "body": "pesan pertama",
      "attachment": null,
      "timestamp": "1544086218",
      "from": "A",
      "to": "B"
    },
    {
      "id": 2,
      "body": "gambar pertama",
      "attachment": "image",
      "timestamp": "1544086398",
      "from": "A",
      "to": "B"
    },
    {
      "id": 3,
      "body": null,
      "attachment": "image",
      "timestamp": "1544086458",
      "from": "A",
      "to": "B"
    },
    {
      "id": 4,
      "body": null,
      "attachment": "image",
      "timestamp": "1544086518",
      "from": "A",
      "to": "B"
    },
    {
      "id": 5,
      "body": null,
      "attachment": "image",
      "timestamp": "1544086698",
      "from": "B",
      "to": "A"
    },
    {
      "id": 6,
      "body": "pesan kedua",
      "attachment": null,
      "timestamp": "1544086938",
      "from": "B",
      "to": "A"
    },
    {
      "id": 7,
      "body": null,
      "attachment": "contact",
      "timestamp": "1544087118",
      "from": "A",
      "to": "B"
    },
    {
      "id": 8,
      "body": null,
      "attachment": "contact",
      "timestamp": "1544087418",
      "from": "A",
      "to": "B"
    },
    {
      "id": 9,
      "body": null,
      "attachment": "contact",
      "timestamp": "1544163018",
      "from": "A",
      "to": "B"
    },
    {
      "id": 10,
      "body": null,
      "attachment": "contact",
      "timestamp": "1544163198",
      "from": "A",
      "to": "B"
    },
    {
      "id": 11,
      "body": null,
      "attachment": "contact",
      "timestamp": "1544163618",
      "from": "A",
      "to": "B"
    },
    {
      "id": 12,
      "body": "pesan ketiga",
      "attachment": null,
      "timestamp": "1544167218",
      "from": "A",
      "to": "B"
    },
    {
      "id": 13,
      "body": "pesan keempat",
      "attachment": null,
      "timestamp": "1544167818",
      "from": "B",
      "to": "A"
    },
    {
      "id": 14,
      "body": "pesan kelima",
      "attachment": null,
      "timestamp": "1544168058",
      "from": "A",
      "to": "B"
    },
    {
      "id": 15,
      "body": null,
      "attachment": "document",
      "timestamp": "1544170458",
      "from": "A",
      "to": "B"
    },
    {
      "id": 16,
      "body": null,
      "attachment": "image",
      "timestamp": "1544170818",
      "from": "B",
      "to": "A"
    },
    {
      "id": 17,
      "body": null,
      "attachment": "image",
      "timestamp": "1544250018",
      "from": "B",
      "to": "A"
    },
    {
      "id": 18,
      "body": null,
      "attachment": "image",
      "timestamp": "1544250138",
      "from": "B",
      "to": "A"
    },
    {
      "id": 19,
      "body": null,
      "attachment": "image",
      "timestamp": "1544250258",
      "from": "B",
      "to": "A"
    },
    {
      "id": 20,
      "body": "pesan kelima",
      "attachment": null,
      "timestamp": "1544257458",
      "from": "B",
      "to": "A"
    },
    {
      "id": 21,
      "body": "gambar kedua",
      "attachment": "image",
      "timestamp": "1544257818",
      "from": "A",
      "to": "B"
    },
    {
      "id": 22,
      "body": null,
      "attachment": "contact",
      "timestamp": "1544258118",
      "from": "A",
      "to": "B"
    },
    {
      "id": 23,
      "body": null,
      "attachment": "contact",
      "timestamp": "1544258178",
      "from": "A",
      "to": "B"
    },
    {
      "id": 24,
      "body": null,
      "attachment": "contact",
      "timestamp": "1544258238",
      "from": "A",
      "to": "B"
    },
    {
      "id": 25,
      "body": null,
      "attachment": "contact",
      "timestamp": "1544258298",
      "from": "A",
      "to": "B"
    },
    {
      "id": 26,
      "body": null,
      "attachment": "image",
      "timestamp": "1544260158",
      "from": "A",
      "to": "B"
    },
    {
      "id": 27,
      "body": null,
      "attachment": "image",
      "timestamp": "1544335758",
      "from": "A",
      "to": "B"
    },
    {
      "id": 28,
      "body": null,
      "attachment": "image",
      "timestamp": "1544335818",
      "from": "A",
      "to": "B"
    },
    {
      "id": 29,
      "body": null,
      "attachment": "image",
      "timestamp": "1544335878",
      "from": "A",
      "to": "B"
    },
    {
      "id": 30,
      "body": null,
      "attachment": "image",
      "timestamp": "1544335938",
      "from": "A",
      "to": "B"
    },
    {
      "id": 31,
      "body": "gambar ketiga",
      "attachment": "image",
      "timestamp": "1544339538",
      "from": "A",
      "to": "B"
    }
  ]
};
