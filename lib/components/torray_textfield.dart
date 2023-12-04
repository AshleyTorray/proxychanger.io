import 'package:flutter/material.dart';

class TorrayTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool password;
  // final String value;
  const TorrayTextField({super.key, required this.controller, required this.hint, required this.password});
    // const TorrayTextField({super.key, required this.controller, required this.hint, required this.password, required this.value});
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    // var value = this.value;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        obscureText: password,
        // onChanged: (typeValue){
        //   value = typeValue;
        // },
      ),
    );
  }
}