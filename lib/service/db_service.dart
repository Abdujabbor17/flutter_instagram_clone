
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_instagram_clone/service/dio_service.dart';
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
  static String folder_following = "following";
  static String folder_followers = "followers";

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

    var querySnapshot1 = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_followers)
        .get();
    user.followersCount = querySnapshot1.docs.length;

    var querySnapshot2 = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_following)
        .get();
    user.followingCount = querySnapshot2.docs.length;
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
    //Log.i(querySnapshot.docs.length.toString());

    querySnapshot.docs.forEach((result) {
      UserModel newUser = UserModel.fromJson(result.data());
      if (newUser.uid != uid) {
        users.add(newUser);
      }
    });

    List<UserModel> following = [];
    var querySnapshot2 = await _firestore.collection(folder_users).doc(uid).collection(folder_following).get();
    for (var result in querySnapshot2.docs) {
      following.add(UserModel.fromJson(result.data()));
    }

    for(UserModel user in users){
      if(following.contains(user)){
        user.followed = true;
      }else{
        user.followed = false;
      }
    }

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

  static Future likePost(Post post, bool liked) async {
    String uid = AuthService.currentUserId();
    post.liked = liked;

    await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .doc(post.id)
        .set(post.toJson());

    if (uid == post.uid) {
      await _firestore
          .collection(folder_users)
          .doc(uid)
          .collection(folder_posts)
          .doc(post.id)
          .set(post.toJson());
    }
  }

  static Future<List<Post>> loadLikes() async {
    String uid = AuthService.currentUserId();
    List<Post> posts = [];

    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .where("liked", isEqualTo: true)
        .get();

    querySnapshot.docs.forEach((result) {
      Post post = Post.fromJson(result.data());
      if (post.uid == uid) post.mine = true;
      posts.add(post);
    });
    return posts;
  }

  static Future<UserModel> followUser(UserModel someone) async {
    UserModel me = await loadUserInfo();

    // I followed to someone
    await _firestore
        .collection(folder_users)
        .doc(me.uid)
        .collection(folder_following)
        .doc(someone.uid)
        .set(someone.toJson());

    // I am in someone`s followers
    await _firestore
        .collection(folder_users)
        .doc(someone.uid)
        .collection(folder_followers)
        .doc(me.uid)
        .set(me.toJson());

    await DioService.sendNotification(someone.deviceToken!, me.fullName!)
        .then((value) {
      if (kDebugMode) {
        Log.i(value.toString());
      }
    });

    return someone;
  }

  static Future<UserModel> unfollowUser(UserModel someone) async {
    UserModel me = await loadUserInfo();

    // I un followed to someone
    await _firestore
        .collection(folder_users)
        .doc(me.uid)
        .collection(folder_following)
        .doc(someone.uid)
        .delete();

    // I am not in someone`s followers
    await _firestore
        .collection(folder_users)
        .doc(someone.uid)
        .collection(folder_followers)
        .doc(me.uid)
        .delete();

    return someone;
  }

  static Future storePostsToMyFeed(UserModel someone) async {
    List<Post> posts = [];

    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(someone.uid)
        .collection(folder_posts)
        .get();
    for (var result in querySnapshot.docs) {
      var post = Post.fromJson(result.data());
      post.liked = false;
      posts.add(post);
    }

    for (Post post in posts) {
      saveFeed(post);
    }
  }

  static Future removePostsFromMyFeed(UserModel someone) async {
    List<Post> posts = [];
    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(someone.uid)
        .collection(folder_posts)
        .get();

    for (var result in querySnapshot.docs) {
      posts.add(Post.fromJson(result.data()));
    }

    for (Post post in posts) {
      removeFeed(post);
    }
  }

  static Future removeFeed(Post post) async {
    String uid = AuthService.currentUserId();

    return await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .doc(post.id)
        .delete();
  }

  static Future removePost(Post post) async {
    String uid = AuthService.currentUserId();
    await removeFeed(post);
    return await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_posts)
        .doc(post.id)
        .delete();
  }
}