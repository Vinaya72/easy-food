import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/boundary/screens/login_page.dart';
import '../../control/authentication.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, @required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Hello, \n" +
                    _user.displayName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),

              ),

              SizedBox(height: 30),

              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(
                          top: 20
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Colors.grey[200],
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    '/RestaurantPage'
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 15.0),
                                child:
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/restaurant.jpeg'),
                                      radius: 70,
                                    ),
                                    Text("Restaurants",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,

                                      ),)
                                  ],
                                ),

                              ),
                            ),
                            SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/RecipePage'
                                );
                              },
                              child: Container(
                                child:
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/recipes.jpg'),
                                      radius: 70,
                                    ),
                                    Text("Recipes",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,

                                      ),)
                                  ],
                                ),

                              ),
                            ),
                            SizedBox(height: 35),
                            _isSigningOut
                                ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            )

                                : SizedBox(
                              width: 200,
                              child: RaisedButton(
                                color: Colors.orange,
                                padding: const EdgeInsets.all(20),
                                onPressed: () async {
                                  setState(() {
                                    _isSigningOut = true;
                                  });
                                  await Authentication.signOut(
                                      context: context);
                                  setState(() {
                                    _isSigningOut = false;
                                  });
                                  Navigator.of(context)
                                      .pushReplacement(_routeToSignInScreen());
                                },
                                child: Center(

                                  child: Text('Logout',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,

                                  ),

                                ),
                              ),
                            )
                          ],

                        ),
                      )

                  )

              ),
            ],
          ),
        )
    );
  }
}
