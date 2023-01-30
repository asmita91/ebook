import 'package:flutter/material.dart';

import '../../widgets/signupform.dart';

class OurSignUp extends StatelessWidget {
  const OurSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              BackButton(),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 30,
              ),
              OurSignUpForm()
            ],
          ))
        ],
      ),
    );
  }
}
