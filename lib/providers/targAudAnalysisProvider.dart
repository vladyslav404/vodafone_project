import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vodafone_project/models/AGMStore.dart';
import 'package:vodafone_project/models/AGMStoreGroup.dart';
import 'package:vodafone_project/models/GenderAndAgeCount.dart';
import 'package:vodafone_project/models/ageTotal.dart';
import 'package:vodafone_project/models/femaleCount.dart';
import 'package:vodafone_project/models/genderTotal.dart';
import 'package:vodafone_project/models/maleCount.dart';
import 'package:vodafone_project/utils/GraphQLSetup.dart';
import 'package:vodafone_project/utils/apis.dart';

enum Gender { male, female }

class TargAudAnalysisProvider with ChangeNotifier {
  String exception;
  List<AGMStoreGroup> resultsAgm = [];
  List<GenderAndAgeTotal> combineGendAge = [];
  String chosenStore;

  Map<String,bool> isAge ={"0-9": false,"10-18":false,"19-28":false,"29-40":false, "41-54":false,"55+":false};


  List<String> ages = [
    "0-9",
    "10-18",
    "19-28",
    "29-40",
    "41-54",
    "55+",
  ];

  List<String> gender = [
    "male",
    "female",
  ];
  int index = 0;

  void chooseCompany(String value) {
    chosenStore = value;
    notifyListeners();
  }

  void renewpage(){
    notifyListeners();
  }

  void findIndexCompany( List<AGMStore> stores,String chosenCompany) {
    if(chosenCompany == null){
      chosenCompany='';
    }

    if (stores != [] && stores.isNotEmpty && chosenCompany != '') {
      index = stores.indexWhere((store) => store.name == chosenCompany);
      print("comes to index");
    }

  }

  Future<void> getResultAgm() async {
    final MutationOptions options = MutationOptions(
      documentNode: gql(getResultsAGMMutation),
      variables: <String, String>{
        'token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImlhdCI6MTYxMjI4ODAwNH0.pH1NqFtWXo8YSlj6RpxEmqSRgo6nI99IMYdt-H-pP6c',
      },
    );

    List<AgeTotal> createAgeList(List<int> receivedLst) {
      List<AgeTotal> lst = [];
      receivedLst.asMap().forEach(
        (index, element) {
          lst.add(AgeTotal(age: ages[index], amount: element));
        },
      );
      return lst;
    }

    List<GenderTotal> createGenderList(List<int> receivedLst) {
      List<GenderTotal> lst = [];
      receivedLst.asMap().forEach(
        (index, element) {
          lst.add(GenderTotal(gender: gender[index], amount: element));
        },
      );
      return lst;
    }

    List<MaleCount> createMaleCountList(List<int> receivedLst) {
      List<MaleCount> lst = [];
      receivedLst.asMap().forEach(
        (index, element) {
          lst.add(MaleCount(age: ages[index], amount: element));
        },
      );
      return lst;
    }

    List<FemaleCount> createFemaleCountList(List<int> receivedLst) {
      List<FemaleCount> lst = [];
      receivedLst.asMap().forEach(
        (index, element) {
          lst.add(FemaleCount(age: ages[index], amount: element));
        },
      );
      return lst;
    }

    List<AGMStore> getList(Map map) {
      List<AGMStore> lst = [];
      if (map != null) {
        map['getResultsAGM']['stores'].forEach(
          (value) {
            lst.add(
              AGMStore(
                name: value['name'].toString(),
                ageTotal: createAgeList(value['ageTotal'].cast<int>()),
                genderTotal: createGenderList(value['genderTotal'].cast<int>()),
                maleCount: createMaleCountList(value['maleCount'].cast<int>()),
                femaleCount: createFemaleCountList(value['femaleCount'].cast<int>()),
              ),
            );
          },
        );
      }
      return lst;
    }

    final QueryResult result = await GraphQLSetup.client.mutate(options);
    print(result.data);

    if (result.data != null) {
      result.data.forEach(
        (key, value) {
          resultsAgm.add(
            AGMStoreGroup(
              ageTotal: createAgeList(value['ageTotal'].cast<int>()),
              genderTotal: createGenderList(value['genderTotal'].cast<int>()),
              maleCount: createMaleCountList(value['maleCount'].cast<int>()),
              femaleCount: createFemaleCountList(value['femaleCount'].cast<int>()),
              stores: getList(result.data),
            ),
          );
        },
      );
      combineGendAge.addAll(resultsAgm[0].maleCount.cast<GenderAndAgeTotal>());
      combineGendAge.addAll(resultsAgm[0].femaleCount.cast<GenderAndAgeTotal>());
      print(combineGendAge);

    } else {
      exception = result.exception.toString();
      errorShow();
    }

    notifyListeners();
  }

  void errorShow() {
    if (exception.contains('Failed to connect to')) {
      exception = "Failed to connect to server. Please check your connection";
    }
  }
}
