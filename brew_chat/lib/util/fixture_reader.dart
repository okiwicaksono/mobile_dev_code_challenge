import 'dart:io';

import 'package:flutter/services.dart';

Future<String> fixture(String name) async => await rootBundle.loadString('assets/$name');