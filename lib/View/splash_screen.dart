import 'dart:async';

import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
//TickerProviderStateMixin = help to build animation
//singletickerproviderstatemixin = for only one animation
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
late final AnimationController controller = AnimationController(
  //late = value will be given soon
  // final = as instance variable, don't occupy memeory unless it used, can be assigned diffrent values
  duration: const Duration(seconds: 3) ,
    vsync: this)..repeat();
   //vsync = to keep the tract of the screen
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 5),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> WorldStatesScreen())));


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(animation: controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Image(image: AssetImage('images/one.jpg')),
                  ),
                ),
                builder: (BuildContext contex,Widget? child){
               return Transform.rotate(angle: controller.value*2.0 * math.pi,
                 child: child,);
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.08,
              //MediaQuery = to get the screen size and more precise layout
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Covid 19\n Tracker App',textAlign: TextAlign.center,style: TextStyle(
                fontSize: 25 ,fontWeight: FontWeight.bold
              ),),
            )

          ],
        ),
      ),
    );
  }
}