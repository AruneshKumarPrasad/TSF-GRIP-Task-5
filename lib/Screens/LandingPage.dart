import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tsfsocialui/Helpers/auth.dart';
import 'package:tsfsocialui/Screens/HomeScreen.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);
  static const String routeName = '/LandingPage';
  final AuthProvider _auth = AuthProvider();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/logo.png')),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Home",
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: Colors.white, fontSize: 30),
          ),
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () async {
              _auth.signOut().whenComplete(() => Navigator.of(context)
                  .pushReplacementNamed(HomeScreen.routeName));
            },
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Icon(FontAwesomeIcons.arrowRightFromBracket),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.contain,
              child: CircleAvatar(
                backgroundImage: NetworkImage(args['picture']['data']['url']),
                radius: 75,
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                args['name'],
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 24),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                args['email'],
                overflow: TextOverflow.fade,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
