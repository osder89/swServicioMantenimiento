import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Event {
  final String name;
  //final String uid;
  final String description;
  final List followers;
  final List uidUser;
  final String uidGroup;
  final String photoUrl;

  //final String eventId;

  const Event({
    required this.name,
    //required this.uid,
    required this.description,
    required this.followers,
    required this.uidUser,
    required this.uidGroup,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        //"uid": uid,
        "description": description,
        "followers": followers,
        "uidUser": uidUser,
        "uidGroup": uidGroup,
        "photoUrl": photoUrl,
      };

  static Event fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Event(
        name: snapshot['name'],
        //uid: snapshot['uid'],
        description: snapshot['description'],
        followers: snapshot['followers'],
        uidUser: snapshot['uidUser'],
        uidGroup: snapshot['uidGroup'],
        photoUrl: snapshot['photoUrl']);
  }
}
