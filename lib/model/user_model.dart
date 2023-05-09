// ignore_for_file: unnecessary_new, unnecessary_this

class UserModel
{
  String? profilePic;
  String? sId;
  String? username;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? token;

  UserModel(
      {this.profilePic,
        this.sId,
        this.username,
        this.name,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    profilePic = json['profilePic'];
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    name = json['name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profilePic'] = this.profilePic;
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['token'] = this.token;
    return data;
  }
}