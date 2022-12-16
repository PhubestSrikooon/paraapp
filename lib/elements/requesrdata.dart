import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class RequestData {
  final String url;

  RequestData(this.url);

  Future<dynamic>? paraName(String name) async {
    // time out 10 seconds
    Response response = await get(Uri.parse("${url}/entry/${name}"));
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return 404;
    } else {
      return null;
    }
  }
}
