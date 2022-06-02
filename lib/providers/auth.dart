import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vodafone_project/utils/apis.dart';
import 'package:vodafone_project/utils/GraphQLSetup.dart';
import 'package:vodafone_project/utils/const.dart';

class LoginProvider with ChangeNotifier {
  bool hasException = false;
  String exceptionMsg;
  String _token;
  DateTime expiryDate;
  bool rememberMe = false;
  String username='';
  String password='';
  bool haveDataInStorage = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool get isLoggedIn {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  void rememberCheck(bool remember){
    rememberMe = !remember;
    notifyListeners();
  }

  Future<void> checkLocStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    var rememberCheck = false;

   rememberCheck = prefs.getBool('rememberMe');
    if(rememberCheck!=null){
      rememberMe = rememberCheck;
      haveDataInStorage = true;
      username = prefs.getString('username');
      password = prefs.getString('password');
    }
    notifyListeners();
    
  }
  
  Future<void> rememberUserPass(String usrName, String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(!haveDataInStorage){
      prefs.setBool('rememberMe',true);
      prefs.setString('username',usrName);
      prefs.setString('password',pass);
    }
  }
  Future<void> dontRememberUserPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(haveDataInStorage){
    prefs.remove('rememberMe');
    prefs.remove('username');
    prefs.remove('password');
    }
    
  }

  Future<void> checkUser(String userName, String password) async {

    final MutationOptions options = MutationOptions(
      documentNode: gql(loginMutation),
      variables: <String, String>{
        str_userMutation: userName,
        str_passwordMutation: password,
      },
    );
    _isLoading = true;

    final QueryResult result = await GraphQLSetup.client.mutate(options);

    _isLoading = false;
    hasException = result.hasException;

    if (result.hasException) {
      exceptionMsg = result.exception.toString();
    } else {
      _token = result.data['Login']['accessToken'];
    }
    notifyListeners();
  }

  String toStringException(String exception) {
    if (exception.contains("User does not exist")) {
      exceptionMsg = str_userNotExist;
    } else if (exception.contains("Bad username or password")) {
      exceptionMsg = str_wrongCredentials;
    } else if (exception.contains("Failed to connect to")){
      exceptionMsg = str_connectLost;
    } else{
      exceptionMsg = "Unknown error. Please contact *******";
    }
    return exceptionMsg;
  }
}
