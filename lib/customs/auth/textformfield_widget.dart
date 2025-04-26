import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool initialObscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Color? iconColor;

  const TextFormFieldWidget({
    Key? key,
    required this.label,
    required this.icon,
    required this.controller,
    this.initialObscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.iconColor,
  }) : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.initialObscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: obscureText,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: widget.iconColor),
          suffixIcon:
              widget.initialObscureText
                  ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: widget.iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                  : null,
          labelText: widget.label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
