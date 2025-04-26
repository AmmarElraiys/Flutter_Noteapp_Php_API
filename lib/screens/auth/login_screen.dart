import 'package:flutter/material.dart';
import 'package:notes_app_php/constant/links.dart';
import 'package:notes_app_php/main.dart';
import 'package:notes_app_php/utils/auth/email_validator.dart';
import 'package:notes_app_php/utils/auth/password_validator.dart';
import 'package:notes_app_php/customs/auth/button_login_signup_widget.dart';
import 'package:notes_app_php/customs/auth/textbutton_login_signup_widget.dart';
import 'package:notes_app_php/customs/auth/textformfield_widget.dart';
import 'package:notes_app_php/widgets/data/crud.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginControllerEmail = TextEditingController();
  TextEditingController loginControllerPassword = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  final Crud _curd = Crud();
  bool isLoading = false;
  login() async {
    isLoading = true;
    setState(() {});
    var response = await _curd.postRequest(linkLoginName, {
      "email": loginControllerEmail.text,
      "password": loginControllerPassword.text,
    });
    isLoading = false;
    setState(() {});
    if (response["status"] == "success") {
      sharedPreferences!.setString("id", response['data']['id'].toString());
      sharedPreferences!.setString("username", response['data']['username']);
      sharedPreferences!.setString("email", response['data']['email']);
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text("Login Failed"),
              content: const Text(
                "The email or password is incorrect, or the account does not exist.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"),
                ),
              ],
            ),
      );

      print("Login Fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isLoading == true
              ? Center(child: CircularProgressIndicator())
              : ListView(
                children: [
                  Form(
                    key: formstate,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/images/notes.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextFormFieldWidget(
                            label: "Email",
                            icon: Icons.email,
                            controller: loginControllerEmail,
                            keyboardType: TextInputType.emailAddress,
                            validator:
                                (value) => EmailValidator.validate(value),
                          ),
                          const SizedBox(height: 10),
                          TextFormFieldWidget(
                            label: "Password",
                            icon: Icons.lock,
                            controller: loginControllerPassword,
                            initialObscureText: true,
                            validator:
                                (value) => PasswordValidator.validate(value),
                          ),
                          ButtonLoginSignupWidget(
                            text: 'Login',
                            onPressed: () async {
                              if (formstate.currentState!.validate()) {
                                await login();
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),
                              TextbuttonLoginSignupWidget(
                                title: "Sign Up",
                                onPressed: () {
                                  Navigator.of(context).pushNamed("/signup");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
