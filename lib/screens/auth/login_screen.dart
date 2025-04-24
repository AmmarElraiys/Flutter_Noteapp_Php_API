import 'package:flutter/material.dart';
import 'package:notes_app_php/utils/auth/email_validator.dart';
import 'package:notes_app_php/utils/auth/password_validator.dart';
import 'package:notes_app_php/widgets/auth/button_login_signup_widget.dart';
import 'package:notes_app_php/widgets/auth/textbutton_login_signup_widget.dart';
import 'package:notes_app_php/widgets/auth/textformfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginControllerEmail = TextEditingController();
  TextEditingController loginControllerPassword = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                    validator: (value) => EmailValidator.validate(value),
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldWidget(
                    label: "Password",
                    icon: Icons.lock,
                    controller: loginControllerPassword,
                    initialObscureText: true,
                    validator: (value) => PasswordValidator.validate(value),
                  ),
                  ButtonLoginSignupWidget(
                    text: 'Login',
                    onPressed: () {
                      if (formstate.currentState!.validate()) {}
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextbuttonLoginSignupWidget(
                        title: "Sign Up",
                        onPressed: () {},
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
