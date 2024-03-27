import 'dart:io';
import 'package:android_sms_retriever/android_sms_retriever.dart';
import 'package:dio/dio.dart';
import '../../../../config/constants.dart';
import '../../../../error_handling/check_exceptions.dart';
import '../../../../params/signup_params.dart';

class AuthApiProvider {
  Dio dio;
  AuthApiProvider(this.dio);

  dynamic callSignUp(SignUpParams signUpParams) async {
    try {
      final response = await dio.post("${Constants.baseUrl}/register",
          queryParameters: {
            "name": signUpParams.username,
            "mobile": signUpParams.phoneNumber
          });

      return response;
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }

  dynamic callLoginWithSms(phoneNumber) async {
    if (Platform.isAndroid) {}

    try {
      final response = await dio
          .post("${Constants.baseUrl}/auth/loginWithSms", queryParameters: {
        "mobile": phoneNumber,
        if (Platform.isAndroid)
          'hash': (await AndroidSmsRetriever.getAppSignature())
      });

      return response;
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }

  dynamic callCodeCheck(code) async {
    try {
      final response = await dio.post(
          "${Constants.baseUrl}/auth/loginWithSms/check",
          queryParameters: {
            "code": code,
          });

      return response;
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }

  dynamic callRegisterCodeCheck(mobile) async {
    try {
      final response = await dio
          .post("${Constants.baseUrl}/auth/sendcode", queryParameters: {
        "mobile": mobile,
        if (Platform.isAndroid)
          'hash': (await AndroidSmsRetriever.getAppSignature())
      });

      return response;
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }
}
