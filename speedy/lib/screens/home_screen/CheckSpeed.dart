import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CheckSpeed extends StatefulWidget {
  @override
  _CheckSpeedState createState() => _CheckSpeedState();
}

class _CheckSpeedState extends State<CheckSpeed>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> value;

  @override
  void initState() {
    super.initState();
    animController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    value = Tween<double>(begin: 0, end: 100).animate(animController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animController.forward();
        }
      });

    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Check speed",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            height: 200,
            child: SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 150,
                ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
                  GaugeRange(
                      startValue: 50, endValue: 100, color: Colors.orange),
                  GaugeRange(startValue: 100, endValue: 150, color: Colors.red)
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(value: value.value, enableAnimation: true)
                ],
                annotations: <GaugeAnnotation>[
                  // GaugeAnnotation(
                  //     widget: Container(
                  //         child: Text('90.0',
                  //             style: TextStyle(
                  //                 fontSize: 25, fontWeight: FontWeight.bold))),
                  //     angle: 90,
                  //     positionFactor: 0.5)
                ],
              )
            ]),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/check');
            },
            color: Colors.green,
            child: Text(
              "Check my speed",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ],
      ),
    ));
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}
