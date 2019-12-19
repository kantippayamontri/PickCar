import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../../datamanager.dart';

Widget SignUpBtn(BuildContext context , Function onclick) {

  return ButtonTheme(
    
    height:75,
    minWidth: MediaQuery.of(context).size.width * 0.9,
    child: GradientButton(
      elevation: 5,
      callback: () {
        onclick();
      },
      gradient: LinearGradient(colors: [
        Colors.blue,
        Colors.blue.withOpacity(0.7),
        Colors.yellow
      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Center(
        child: Text(
          'Sign Up',
          style: TextStyle(fontSize: 24),
        ),
      ),
    ),
  );
}
