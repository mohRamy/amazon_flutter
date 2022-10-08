import 'dart:convert';

import '../components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.hashCode) {
    case 200:
      onSuccess();
      break;
    case 400:
    Components.showSnackBar(context, jsonDecode(response.body)['msg']);
    break;
    case 500:
    Components.showSnackBar(context, jsonDecode(response.body)['error']);
    break;
    default:
    Components.showSnackBar(context, response.body);
  }
}
