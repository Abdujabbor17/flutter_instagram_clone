class Post {
  String? uid;
  String? fullName;
  String? imgUser;

  String? id;
  List<String>? imgPosts;
  String? caption;
  String? date;
  bool liked = false;

  bool mine = false;

  Post(this.caption, this.imgPosts);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      json['caption'] as String?,
      (json['imgPosts'] as List<dynamic>?)?.cast<String>(),
    )
      ..uid = json['uid'] as String?
      ..fullName = json['fullName'] as String?
      ..imgUser = json['imgUser'] as String?
      ..id = json['id'] as String?
      ..date = json['date'] as String?
      ..liked = json['liked'] as bool? ?? false
      ..mine = json['mine'] as bool? ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['fullName'] = fullName;
    data['imgUser'] = imgUser;
    data['id'] = id;
    data['imgPosts'] = imgPosts;
    data['caption'] = caption;
    data['date'] = date;
    data['liked'] = liked;
    data['mine'] = mine;
    return data;
  }
}
