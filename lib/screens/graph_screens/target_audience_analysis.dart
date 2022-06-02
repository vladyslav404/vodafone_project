import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vodafone_project/models/GenderAndAgeCount.dart';
import 'package:vodafone_project/models/ageTotal.dart';
import 'package:vodafone_project/models/femaleCount.dart';
import 'package:vodafone_project/models/genderTotal.dart';
import 'package:vodafone_project/models/maleCount.dart';
import 'package:vodafone_project/providers/targAudAnalysisProvider.dart';
import 'package:vodafone_project/widgets/FilterChip.dart';

class TargetAudienceAnalysisScreen extends StatefulWidget {
  static const String routeName = '/target_audience_analysis';

  @override
  _TargetAudienceAnalysisScreenState createState() => _TargetAudienceAnalysisScreenState();
}

class _TargetAudienceAnalysisScreenState extends State<TargetAudienceAnalysisScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  ChartSeriesController _ageShopColumnChartSeriesController;
  ChartSeriesController _ageTotalColumnChartSeriesController;
  ChartSeriesController _genderStoreColumnChartController;
  ChartSeriesController _genderTotalColumnChartController;
  CircularSeriesController _genderTotalPieChartSeriesController;




  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TargAudAnalysisProvider>(context).getResultAgm().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    var devSize = MediaQuery.of(context).size;
    return _isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            color: Colors.white,
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.show_chart),
                  onPressed: () => {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Container(
                          child: Consumer<TargAudAnalysisProvider>(
                            builder: (context, targetAud, _) => Column(
                              children: [
                                Text("Company Name"),
                                DropdownButton(
                                  value: targetAud.chosenStore,
                                  hint: targetAud.resultsAgm[0].stores[0].name == null
                                      ? Text("Company name")
                                      : Text(targetAud.resultsAgm[0].stores[0].name),
                                  items: (List.generate(targetAud.resultsAgm[0].stores.length,
                                              (index) => targetAud.resultsAgm[0].stores[index].name).toSet() ==
                                          null)
                                      ? null
                                      : (List.generate(targetAud.resultsAgm[0].stores.length,
                                              (index) => targetAud.resultsAgm[0].stores[index].name).toSet())
                                          .map(
                                          (e) {
                                            return DropdownMenuItem(
                                              child: Text(e),
                                              value: e,
                                            );
                                          },
                                        ).toList(),
                                  onChanged: (value) {
                                    return targetAud.chooseCompany(value);
                                  },
                                ),
                                Wrap(
                                  children: List.generate(
                                    targetAud.ages.length,
                                    (index) => filterChip(targetAud.isAge.values.toList()[index],
                                      label: targetAud.ages[index],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    ElevatedButton(
                                    child: Icon(Icons.icecream),
                                    onPressed: () {
                                  //    targetAud.resultsAgm[0].genderTotal.removeAt(0);
                                        _genderTotalPieChartSeriesController.updateDataSource(
                                          removedDataIndexes: <int>[0],
                                        );
                                    },
                                  ),
                                    ElevatedButton(
                                      child: Icon(Icons.icecream),
                                      onPressed: () {
                                        _genderTotalPieChartSeriesController.updateDataSource(
                                            addedDataIndexes: <int>[0],);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  },
                ),
              ],
            ),
            body: Container(

              child: Consumer<TargAudAnalysisProvider>(
                builder: (context, targetAud, _) => IntroSlider(
                  isShowSkipBtn: false,
                  isShowDoneBtn: false,
                  slides: [
                    Slide(
                      widgetTitle: Container(
                        width: devSize.width,
                        height: devSize.height*0.7,
                        child: SfCircularChart(
                          title: ChartTitle(
                              text:
                                  "Toplam Deger: ${targetAud.resultsAgm[0].genderTotal[0].amount + targetAud.resultsAgm[0].genderTotal[1].amount}"),
                          legend: Legend(
                            isVisible: true,
                          ),
                          series: <PieSeries<GenderAndAgeTotal, String>>[
                            PieSeries(
                              onRendererCreated: (controller) {
                                _genderTotalPieChartSeriesController=controller;
                              },
                              dataSource: targetAud.combineGendAge,
                              xValueMapper: (dynamic data, _) {
                                return data.gender;
                              },
                              yValueMapper: (dynamic data, _) {
                                return data.amount;
                              },
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    Slide(
                      backgroundColor: Colors.white,
                      widgetTitle: Container(
                        width: devSize.width,
                        height: devSize.height*0.7,
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          title: ChartTitle(text: "Customer Gender Distribution"),
                          primaryXAxis: CategoryAxis(
                            majorGridLines: MajorGridLines(width: 0),
                          ),
                          series: [
                            ColumnSeries<AgeTotal, String>(
                              onRendererCreated: (ChartSeriesController controller) {
                                _ageTotalColumnChartSeriesController = controller;
                              },
                              dataSource: targetAud.resultsAgm[0].ageTotal,
                              xValueMapper: (AgeTotal data, _) => data.age,
                              yValueMapper: (AgeTotal data, _) => data.amount,
                            ),
                          ],
                          primaryYAxis: NumericAxis(
                            axisLine: AxisLine(width: 0),
                            labelFormat: '{value}',
                            majorTickLines: MajorTickLines(size: 0),
                          ),
                          tooltipBehavior: TooltipBehavior(enable: true, header: '', canShowMarker: false),
                        ),
                      ),
                    ),
                    Slide(
                      widgetTitle: Consumer<TargAudAnalysisProvider>(builder: (context, targ, _) {
                        targ.findIndexCompany(targetAud.resultsAgm[0].stores, targ.chosenStore);
                        return Container(
                          width: devSize.width,
                          height: devSize.height*0.7,
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            title: ChartTitle(text: "Detaylı Mağaza Analizi"),
                            primaryXAxis: CategoryAxis(
                              majorGridLines: MajorGridLines(width: 0),
                            ),
                            series: [
                              ColumnSeries<AgeTotal, String>(
                                dataSource: targetAud.resultsAgm[0].stores[targ.index].ageTotal,
                                xValueMapper: (AgeTotal data, _) => data.age,
                                yValueMapper: (AgeTotal data, _) => data.amount,
                              ),
                              ColumnSeries<GenderTotal, String>(
                                dataSource: targetAud.resultsAgm[0].stores[targ.index].genderTotal,
                                xValueMapper: (GenderTotal data, _) => data.gender,
                                yValueMapper: (GenderTotal data, _) => data.amount,
                              ),
                              ColumnSeries<FemaleCount, String>(
                                dataSource: targetAud.resultsAgm[0].stores[targ.index].femaleCount,
                                xValueMapper: (FemaleCount data, _) => data.age,
                                yValueMapper: (FemaleCount data, _) => data.amount,
                              ),
                              ColumnSeries<MaleCount, String>(
                                dataSource: targetAud.resultsAgm[0].stores[targ.index].maleCount,
                                xValueMapper: (MaleCount data, _) => data.age,
                                yValueMapper: (MaleCount data, _) => data.amount,
                              ),
                            ],
                            primaryYAxis: NumericAxis(
                              axisLine: AxisLine(width: 0),
                              labelFormat: '{value}',
                              majorTickLines: MajorTickLines(size: 2),
                            ),
                            tooltipBehavior: TooltipBehavior(enable: true, header: '', canShowMarker: false),
                          ),
                        );
                      }),
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
