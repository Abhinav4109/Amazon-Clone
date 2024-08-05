import 'dart:convert';

import 'package:amazon_clone/constants/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandling(
    {required http.Response res,
    required VoidCallback onSucess,
    required BuildContext context}) {
  switch (res.statusCode) {
    case 200:
      onSucess();
      break;
    case 400:
      showSnackBar(context: context, content: jsonDecode(res.body)['msg']);
      break;
    case 500:
      showSnackBar(context: context, content: jsonDecode(res.body)['error']);
      break;
    default:
      showSnackBar(context: context, content: res.body);
  }
}
