import 'dart:math';
import 'package:cursorpostion/widget/roundedMeter.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  double iSpeed = 0;
  double fSpeed = 0;
  double deltaSpeed = 0;
  double dX = 0;
  double dY = 0;
  double end = 0;
  DateTime? iDate;
  DateTime? fDate;
  Duration? deltaDate;
  double? acceleration;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onPanStart: (_) {
        iDate = DateTime.now();
        iSpeed = sqrt(pow(dX, 2) + pow(dY, 2));
      },

      onPanEnd: (_) {

        deltaDate = (fDate!.difference(iDate!));
        deltaSpeed = fSpeed - iSpeed;

        // it's the law to calc acceleration but the problem is i can't convert duration

        //Done i did it after 13Minutes, lol
       acceleration = deltaSpeed / deltaDate!.inSeconds;

        print("$fDate" + "$iDate" + "Delta Time" + " $deltaDate " + "s");
        print("$fSpeed" + " $iSpeed" + "Delta Speed" + " $deltaSpeed " + "m" + "$acceleration");

        fSpeed = 0;
        dX = 0;
        dY = 0;

      },
      onPanUpdate: (DragUpdateDetails details) {
        dX = details.delta.dx;
        dY = details.delta.dy;
        dX *= (dX < 0 ? -1 : 1);
        dY *= (dY < 0 ? -1 : 1);

        fDate = DateTime.now();
        fSpeed = sqrt(pow(dX, 2) + pow(dY, 2));

        setState(() {
          end = iSpeed;
        });
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: RoundedMeter(
                name: "Speed",
                value: fSpeed,
                end: () {
                  Restart(end);
                },
              )),
              Expanded(
                  child: RoundedMeter(
                      name: "DX",
                      value: dX,
                      end: () {
                        Restart(end);
                      })),
              Expanded(
                  child: RoundedMeter(
                      name: "DY",
                      value: dY,
                      end: () {
                        Restart(end);
                      })),
              Expanded(child: Text("acceleration=Δv/Δt=  " + "$acceleration" + " m/s^2"))
            ],
          ),
        ),
      ),
    );
  }

  double? Restart(double end) {
    setState(() {
      end;
    });
  }
}