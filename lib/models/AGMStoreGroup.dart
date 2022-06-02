import 'package:vodafone_project/models/AGMStore.dart';
import 'package:vodafone_project/models/ageTotal.dart';
import 'package:vodafone_project/models/femaleCount.dart';
import 'package:vodafone_project/models/genderTotal.dart';
import 'package:vodafone_project/models/maleCount.dart';

class AGMStoreGroup{
   List<AgeTotal> ageTotal=[];
   List<GenderTotal> genderTotal=[];
   List<MaleCount> maleCount=[];
   List<FemaleCount> femaleCount=[];
   List<AGMStore> stores=[];

  AGMStoreGroup({this.ageTotal, this.genderTotal, this.maleCount,this.femaleCount,this.stores});

}