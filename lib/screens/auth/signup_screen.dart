import 'package:flutter/material.dart';
import 'package:notes_app_php/utils/auth/email_validator.dart';
import 'package:notes_app_php/utils/auth/password_validator.dart';
import 'package:notes_app_php/utils/auth/username_validator.dart';
import 'package:notes_app_php/widgets/auth/button_login_signup_widget.dart';
import 'package:notes_app_php/widgets/auth/textbutton_login_signup_widget.dart';
import 'package:notes_app_php/widgets/auth/textformfield_widget.dart';

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
                    validator: (value) => UsernameValidator.validate(value),
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldWidget(
                    label: "Email",
                    icon: Icons.email,
                    controller: signUpControllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => EmailValidator.validate(value),
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldWidget(
                    label: "Password",
                    icon: Icons.lock,
                    controller: signUpControllerPassword,
                    initialObscureText: true,
                    validator: (value) => PasswordValidator.validate(value),
                  ),
                  ButtonLoginSignupWidget(
                    text: 'Sign Up',
                    onPressed: () {
                      if (formstate.currentState!.validate()) {}
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextbuttonLoginSignupWidget(
                        title: "Login",
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
