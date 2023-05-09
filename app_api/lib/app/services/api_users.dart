import 'dart:async';
import 'dart:convert';

import 'package:app_api/app/settings/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:app_api/app/models/user.dart';
import 'package:http/http.dart' as http;

Future<List<User>> fetchUsers(http.Client client) async {
  final response = await client.get(Uri.parse(Constants.baseUrl));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseUsers, response.body);
}

// A function that converts a response body into a List<Photo>.
List<User> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}
