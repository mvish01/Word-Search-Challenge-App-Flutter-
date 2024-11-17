import 'package:flutter/material.dart';
import 'package:word_search_app/grid_input_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GridInputScreen()),
      );
    });

    return const Scaffold(
      body: Center(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.wordpress_rounded,
            color: Colors.amber,
            size: 64,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Word ',
              style: TextStyle(
                fontSize: 30,
                color: Colors.blueAccent,
              ),),

            Text('Search',
              style: TextStyle(
                fontSize: 30,
                color: Colors.amber,
              ),),
          ],
        ),

        ],
      )),
    );
  }
}