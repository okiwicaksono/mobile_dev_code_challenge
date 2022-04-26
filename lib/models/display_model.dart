class DisplayModel {
  String? id;
  String? type;
  bool? showAvatar;
  String? message;
  List<dynamic>? imageList;
  List? contactList;
  String? from;

  DisplayModel(
      {this.id,
      this.type,
      this.showAvatar,
      this.message,
      this.imageList,
      this.contactList,
      this.from});

  factory DisplayModel.fromJson(dynamic json) {
    return DisplayModel(
      id: castString(json['id']),
      type: castString(json['type']),
      message: castString(json["message"]),
      showAvatar: castBool(json['showAvatar']),
      imageList: castList(json['imageList']),
      contactList: castList(json['contactList']),
      from: castString(json['from']),
    );
  }
}

bool? castBool(var object, [bool? defaultValue]) {
  defaultValue = false;

  if (object == null && defaultValue == null) return null;

  if (object == null) {
    return defaultValue;
  } else {
    if (object is bool) {
      return object;
    } else if (object is String) {
      return object == "1" ? true : false;
    } else if (object is num) {
      return object == 1 ? true : false;
    } else {
      return null;
    }
  }
}

List? castList(var object, [List? defaultValue]) {
  defaultValue = [];

  if (object == null && defaultValue == null) return null;

  return object == null ? defaultValue : object as List;
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
