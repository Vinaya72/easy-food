import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../control/authentication.dart';
import '../widgets/google_sign_in_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/app-logo.png',
                height: 200,
                width: 200,

              ),
              Text(
                'EasyFood',
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ) ,
              ),
              const SizedBox(height: 10),
              const Text(
                  'Get Your preferred restaurants and recipes',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              const SizedBox(height: 50),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.orange,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}