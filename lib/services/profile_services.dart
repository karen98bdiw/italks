import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:italk/utils/api_paths.dart';
import '../models/user.dart' as customUser;

class ProfileService {
  final FirebaseFirestore store;
  final FirebaseAuth auth;

  customUser.User curentUser;

  ProfileService({
    this.auth,
    this.store,
  });

  Future<bool> signUp({customUser.User user, String password}) async {
    try {
      var res = await auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      if (res.user == null) return false;
      user.userId = res.user.uid;
    } catch (e) {
      print(e.toString());
      return false;
    }

    var postResponse = await postUserData(user: user);
    if (!postResponse) return false;

    var userDataExist = await getUserData();

    if (!userDataExist) return false;
    return true;
  }

  Future<bool> postUserData({customUser.User user}) async {
    try {
      await store.collection(usersPath).doc(user.userId).set(
            user.toJson(),
          );
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> singIn({String email, String password}) async {
    try {
      var res = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (res.user == null) return false;

      var userDataExist = await getUserData();

      if (!userDataExist) return false;

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> getUserData() async {
    try {
      var userSnapshot;
      if (auth.currentUser != null)
        userSnapshot =
            await store.collection(usersPath).doc(auth.currentUser.uid).get();

      if (userSnapshot != null && userSnapshot.exists) {
        curentUser = customUser.User.fromJson(userSnapshot.data());
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<customUser.User>> getAllUsers() async {
    try {
      var res = await store.collection(usersPath).get();

      List<customUser.User> users = [];

      res.docs.forEach((element) {
        users.add(customUser.User.fromJson(element));
      });

      users.removeWhere((element) => element.userId == curentUser.userId);

      return users;
    } catch (e) {
      return [];
    }
  }
}
