import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vodafone_project/providers/auth.dart';
import 'package:vodafone_project/providers/home.dart';
import 'package:vodafone_project/providers/targAudAnalysisProvider.dart';
import 'package:vodafone_project/screens/graph_screens/customer_satisfaction_analysis.dart';
import 'package:vodafone_project/screens/graph_screens/people_count.dart';
import 'package:vodafone_project/screens/graph_screens/target_audience_analysis.dart';
import 'package:vodafone_project/utils/Theme.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() => runApp(Vodafone());

class Vodafone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TargAudAnalysisProvider(),
        )
      ],
      child: MaterialApp(
        home: TargetAudienceAnalysisScreen(),
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          TargetAudienceAnalysisScreen.routeName: (context) => TargetAudienceAnalysisScreen(),
          CustSatisfAnalysis.routeName: (context) => CustSatisfAnalysis(),
          PeopleCount.routeName: (context) => PeopleCount(),
        },
      ),
    );
  }
}
