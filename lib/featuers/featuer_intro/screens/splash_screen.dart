import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_application/di/locator.dart';
import 'package:shop_application/featuers/featuer_intro/screens/intro_main_wrapper.dart';
import 'package:shop_application/utils/prefs_operator.dart';
import 'package:shop_application/widgets/main_wrapper.dart';
import '../bloc/splash_cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashCubit>(context).checkConnectionEvent();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DelayedWidget(
                delayDuration: const Duration(milliseconds: 200),
                animationDuration: const Duration(seconds: 2),
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                child: Image.asset(
                  'assets/images/besenior_logo.png',
                  width: width * 0.8,
                ),
              ),
            ),
            BlocConsumer<SplashCubit, SplashState>(
              builder: (context, state) {
                /// if user is online
                if (state.connectionStatus is ConnectionInitial ||
                    state.connectionStatus is ConnectionOn) {
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: LoadingAnimationWidget.prograssiveDots(
                      color: Colors.black,
                      size: 50,
                    ),
                  );
                }

                /// if user is offline
                if (state.connectionStatus is ConnectionOff) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'به اینترنت متصل نیستید!',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontFamily: "vazir"),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        splashColor: Colors.red,
                        onPressed: () {
                          /// check that we are online or not
                          BlocProvider.of<SplashCubit>(context)
                              .checkConnectionEvent();
                        },
                        icon: const Icon(
                          Icons.autorenew,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  );
                }

                /// default value
                return Container();
              },
              listener: (context, state) {
                if (state.connectionStatus is ConnectionOn) {
                  gotoHome();
                }
              },
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  Future<void> gotoHome() async {
    PrefsOperator prefsOperator = locator<PrefsOperator>();
    var shouldShowIntro = await prefsOperator.getIntroState();

    return Future.delayed(const Duration(seconds: 3), () {
      if (shouldShowIntro) {
        Navigator.pushNamedAndRemoveUntil(context, IntroMainWrapper.routeName,
            ModalRoute.withName("intro_main_wrapper"));
      } else {
        Navigator.pushNamedAndRemoveUntil(context, MainWrapper.routeName,
            ModalRoute.withName("main_wrapper"));
      }
    });
  }
}
