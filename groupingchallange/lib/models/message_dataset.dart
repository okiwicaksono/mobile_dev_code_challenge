import 'package:groupingchallange/constants/enum.dart';
import 'package:groupingchallange/utils/date_convert.dart';

class MessagesDataset {
  late List<Message> data;

  MessagesDataset({required this.data});

  MessagesDataset.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Message>.empty(growable: true);
      json['data'].forEach((v) {
        data.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  late int id;
  String? body;
  String? attachment;
  late String timestamp;
  late DateTime datetime;
  late String date;
  late String hour;
  late String from;
  late String to;

  Message({
    required this.id,
    this.body,
    this.attachment,
    required this.timestamp,
    required this.from,
    required this.to,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    attachment = json['attachment'];
    timestamp = json['timestamp'];
    from = json['from'];
    to = json['to'];
    date = DateConvert.convertTsToDate(json['timestamp'], TsConvertTo.DATE);
    hour = DateConvert.convertTsToDate(json['timestamp'], TsConvertTo.HOUR);
    datetime = DateConvert.convertTsToDateTime(json['timestamp']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['attachment'] = this.attachment;
    data['timestamp'] = this.timestamp;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
