import 'package:flutter/material.dart';

class MyWeb extends StatelessWidget{
  const MyWeb({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/hand_pic.png', // Replace with your image
                fit: BoxFit.cover,
              ),
            ),

            // Magician in Center
            Positioned(
              top: 100,
              left: 50,
              right: 50,
              child: Column(
                children: [
                  Image.asset(
                    'assets/magition_pic.png', // Replace with a magician image
                    height: 300,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "The Magical Journey",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Audience (Overlaying Images or Avatars)
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/magition_pic.png'),
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/peagion_pic.png'),
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/hand_pic.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}