import 'package:flutter/material.dart';
import 'package:notes_app_php/constant/links.dart';
import 'package:notes_app_php/utils/auth/email_validator.dart';
import 'package:notes_app_php/utils/auth/password_validator.dart';
import 'package:notes_app_php/utils/auth/username_validator.dart';
import 'package:notes_app_php/customs/auth/button_login_signup_widget.dart';
import 'package:notes_app_php/customs/auth/textbutton_login_signup_widget.dart';
import 'package:notes_app_php/customs/auth/textformfield_widget.dart';
import 'package:notes_app_php/widgets/data/crud.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController signUpControllerUserName = TextEditingController();
  TextEditingController signUpControllerEmail = TextEditingController();
  TextEditingController signUpControllerPassword = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  bool isLoading = false;
  Crud _curd = Crud();
  SignUp() async {
    isLoading = true;
    setState(() {});
    var response = await _curd.postRequest(linkSignUpName, {
      "username": signUpControllerUserName.text,
      "email": signUpControllerEmail.text,
      "password": signUpControllerPassword.text,
    });
    isLoading = false;
    setState(() {});
    if (response["status"] == "success") {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil("/success", (route) => false);
    } else {
      print("Signup fail");
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
                          SizedBox(
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
                            label: "Name",
                            icon: Icons.person,
                            controller: signUpControllerUserName,
                            keyboardType: TextInputType.text,
                            validator:
                                (value) => UsernameValidator.validate(value),
                          ),
                          const SizedBox(height: 10),
                          TextFormFieldWidget(
                            label: "Email",
                            icon: Icons.email,
                            controller: signUpControllerEmail,
                            keyboardType: TextInputType.emailAddress,
                            validator:
                                (value) => EmailValidator.validate(value),
                          ),
                          const SizedBox(height: 10),
                          TextFormFieldWidget(
                            label: "Password",
                            icon: Icons.lock,
                            controller: signUpControllerPassword,
                            initialObscureText: true,
                            validator:
                                (value) => PasswordValidator.validate(value),
                          ),
                          ButtonLoginSignupWidget(
                            text: 'Sign Up',
                            onPressed: () async {
                              if (formstate.currentState!.validate()) {
                                await SignUp();
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?"),
                              TextbuttonLoginSignupWidget(
                                title: "Login",
                                onPressed: () {
                                  Navigator.of(context).pushNamed("/");
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
