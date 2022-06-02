import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vodafone_project/screens/graph_screens/customer_satisfaction_analysis.dart';
import 'package:vodafone_project/screens/graph_screens/people_count.dart';
import 'package:vodafone_project/screens/graph_screens/target_audience_analysis.dart';


class HomeProvider with ChangeNotifier {
  String route;

  String chooseStatistics(String title){
    if(title == "Hedef Kitle Analizi"){
      route = TargetAudienceAnalysisScreen.routeName;
    }
    else if(title == "Kisi Sayar"){
      route = PeopleCount.routeName;
    }
    else if(title == "Musteri Memnuyiet Analizi"){
      route = CustSatisfAnalysis.routeName;
    }
    notifyListeners();
    return route;

  }

}

