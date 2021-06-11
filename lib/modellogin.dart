// ignore: camel_case_types
class loginPost {
  final String username;
  final String password;

  loginPost({required this.username, required this.password});

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    return map;
  }
}

class AccessK24 {
  String? partnerID;
  String? partnerCode;
  String? name;
  String? description;

  AccessK24({this.partnerID, this.partnerCode, this.name, this.description});

  AccessK24.fromJson(Map<String, dynamic> json) {
    partnerID = json['partnerID'];
    partnerCode = json['partnerCode'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partnerID'] = this.partnerID;
    data['partnerCode'] = this.partnerCode;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class MembershipK24 {
  String? id;
  String? name;
  String? dateOfBirth;
  String? registered;

  MembershipK24({this.id, this.name, this.dateOfBirth, this.registered});

  MembershipK24.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    registered = json['registered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dateOfBirth'] = this.dateOfBirth;
    data['registered'] = this.registered;
    return data;
  }
}
