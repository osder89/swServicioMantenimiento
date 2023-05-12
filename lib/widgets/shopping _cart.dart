import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/cardData_screen.dart';
import '../screens/shipment_screen.dart';
import '../utils/colors.dart';

class ShoppingCart extends StatelessWidget {
  ShoppingCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        // header
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
          ),
          // imagen
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            // child: Image.network(
            //   snap['postUrl'],
            //   fit: BoxFit.cover,
            // ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(color: primaryColor),
                        children: [
                          // TextSpan(
                          //   text: ' ${snap['description']}',
                          //   style: const TextStyle(
                          //       fontWeight: FontWeight.bold, fontSize: 16),
                          // ),
                        ]),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
