import 'package:mobile_dev_code_challenge/class/Person.dart';
import 'package:intl/intl.dart';

class Message {
  int id;
  String body;
  String attachment;
  DateTime date;
  String sender;
  String receiver;
  String type;
  String category;

  Message(
      {this.id,
      this.body,
      this.attachment,
      this.date,
      this.sender,
      this.receiver});

  String convertDate(String timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    var formattedDate = DateFormat.EEEE().format(date);
    return formattedDate;
  }

  Message.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    body = data['body'] == null ? '' : data['body'];
    attachment = data['attachment'] == null ? '' : data['attachment'];
    date = DateTime.fromMillisecondsSinceEpoch(
      int.parse(data['timestamp']),
    );
    sender = data['from'];
    receiver = data['to'];
    category = setCategory(data['body'], data['attachment']);
  }

  Map<String, dynamic> toMap() => messagetoMap(this);

  Map<String, dynamic> messagetoMap(Message msg) => <String, dynamic>{
        'id': msg.id,
        'body': msg.body,
        'attachment': msg.attachment,
        'date': msg.date,
        'from': msg.sender,
        'to': msg.receiver,
        'category': msg.category
      };

  String setCategory(String bodyMsg, String attach) {
    String body = '';
    String attachment = '';
    if (bodyMsg != null) body = bodyMsg;
    if (attachment != null) attachment = attach;
    // List<String> categoryAdded = [];
    String category = '';
    if (body.startsWith('gambar')) {
      category = 'image collection';
      // categoryAdded.add(category);
    } else if (body.startsWith('pesan')) {
      category = 'text collection';
      // categoryAdded.add(category);
    } else if (attachment == 'document') {
      category = 'document';
      // categoryAdded.add(category);
    } else if (attachment == 'image') {
      category = 'image';
      // categoryAdded.add(category);
    } else if (attachment == 'contact') {
      category = 'contact';
      // categoryAdded.add(category);
    }
    return category;
  }
}
