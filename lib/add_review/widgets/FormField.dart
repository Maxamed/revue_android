import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool withAsterisk;
  const CustomTextField({Key key, @required this.label, @required this.withAsterisk})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: ' $label',
              style: TextStyle(
                  color:  Colors.black,
                  fontWeight: FontWeight.w600,
                  fontStyle:  FontStyle.normal,
                  fontSize: 16.0)),
          TextSpan(
              text:' * ',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.red)),
        ],
      ),
    );
  }
}
