import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class CMULogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
    
                height: 75,
                minWidth: MediaQuery.of(context).size.width * 0.9,
                child: GradientButton(
                  callback: () {},
                  shadowColor: Colors.grey,
                  elevation: 5.0,
                  gradient: LinearGradient(colors: [
                    Colors.purple,
                    Colors.purple.withOpacity(0.7),
                    Colors.yellow
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          child: Image.asset(
                              'assets/images/cmu.png', //image fit with parent that have height
                              fit: BoxFit.cover),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'CMU',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}