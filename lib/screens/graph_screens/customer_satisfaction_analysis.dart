import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vodafone_project/models/AGMStore.dart';
import 'package:vodafone_project/models/AGMStoreGroup.dart';
import 'package:vodafone_project/screens/graph_screens/target_audience_analysis.dart';

class CustSatisfAnalysis extends StatefulWidget {
  static const String routeName = '/customer_satisfaction_analysis';
  @override
  _CustSatAnalysisState createState() => _CustSatAnalysisState();
}

class _CustSatAnalysisState extends State<CustSatisfAnalysis> {
  /*final List<AGMStoreGroup> testList = <AGMStoreGroup>[
    AGMStoreGroup(genderTotal: [61,48] ,ageTotal: [18, 14, 20, 22, 19, 16],femaleCount:[9,5,9,8,8,9],maleCount: [9,9,11,14,11,7],stores:[AGMStore(name: "Antalya Bilim Universitesi",maleCount:[3,4,4,8,6,3],femaleCount: [3,1,3,2,4,4],genderTotal: [28,17],ageTotal: [6,5,7,10,10,7] ),AGMStore(name: 'Teknokent Antalya',maleCount:[6,5,7,6,5,4],femaleCount: [6,4,6,6,4,5] ,ageTotal: [12,9,13,12,9,9],genderTotal: [33,31],),],),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
        actions: [
          IconButton(
            icon: Icon(Icons.show_chart),
            onPressed: () => {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Container();
                },
              ),
            },
          ),
        ],
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
        ],
      ),
    );
  }
}
