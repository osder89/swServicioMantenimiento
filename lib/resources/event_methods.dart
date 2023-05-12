import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sw_de_control_de_mantenimiento/resources/storage_methods.dart';

import 'package:uuid/uuid.dart';

import '../models/event.dart';

class EventMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> addGroup(
    String description,
    Uint8List file,
    //String uid,
    String name,
    //List uidUser,
  ) async {
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('event', file, true);
      String uidGroup = const Uuid().v1();
      Event post = Event(
        description: description,
        //uid: uid,
        name: name,
        photoUrl: photoUrl,
        //eventId: eventId,
        uidGroup: uidGroup,
        followers: [],
        uidUser: [],
      );

      _firestore.collection('event').doc(uidGroup).set(post.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followGruop(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['uidEvent'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
