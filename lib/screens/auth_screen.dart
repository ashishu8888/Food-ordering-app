import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/Global_variables.dart';
import 'package:food_ordering_app/service/auth_service.dart';
import 'package:food_ordering_app/widgets/custom_button.dart';
import 'package:food_ordering_app/widgets/custom_textfield.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;

  final _signUpFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  final AuthService authService = AuthService();

  void signUpUser() {
    authService.signUp(
        context: context,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                  title: const Text(
                    'create account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            hintText: 'Full Name',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Email',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            text: 'Sign Up',
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                  title: const Text(
                    'login account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Column(
                      children: [
                        Form(
                          key: _signinFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _emailController,
                                hintText: 'Email',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller: _passwordController,
                                hintText: 'Password',
                              ),
                              CustomButton(
                                text: 'Sign In',
                                onTap: () {
                                  if (_signinFormKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
