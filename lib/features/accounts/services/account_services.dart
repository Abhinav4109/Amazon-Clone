import 'package:amazon_clone/constants/snackbar.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: e.toString());
    }
  }
}
