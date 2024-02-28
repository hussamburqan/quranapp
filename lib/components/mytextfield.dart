import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hinttext ;
  final TextEditingController mycontroller ;
  final String? Function(String?)? validator;
  const MyTextField({super.key, required this.hinttext, required this.mycontroller, this.validator});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      validator: widget.validator,
      controller: widget.mycontroller,
      decoration: InputDecoration(
          hintText: widget.hinttext,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
          contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular( 50),
              borderSide:
              const BorderSide(color: Color.fromARGB(255, 184, 184, 184))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.black))),
    );
  }
}