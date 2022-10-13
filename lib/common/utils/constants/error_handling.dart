import 'dart:convert';

import '../components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response res,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
    Components.showSnackBar(context, jsonDecode(res.body)['msg']);
    break;
    case 500:
    Components.showSnackBar(context, jsonDecode(res.body)['error']);
    break;
    default:
    Components.showSnackBar(context, res.body);
  }
}
