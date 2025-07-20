import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage ({super.key});
   
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin{
  double _circularButtonSize = 100;
  final double _starSize = 100;
  final Tween<double> _tween = Tween(begin: 0.0, end: 1.0);
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animdo"),
      ),
      body: TweenAnimationBuilder(
        tween: _tween,
        duration: Duration(seconds: 1),
        curve: Curves.linear,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.amber),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _circularAnimation(),
                    _starAnimation(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget _starAnimation(){
  return AnimatedBuilder(
    animation: _animationController!.view , 
    builder: (context,child){
      return Transform.rotate(
        angle: _animationController!.value*2*pi,
        child: child,
        );
  },
  child: Icon(Icons.star, size: _starSize,)
  );
}

Widget _circularAnimation(){
  return GestureDetector(
    onTap: () {
      setState(() {
        _circularButtonSize += _circularButtonSize == 100 ? 100 : -100;
      });
    },
    child: AnimatedContainer(
    duration: Duration(seconds: 1),
    curve: Easing.legacy,
    height: _circularButtonSize,
    width: _circularButtonSize,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(_circularButtonSize),
      color: Colors.blueAccent,
    ),
    child: Center(child: Text("Press Me!", style: TextStyle(fontSize: 20,color: Colors.white),)),
  ),
  );
}

}

