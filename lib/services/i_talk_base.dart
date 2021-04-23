import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:italk/services/chat_services.dart';
import 'package:italk/services/profile_services.dart';

class ITalkBase {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore store = FirebaseFirestore.instance;

  ITalkBase._internale();

  static final ITalkBase iTalkBase = ITalkBase._internale();

  factory ITalkBase() => iTalkBase;

  ProfileService profileService = ProfileService(
    auth: auth,
    store: store,
  );
  ChatServices chatServices = ChatServices(
    auth: auth,
    store: store,
  );
}
