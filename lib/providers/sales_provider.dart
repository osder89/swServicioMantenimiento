import '../models/event.dart';
import 'package:flutter/material.dart';

import '../resources/firestore_methods.dart';

class EventProvider with ChangeNotifier {
  Event? _event;
  final FirestoreMethods _fireMethods = FirestoreMethods();

  Event get getEvent => _event!;
}
