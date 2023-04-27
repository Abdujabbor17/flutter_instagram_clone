
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/utils/log_service.dart';
import '../model/post_model.dart';
import '../model/user_model.dart';
import '../utils/device_param.dart';
import '../utils/get_current_date.dart';
import 'auth_service.dart';

class DBService {
  static final _firestore = FirebaseFirestore.instance;

  static String folder_users = 'users';
  static String folder_posts = "posts";
  static String folder_feeds = "feeds";
  // static String folder_following = "following";
  // static String folder_followers = "followers";

  static Future saveUser(UserModel user) async {
    user.uid = AuthService.currentUserId();
    Map<String, String> params = await deviceParams();
    Log.i(params.toString());

    user.deviceId = params["deviceId"]!;
    user.deviceType = params["deviceType"]!;
    user.deviceToken = params["deviceToken"]!;

    return _firestore
        .collection(folder_users)
        .doc(user.uid)
        .set(user.toJson());
  }

  static Future<UserModel> loadUserInfo() async {
    String uid = AuthService.currentUserId();
    var value = await _firestore.collection(folder_users).doc(uid).get();
    UserModel user = UserModel.fromJson(value.data()!);

    // var querySnapshot1 = await _firestore
    //     .collection(folder_users)
    //     .doc(uid)
    //     .collection(folder_followers)
    //     .get();
    // user.followers_count = querySnapshot1.docs.length;
    //
    // var querySnapshot2 = await _firestore
    //     .collection(folder_users)
    //     .doc(uid)
    //     .collection(folder_following)
    //     .get();
    // user.following_count = querySnapshot2.docs.length;
    return user;
  }

  static Future updateUser(UserModel user) async {
    String uid = AuthService.currentUserId();
    return _firestore.collection(folder_users).doc(uid).update(user.toJson());
  }

  static Future<List<UserModel>> searchUser(String keyword) async {
    List<UserModel> users = [];
    String uid = AuthService.currentUserId();

    var querySnapshot = await _firestore
        .collection(folder_users)
        .orderBy("email")
        .startAt([keyword]).get();
    Log.i(querySnapshot.docs.length.toString());

    querySnapshot.docs.forEach((result) {
      UserModel newUser = UserModel.fromJson(result.data());
      if (newUser.uid != uid) {
        users.add(newUser);
      }
    });

    return users;
  }


  // Post service

  static Future<Post> saveMyPost(Post post) async {
    UserModel me = await loadUserInfo();
    post.uid = me.uid;
    post.fullName = me.fullName;
    post.imgUser = me.imgUrl;
    post.date = currentDate();

    String postId = _firestore
        .collection(folder_users)
        .doc(me.uid)
        .collection(folder_posts)
        .doc()
        .id;
    post.id = postId;

    await _firestore
        .collection(folder_users)
        .doc(me.uid)
        .collection(folder_posts)
        .doc(postId)
        .set(post.toJson());
    return post;
  }

  static Future<Post> saveFeed(Post post) async {
    String uid = AuthService.currentUserId();
    await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .doc(post.id)
        .set(post.toJson());
    return post;
  }

  static Future<List<Post>> loadPosts() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();

    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_posts)
        .get();

    querySnapshot.docs.forEach((result) {
      posts.add(Post.fromJson(result.data()));
    });
    return posts;
  }

  static Future<List<Post>> loadFeeds() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();
    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .get();

    querySnapshot.docs.forEach((result) {
      Post post = Post.fromJson(result.data());
      if (post.uid == uid) post.mine = true;
      posts.add(post);
    });

    return posts;
  }
}