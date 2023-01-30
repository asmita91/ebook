import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../states/currentUser.dart';
import '../home.dart';
import '../login/login.dart';

enum AuthStatus { notLoggedIn, LoggedIn }

class OurRoot extends StatefulWidget {
  const OurRoot({Key? key}) : super(key: key);

  @override
  State<OurRoot> createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  void didChangeDependencies() async {
    super.didChangeDependencies();

    CurrentUser _currentuser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentuser.onStartUp();
    if (_returnString == "success") {
      setState(() {
        _authStatus = AuthStatus.LoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = OurLogin();
        break;
      case AuthStatus.LoggedIn:
        retVal = Home();
        break;
      default:
        retVal = OurLogin();
    }
    return retVal;
  }
}
