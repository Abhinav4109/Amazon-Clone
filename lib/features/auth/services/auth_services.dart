// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/snackbar.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  // signup user
  void signupUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: []);
      http.Response res = await http.post(
        Uri.parse('$serverUri/api/siginup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandling(
          res: res,
          onSucess: () {
            showSnackBar(context: context, content: 'Account Created');
          },
          context: context);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void signinUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final navigatorContext = Navigator.of(context).context;
      Map<String, dynamic> user = {
        'email': email,
        'password': password,
      };
      http.Response res = await http.post(
        Uri.parse('$serverUri/api/signin'),
        body: jsonEncode(user),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandling(
          context: context,
          res: res,
          onSucess: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(navigatorContext,
                BottomBar.routeName, (Route<dynamic> route) => false);
          });
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('x-auth-token');
      String tokenValue = token ?? '';
      http.Response tokenRes = await http
          .post(Uri.parse('$serverUri/isTokenValid'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': tokenValue,
      });

      var res = jsonDecode(tokenRes.body);
      if (res == true) {
        http.Response userRes =
            await http.get(Uri.parse('$serverUri/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': tokenValue,
        });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
        // print(userProvider.user.name);
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
