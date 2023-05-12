import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/post_card.dart';
import '../widgets/shopping _cart.dart';

class ShipmentScreen extends StatelessWidget {
  const ShipmentScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset('assets/imagen.png'),
        /*actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.messenger_outline))
        ],*/
      ),
      body: Column(
        children: [
          Image.network(''),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey)),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
      /*body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ShoppingCart(/*snap: snapshot.data!.docs[0].data()*/);
        },
      ),*/
    );
  }
}
