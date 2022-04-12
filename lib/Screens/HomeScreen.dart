import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Widgets/LoginButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> loadingState = ValueNotifier(false);
    double heightOfScreen = MediaQuery.of(context).size.height;
    double heightOfButton = heightOfScreen * 0.15;
    void changeLoadingState({required bool load}) {
      loadingState.value = load;
    }

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Login",
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: Colors.white, fontSize: 30),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.headline1,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Hi,\n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(
                                        fontSize: 40,
                                        color: Colors.grey.shade800,
                                      ),
                                ),
                                TextSpan(
                                  text:
                                      "I'm Arunesh and I proudly present my\nFirst Task!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        color: Colors.blueGrey.shade900,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: LottieBuilder.asset(
                            'assets/login.json',
                            reverse: true,
                            repeat: true,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Task : Social Media Integration',
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Login with Social Media',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 10,
                                child: LoginButton(
                                  heightOfButton: heightOfButton,
                                  type: 'Google',
                                  changeLoading: changeLoadingState,
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 10,
                                child: LoginButton(
                                  heightOfButton: heightOfButton,
                                  type: 'Facebook',
                                  changeLoading: changeLoadingState,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ValueListenableBuilder(
                        valueListenable: loadingState,
                        builder: (BuildContext context, bool loading, child) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            height: heightOfScreen * 0.3,
                            color: Colors.transparent,
                            transform: Matrix4.translationValues(
                              0,
                              loading ? 0 : heightOfScreen * 0.3,
                              0,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
