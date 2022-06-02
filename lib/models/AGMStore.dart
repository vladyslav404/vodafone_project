import 'package:vodafone_project/models/ageTotal.dart';
import 'package:vodafone_project/models/femaleCount.dart';
import 'package:vodafone_project/models/genderTotal.dart';
import 'package:vodafone_project/models/maleCount.dart';

class AGMStore{
   String name;
   List<MaleCount> maleCount=[];
   List<FemaleCount> femaleCount=[];
   List<AgeTotal> ageTotal=[];
   List<GenderTotal> genderTotal=[];

  AGMStore({this.name,this.maleCount,this.femaleCount,this.ageTotal,this.genderTotal});


}