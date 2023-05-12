import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Post {
  final String username;
  final String postId;
  final String description;
  final datePublished;
  final String uid;
  final String postUrl;
  final String profImage;
  final String price;
  //final String cantidad;
  final likes;

  const Post(
      {required this.username,
      required this.postId,
      required this.description,
      required this.datePublished,
      required this.uid,
      required this.postUrl,
      required this.profImage,
      required this.price,
      //required this.cantidad,
      required this.likes});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "description": description,
        "postId": postId,
        "postUrl": postUrl,
        "profImage": profImage,
        "datePublished": datePublished,
        "likes": likes,
        "price": price,
        //"cantidad": cantidad,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      postId: snapshot[' postId'],
      postUrl: snapshot[' postUrl'],
      profImage: snapshot['profImage'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      price: snapshot['price'],
      //cantidad: snapshot['cantidad'],
    );
  }
}
