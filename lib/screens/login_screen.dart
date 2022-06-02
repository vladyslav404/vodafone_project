import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vodafone_project/providers/auth.dart';
import 'package:vodafone_project/screens/home_screen.dart';
import 'package:vodafone_project/utils/const.dart';
import 'package:vodafone_project/widgets/AlertDialog.dart';
import 'package:vodafone_project/widgets/TextFields.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isInit = true;

  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void didChangeDependencies() {
    if(_isInit){
    Provider.of<LoginProvider>(context).checkLocStorage().then((_){
          userNameController.text = Provider.of<LoginProvider>(context,listen: false).username;
       passwordController.text = Provider.of<LoginProvider>(context,listen: false).password;
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    userNameController.clear();
    passwordController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Image.asset('images/logo.jpg'),
                  height: 60.0,
                ),
                Text(
                  'Vodafone',
                  style: TextStyle(
                    fontSize: 45.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  loginTextField(
                    textInputAction: TextInputAction.next,
                    labelText: str_userName,
                    textEditingController: userNameController,
                    validatorMsg: str_validUsrName,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  loginTextField(
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    labelText: str_password,
                    textEditingController: passwordController,
                    validatorMsg: str_validPass,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Consumer<LoginProvider>(
                        builder: (context, auth, _) => Checkbox(
                          activeColor: Colors.red,
                          value: auth.rememberMe,
                          onChanged: (_) => auth.rememberCheck(auth.rememberMe),
                        ),
                      ),
                      Text("Remember me"),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      elevation: 5.0,
                      color: Color(0xFFE60103),
                      borderRadius: BorderRadius.circular(30.0),
                      child: Consumer<LoginProvider>(
                        builder: (context, auth, _) => Column(
                          children: [
                            auth.isLoading
                                ? CircularProgressIndicator()
                                : MaterialButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        await auth.checkUser(
                                          userNameController.text,
                                          passwordController.text,
                                        );
                                        if (auth.hasException) {
                                          alertDialog(
                                            context,
                                            title: str_warning,
                                            content: auth.toStringException(auth.exceptionMsg),
                                            optionOne: str_retry,
                                            optionTwo: str_resetPassword,
                                          );
                                        } else {
                                          if(auth.rememberMe){
                                            await auth.rememberUserPass(userNameController.text, passwordController.text);
                                          }
                                          else{
                                            await auth.dontRememberUserPass();
                                          }
                                          Navigator.pushNamed(context, HomeScreen.routeName);
                                        }
                                      }
                                    },
                                    minWidth: 200.0,
                                    height: 42.0,
                                    child: Text(
                                      str_login,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
