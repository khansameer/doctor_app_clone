import 'package:flutter/material.dart';

class ResponsiveBox extends StatelessWidget {
  const ResponsiveBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Box Example'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Get the available width and height
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;

          // Customize the size of the box depending on screen size
          double boxSize = width * 0.5; // Set box width to 50% of screen width

          // Adjust box size further for small or large screens if needed
          if (width < 600) {
            boxSize = width * 0.8; // Smaller screens
          } else if (width > 1200) {
            boxSize = width * 0.3; // Larger screens
          }

          return Center(
            child: Container(
              width: boxSize,
              height: boxSize,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Responsive Box',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
