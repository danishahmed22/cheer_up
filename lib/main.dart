import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compliment Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ComplimentScreen(),
    );
  }
}

class ComplimentScreen extends StatefulWidget {
  @override
  _ComplimentScreenState createState() => _ComplimentScreenState();
}

class _ComplimentScreenState extends State<ComplimentScreen>
    with SingleTickerProviderStateMixin {
  final List<String> compliments = [
    "You're amazing!",
    "You're a star!",
    "You're so creative!",
    "You light up the room!",
    "You're one of a kind!",
  ];

  String currentCompliment = "Tap the button for a compliment!";
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _offsetAnimation = TweenSequence(
      [
        TweenSequenceItem(
          tween: Tween(begin: Offset(0, 0), end: Offset(0, -0.1)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: Offset(0, -0.1), end: Offset(0, 0)),
          weight: 1,
        ),
      ],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat();
  }

  void generateCompliment() {
    final random = Random();
    final index = random.nextInt(compliments.length);
    setState(() {
      currentCompliment = compliments[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compliment Generator'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                width: 200, 
                height: 200,
                child: Image.asset('assets/confetti.gif'),
              ),
              SizedBox(height: 20),
              SlideTransition(
                position: _offsetAnimation,
                child: Text(
                  currentCompliment,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: generateCompliment,
                child: Text('Generate Compliment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
