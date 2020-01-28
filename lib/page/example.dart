// import 'dart:math';

// import 'package:flutter/material.dart';


// class AnimatedContainerApp extends StatefulWidget {
//   @override
//   _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
// }

// class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
//   // Define the various properties with default values. Update these properties
//   // when the user taps a FloatingActionButton.
//   double _width = 50;
//   double _height = 50;
//   Color _color = Colors.green;
//   BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('AnimatedContainer Demo'),
//         ),
//         body: Center(
//           child: AnimatedContainer(
//             // Use the properties stored in the State class.
//             width: _width,
//             height: _height,
//             decoration: BoxDecoration(
//               color: _color,
//               borderRadius: _borderRadius,
//             ),
//             // Define how long the animation should take.
//             duration: Duration(seconds: 1),
//             // Provide an optional curve to make the animation feel smoother.
//             curve: Curves.fastOutSlowIn,
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.play_arrow),
//           // When the user taps the button
//           onPressed: () {
//             // Use setState to rebuild the widget with new values.
//             setState(() {
//               // Create a random number generator.
//               final random = Random();

//               // Generate a random width and height.
//               _width = random.nextInt(300).toDouble();
//               _height = random.nextInt(300).toDouble();

//               // Generate a random color.
//               _color = Color.fromRGBO(
//                 random.nextInt(256),
//                 random.nextInt(256),
//                 random.nextInt(256),
//                 1,
//               );

//               // Generate a random border radius.
//               _borderRadius =
//                   BorderRadius.circular(random.nextInt(100).toDouble());
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

// The StatefulWidget's job is to take data and create a State class.
// In this case, the widget takes a title, and creates a _MyHomePageState.
class AnimatedContainerApp extends StatefulWidget {

  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}

// The State class is responsible for two things: holding some data you can
// update and building the UI using that data.
class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  // Whether the green box should be visible
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aaaa'),
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.green,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call setState. This tells Flutter to rebuild the
          // UI with the changes.
          setState(() {
            _visible = !_visible;
          });
        },
        tooltip: 'Toggle Opacity',
        child: Icon(Icons.flip),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}