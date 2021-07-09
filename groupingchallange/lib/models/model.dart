// // To parse this JSON data, do
// //
// //     final messageDataset = messageDatasetFromJson(jsonString);

// import 'dart:convert';

// MessageDataset messageDatasetFromJson(String str) =>
//     MessageDataset.fromJson(json.decode(str));

// String messageDatasetToJson(MessageDataset data) => json.encode(data.toJson());

// class MessageDataset {
//   MessageDataset({
//     required this.data,
//   });

//   late List<Datum> data;

//   factory MessageDataset.fromJson(Map<String, dynamic> json) => MessageDataset(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   Datum({
//     required this.id,
//     this.body,
//     this.attachment,
//     required this.timestamp,
//     required this.from,
//     required this.to,
//   });

//   int id;
//   String? body;
//   Attachment? attachment;
//   late String timestamp;
//   late From from;
//   late From to;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         body: json["body"] == null ? null : json["body"],
//         attachment: json["attachment"] == null
//             ? null
//             : attachmentValues.map[json["attachment"]],
//         timestamp: json["timestamp"],
//         from: fromValues.map[json["from"]]!,
//         to: fromValues.map[json["to"]]!,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "body": body == null ? null : body,
//         "attachment":
//             attachment == null ? null : attachmentValues.reverse[attachment],
//         "timestamp": timestamp,
//         "from": fromValues.reverse[from],
//         "to": fromValues.reverse[to],
//       };
// }

// enum Attachment { IMAGE, CONTACT, DOCUMENT }

// final attachmentValues = EnumValues({
//   "contact": Attachment.CONTACT,
//   "document": Attachment.DOCUMENT,
//   "image": Attachment.IMAGE
// });

// enum From { A, B }

// final fromValues = EnumValues({"A": From.A, "B": From.B});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
