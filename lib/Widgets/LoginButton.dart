import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tsfsocialui/Helpers/auth.dart';
import 'package:tsfsocialui/Screens/LandingPage.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({
    Key? key,
    required this.heightOfButton,
    required this.type,
    required this.changeLoading,
  }) : super(key: key);

  final double heightOfButton;
  final String type;
  final Function changeLoading;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool pressed = false;
  final AuthProvider _auth = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String result;
        setState(() {
          pressed = !pressed;
        });
        widget.changeLoading(load: pressed);
        if (widget.type == 'Facebook') {
          result = await _auth.loginToFacebook();
          if (result == 'pass') {
            Navigator.of(context).pushReplacementNamed(LandingPage.routeName,
                arguments: _auth.userData);
          } else if (result == 'cancel') {
            setState(() {
              pressed = !pressed;
            });
            widget.changeLoading(load: pressed);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Login Canceled!'),
              duration: Duration(milliseconds: 800),
            ));
          } else if (result == 'error') {
            setState(() {
              pressed = !pressed;
            });
            widget.changeLoading(load: pressed);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Something went Wrong!'),
              duration: Duration(milliseconds: 800),
            ));
          }
        } else if (widget.type == 'Google') {
          result = await _auth.logInWithGoogle();
          if (result == 'pass') {
            Navigator.of(context).pushReplacementNamed(LandingPage.routeName,
                arguments: _auth.userData);
          } else if (result == 'error') {
            setState(() {
              pressed = !pressed;
            });
            widget.changeLoading(load: pressed);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Failed!'),
              duration: Duration(milliseconds: 800),
            ));
          }
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: widget.type == 'Facebook'
              ? Colors.blue.shade900
              : Colors.red.shade800,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: pressed
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    offset: const Offset(
                      1.0,
                      1.0,
                    ),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
        ),
        height: widget.heightOfButton,
        child: pressed
            ? const Center(
                child: SpinKitChasingDots(
                  color: Colors.white,
                  size: 40.0,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Icon(
                        widget.type == 'Facebook'
                            ? FontAwesomeIcons.facebookF
                            : FontAwesomeIcons.google,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.type,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
