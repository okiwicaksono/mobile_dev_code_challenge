class ResponseData {
  int? id;
  String? body;
  String? attachment;
  String? timestamp;
  String? from;
  String? to;
  String? urlImage;
  String? contactName;
  String? contactPhoe;

  ResponseData(
      {this.id,
        this.body,
        this.attachment,
        this.timestamp,
        this.from,
        this.to,
        this.urlImage,
        this.contactName,
        this.contactPhoe});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    attachment = json['attachment'];
    timestamp = json['timestamp'];
    from = json['from'];
    to = json['to'];
    urlImage = json['url_image'];
    contactName = json['contact_name'];
    contactPhoe = json['contact_phoe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['body'] = body;
    data['attachment'] = attachment;
    data['timestamp'] = timestamp;
    data['from'] = from;
    data['to'] = to;
    data['url_image'] = urlImage;
    data['contact_name'] = contactName;
    data['contact_phoe'] = contactPhoe;
    return data;
  }
}