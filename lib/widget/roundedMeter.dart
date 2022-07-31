import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RoundedMeter extends StatelessWidget {
  RoundedMeter(
      {required String this.name,
      required double this.value,
      required Function this.end});

  double? value;
  String? name;
  Function end;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
        title: GaugeTitle(
            text: name!,
            textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        axes: [
          RadialAxis(
            minimum: 0,
            maximum: 100,
            interval: 20,
            ranges: [
              GaugeRange(
                startValue: 0,
                endValue: 100,
                color: Colors.lightBlueAccent,
              ),
            ],
            pointers: [
              NeedlePointer(
                onValueChangeEnd: (value) {
                  end;
                },
                enableAnimation: true,
                value: value!,
              )
            ],
            annotations: [
              GaugeAnnotation(
                widget: Text(
                  "${value!.toInt()}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                angle: 90,
                positionFactor: 0.5,
              )
            ],
          )
        ]);
  }
}
