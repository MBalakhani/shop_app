import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_application/utils/prefs_operator.dart';
import '../featuers/featuer_home/data/data_source/home_api_provider.dart';
import '../featuers/featuer_home/data/repositories/home_repository.dart';
import '../featuers/feature_auth/bloc/login_bloc/login_bloc.dart';
import '../featuers/feature_auth/bloc/signup_bloc/signup_bloc.dart';
import '../featuers/feature_auth/data/data_source/auth_api_provider.dart';
import '../featuers/feature_auth/data/repositories/auth_repository.dart';
import '../featuers/feature_product/data/data_source/category_api_provider.dart';
import '../featuers/feature_product/data/data_source/product_api_provider.dart';
import '../featuers/feature_product/repositories/all_product_repository.dart';
import '../featuers/feature_product/repositories/category_repository.dart';

GetIt locator = GetIt.instance;

Future<void> initLocator() async {
  locator.registerSingleton<Dio>(Dio());

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<PrefsOperator>(PrefsOperator());

  /// api provider
  locator.registerSingleton<HomeApiProvider>(HomeApiProvider(locator()));
  locator
      .registerSingleton<CategoryApiProvider>(CategoryApiProvider(locator()));
  locator
      .registerSingleton<ProductsApiProvider>(ProductsApiProvider(locator()));
  locator.registerSingleton<AuthApiProvider>(AuthApiProvider(locator<Dio>()));

  /// repository
  locator.registerSingleton<HomeRepository>(HomeRepository(locator()));
  locator.registerSingleton<CategoryRepository>(CategoryRepository(locator()));
  locator.registerSingleton<AllProductsRepository>(
      AllProductsRepository(locator()));
  locator.registerSingleton<AuthRepository>(
      AuthRepository(locator<AuthApiProvider>()));

  // /// bloc
  locator.registerSingleton<SignupBloc>(SignupBloc(locator<AuthRepository>()));
  locator.registerSingleton<LoginBloc>(LoginBloc(locator<AuthRepository>()));
}
