import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';
import 'feed_screen.dart';

class CardaDataScreen extends StatefulWidget {
  final snap;
  const CardaDataScreen({super.key, this.snap});

  @override
  State<CardaDataScreen> createState() => _CardaDataScreenState();
}

class _CardaDataScreenState extends State<CardaDataScreen> {
  final TextEditingController _nroController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  _alertBuy(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Buy success'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child:
                    const Text('Your payment has been successfully completed'),
                onPressed: () async {},
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void navigateToFeed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => FeedScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Flexible(
            //   child: Container(),
            //   flex: 2,
            // ),
            // Text(
            //   'MAKE AN ORDEN',
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            // ),
            const SizedBox(
              height: 24,
            ),
            Stack(
              children: [
                Image.network(
                    'https://static.vecteezy.com/system/resources/previews/001/945/972/non_2x/bank-card-prototype-with-triangle-background-abstract-bank-abstract-payment-system-vector.jpg'),
              ],
            ),
            const SizedBox(
              height: 64,
            ),
            TextFieldInput(
              hindText: 'Enter your Nro ',
              textInputType: TextInputType.number,
              textEditingController: _nroController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hindText: 'Enter your name ',
              textInputType: TextInputType.text,
              textEditingController: _nameController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hindText: 'Enter your CVC',
              textInputType: TextInputType.number,
              textEditingController: _cvcController,
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hindText: 'Enter your date',
              textInputType: TextInputType.datetime,
              textEditingController: _dateController,
            ),
            const SizedBox(
              height: 24,
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
                            TextSpan(
                              text: 'Description:',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: ' Photo of ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(color: primaryColor),
                          children: [
                            TextSpan(
                              text: 'Price:',
                              style: const TextStyle(
                                  fontSize: 16, color: secondaryColor),
                            ),
                            TextSpan(
                              text: ' 123.23',
                              style: const TextStyle(
                                  fontSize: 16, color: secondaryColor),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Alert Dialog'),
                        content: Text(
                            'Your payment has been successfully completed'),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ResponsiveLayout(
                                                webScreenLayout:
                                                    WebScreenLayout(),
                                                mobileScreenLayout:
                                                    MobileScreenLayout())));
                              },
                              child: Text('OK')),
                        ],
                      );
                    });
              },
              child: Container(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Pay whit credit card'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  color: blueColor,
                ),
              ),
            ),

            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => UsePaypal(
                          sandboxMode: true,
                          clientId:
                              "ASGfF2T0qkfoNsgfHe57hCGLLBNjw6Qq9_2mny2WaWQ-UG73rclDMqO--RHY-lzFbwnU20i_gQKX5Gsa",
                          secretKey:
                              "EOnzdtPOVQByDNgnwy328JDAwOiK-n-ZJJV7B2Pd1DTd-mFdRDYX57-6UXqWwIgwvyQ6TbbFufXtKLjd",
                          returnURL: "https://samplesite.com/return",
                          cancelURL: "https://samplesite.com/cancel",
                          transactions: const [
                            {
                              "amount": {
                                "total": '10.12',
                                "currency": "USD",
                                "details": {
                                  "subtotal": '10.12',
                                  "shipping": '0',
                                  "shipping_discount": 0
                                }
                              },
                              "description":
                                  "The payment transaction description.",
                              // "payment_options": {
                              //   "allowed_payment_method":
                              //       "INSTANT_FUNDING_SOURCE"
                              // },
                              "item_list": {
                                "items": [
                                  {
                                    "name": "A demo product",
                                    "quantity": 1,
                                    "price": '10.12',
                                    "currency": "USD"
                                  }
                                ],

                                // shipping address is not required though
                                "shipping_address": {
                                  "recipient_name": "Jane Foster",
                                  "line1": "Travis County",
                                  "line2": "",
                                  "city": "Austin",
                                  "country_code": "US",
                                  "postal_code": "73301",
                                  "phone": "+00000000",
                                  "state": "Texas"
                                },
                              }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            print("onSuccess: $params");
                          },
                          onError: (error) {
                            print("onError: $error");
                          },
                          onCancel: (params) {
                            print('cancelled: $params');
                          }),
                    ),
                  );
                },
                child: Text('Pay whit PayPal'))
          ],
        ),
      )),
    );
  }
}
