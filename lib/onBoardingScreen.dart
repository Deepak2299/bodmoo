import 'package:bodmoo/Screens/GoogleSignIn/googleSignInScreen.dart';
import 'package:bodmoo/Screens/realMeat/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => _getStartedTapped(),
                    // Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomeScreen())),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 500.0,
                  padding: EdgeInsets.all(40),
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      // Column(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: <Widget>[
                      //     Image.asset(
                      //       'assets/google.png',
                      //       height: 300,
                      //       width: 300,
                      //     ),
                      //     Text(
                      //       "Sign In",
                      //       style: TextStyle(
                      //         color: Theme.of(context).primaryColorDark,
                      //         fontWeight: FontWeight.w700,
                      //         fontSize: 20,
                      //       ),
                      //     ),
                      //     Text(
                      //       'Sign in with Google Account and verify phone number',
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.w400,
                      //         color: Colors.grey,
                      //         fontSize: 18,
                      //       ),
                      //     )
                      //   ],
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: AssetImage(
                                'assets/search.png',
                              ),
                              height: 300.0,
                              width: 300.0,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Center(
                            child: Text(
                              'Search',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Search parts need ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: AssetImage(
                                'assets/pay.png',
                              ),
                              height: 300.0,
                              width: 300.0,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Center(
                            child: Text(
                              'Pay',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Place order after paying through any modes',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: AssetImage(
                                'assets/delivery.png',
                              ),
                              height: 300.0,
                              width: 300.0,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Center(
                            child: Text(
                              'Delivery',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Get your parts delivered on your doorste',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: FloatingActionButton(
                              backgroundColor: Theme.of(context).primaryColorDark,
                              child: Icon(
                                Icons.arrow_forward,
                              ),
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1 ? _showGetStartedButton() : Text(''),
    );
  }

  Widget _showGetStartedButton() {
    final GestureDetector loginButtonWithGesture = new GestureDetector(
      onTap: _getStartedTapped,
      child: new Container(
        height: 50.0,
        decoration: new BoxDecoration(
            color: Theme.of(context).primaryColorDark, borderRadius: new BorderRadius.all(Radius.circular(6.0))),
        child: new Center(
          child: new Text(
            'GET STARTED',
            style: new TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              // fontFamily: UtilsImporter().stringUtils.HKGrotesk
            ),
          ),
        ),
      ),
    );

    return new Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 30.0), child: loginButtonWithGesture);
  }

  void _getStartedTapped() {
    // Navigator.push(context, new MaterialPageRoute(builder: (context) => new
    //
    // GoogleScreen()));
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false);
  }
}
