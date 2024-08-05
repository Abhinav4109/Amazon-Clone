import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  final AuthServices authServices = AuthServices();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
@override
  void initState() {
    super.initState();
    authServices.getUserData(context);
  }
  void signupUser() {
    authServices.signupUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        context: context);
  }

  void signinUser() {
    authServices.signinUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Welcome',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 0),
            horizontalTitleGap: 0,
            tileColor: _auth == Auth.signup
                ? GlobalVariables.backgroundColor
                : GlobalVariables.greyBackgroundCOlor,
            title: const Text(
              'Create Account',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Radio(
              value: Auth.signup,
              groupValue: _auth,
              onChanged: (Auth? value) {
                setState(() {
                  _auth = value!;
                });
              },
              activeColor: GlobalVariables.secondaryColor,
            ),
          ),
          if (_auth == Auth.signup)
            Container(
              padding: const EdgeInsets.all(8),
              color: GlobalVariables.backgroundColor,
              child: Form(
                  key: _signupFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: _nameController, hintText: 'Name'),
                      const SizedBox(height: 10),
                      CustomTextField(
                          controller: _emailController, hintText: 'Email'),
                      const SizedBox(height: 10),
                      CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password'),
                      const SizedBox(height: 10),
                      CustomButton(
                          buttonText: 'Sign Up',
                          onPressed: () {
                            if (_signupFormKey.currentState!.validate()) {
                              signupUser();
                            }
                          })
                    ],
                  )),
            ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 0),
            horizontalTitleGap: 0,
            tileColor: _auth == Auth.signin
                ? GlobalVariables.backgroundColor
                : GlobalVariables.greyBackgroundCOlor,
            title: const Text(
              'Sign-In.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Radio(
              value: Auth.signin,
              groupValue: _auth,
              onChanged: (Auth? value) {
                setState(() {
                  _auth = value!;
                });
              },
              activeColor: GlobalVariables.secondaryColor,
            ),
          ),
          if (_auth == Auth.signin)
            Container(
              padding: const EdgeInsets.all(8),
              color: GlobalVariables.backgroundColor,
              child: Form(
                  key: _signinFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: _emailController, hintText: 'Email'),
                      const SizedBox(height: 10),
                      CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password'),
                      const SizedBox(height: 10),
                      CustomButton(
                          buttonText: 'Sign In',
                          onPressed: () {
                            if (_signinFormKey.currentState!.validate()) {
                              signinUser();
                            }
                          })
                    ],
                  )),
            ),
        ],
      )),
    );
  }
}
