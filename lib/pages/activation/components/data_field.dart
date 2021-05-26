import 'package:flutter/material.dart';

class DataField extends StatelessWidget {
  const DataField({
    Key key,
    @required this.hint,
    this.isPassword = false,
    this.onChanged,
    this.errorText,
  }) : super(key: key);

  final String hint;
  final bool isPassword;
  final String errorText;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        obscureText: isPassword,
        autofocus: false,
        onChanged: onChanged,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          errorText: errorText,
          hintStyle: TextStyle(color: Colors.white70),
          errorStyle: TextStyle(color: Colors.deepPurpleAccent),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 1),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
          ),
        ),
      ),
    );
  }
}
