class UserModel {
  String uid = "";
  String fullName = "";
  String email = "";
  String password = "";
  String imgUrl = "";

  String deviceId = "";
  String deviceType = "";
  String deviceToken = "";

  bool followed = false;
  int followersCount = 0;
  int followingCount = 0;

  UserModel(this.fullName, this.email);
}
