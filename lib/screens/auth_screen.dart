import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/Global_variables.dart';
import 'package:food_ordering_app/service/auth_service.dart';
import 'package:food_ordering_app/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Welcome',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Center(
                  child: Image.network(
                    'https://thumbs.gfycat.com/AcidicUnfoldedGoldenretriever-size_restricted.gif',
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  // tileColor: _auth == Auth.signup
                  //   ? GlobalVariables.backgroundColor
                  // : GlobalVariables.backgroundColor,
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
                  title: Text(
                    'create account',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(10),
                    // color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'name',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'test@gmail.com',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'password',
                                ),
                              ),
                            ),
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
                  // tileColor: _auth == Auth.signin
                  //   ? GlobalVariables.backgroundColor
                  // : GlobalVariables.backgroundColor,
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
                  title: Text(
                    'login account',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: GlobalVariables.backgroundColor,
                    child: Column(
                      children: [
                        Form(
                          key: _signinFormKey,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: TextField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'test@gmail.com',
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: _passwordController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'password',
                                      ),
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
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
