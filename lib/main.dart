import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/config/my_theme.dart';
import 'package:shop_application/di/locator.dart';
import 'package:shop_application/featuers/featuer_intro/screens/intro_main_wrapper.dart';
import 'package:shop_application/test_screen.dart';
import 'package:shop_application/widgets/main_wrapper.dart';
import 'blocs/bottom_nav_cubit.dart';
import 'featuers/featuer_intro/bloc/splash_cubit/splash_cubit.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import 'featuers/feature_auth/bloc/login_bloc/login_bloc.dart';
import 'featuers/feature_auth/bloc/signup_bloc/signup_bloc.dart';
import 'featuers/feature_auth/screens/mobile_signup_screen.dart';
import 'featuers/feature_product/screens/all_products_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await initLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit()),
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => locator<SignupBloc>()),
        BlocProvider(create: (context) => locator<LoginBloc>()),
      ],
      child: const Application(),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      initialRoute: "/",
      locale: const Locale("fa", ""),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en", ""),
        Locale("fa", ""),
      ],
      debugShowCheckedModeBanner: false,
      routes: {
        IntroMainWrapper.routeName: (context) => IntroMainWrapper(),
        TestScreen.routeName: (context) => const TestScreen(),
        MainWrapper.routeName: (context) => MainWrapper(),
        MobileSignUpScreen.routeName: (context) => const MobileSignUpScreen(),
        AllProductsScreen.routeName: (context) => const AllProductsScreen(),
      },
      home: MainWrapper(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
