class UserModel {
  String? uid;
  String? fullName;
  String? email;
  String? password;
  String? imgUrl;

  String? deviceId;
  String? deviceType;
  String? deviceToken;

  bool followed = false;
  int followersCount = 0;
  int followingCount = 0;

  UserModel(this.fullName, this.email);

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        fullName = json['fullName'],
        email = json['email'],
        password = json['password'],
        imgUrl = json['imgUrl'],
        deviceId = json['deviceId'],
        deviceType = json['deviceType'],
        deviceToken = json['deviceToken'];

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'fullName': fullName,
    'email': email,
    'password': password,
    'imgUrl': imgUrl,
    'deviceId': deviceId,
    'deviceType': deviceType,
    'deviceToken': deviceToken,
  };
}
