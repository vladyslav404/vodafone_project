import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vodafone_project/screens/graph_screens/target_audience_analysis.dart';

class PeopleCount extends StatefulWidget {
  static const String routeName = '/people_counts';
  @override
  _PeopleCountState createState() => _PeopleCountState();
}


class _PeopleCountState extends State<PeopleCount> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
      ),
      body: IntroSlider(
        isShowSkipBtn: false,
        isShowDoneBtn: false,
        slides: [
          Slide(
            backgroundColor: Colors.white,
            centerWidget: SfCartesianChart(
              plotAreaBorderWidth: 0,
              title: ChartTitle(text: "Customer Gender Distribution"),
              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                axisLine: AxisLine(width: 0),
                labelFormat: '{value}',
                majorTickLines: MajorTickLines(size: 0),
              ),
              series: [

              ],
              tooltipBehavior: TooltipBehavior(enable: true, header: '', canShowMarker: false),
            ),
          ),
          Slide(

            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}


