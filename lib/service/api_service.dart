import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/constants.dart';
import 'package:delivery/dialog/dialog.dart';
import 'package:delivery/models/get_api_response_model.dart';
import 'package:delivery/service/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:http/http.dart' as http;

enum ApiResponseType { PlainString, SingleRow, MultipleRow, Unformatted }

class ApiService extends GetxService {
  static void handleError(
      Map<String, dynamic>? result, Function? errorCallback) {
    if (result != null) {

      if (errorCallback != null) {

        errorCallback(result);
      }

      Get.snackbar(snackPosition:SnackPosition.BOTTOM,
        "Error!",
        '${result['message']}',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error),
      );

    }
  }

  static handleDeleteResponse(
      dynamic response,  ApiResponseType responseType,Function? successCallback, Function? errorCallback) {
    Map<String, dynamic> result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      switch (responseType) {
        case ApiResponseType.PlainString:
          GetPlainStringResponse res = GetPlainStringResponse.fromJson(result);
          if (successCallback != null) successCallback(res.data);
          break;
        case ApiResponseType.SingleRow:
          GetSingleApiResponse res = GetSingleApiResponse.fromJson(result);
          if (successCallback != null) successCallback(res.data);
          break;
        case ApiResponseType.Unformatted:
        // GetSingleApiResponse res = GetSingleApiResponse.fromJson(result);
          if (successCallback != null) successCallback(result);
          break;
        default:
          GetDataApiResponse res = GetDataApiResponse.fromJson(result);

          if (successCallback != null) successCallback(res.data);
      }

    } else {
      handleError(result, errorCallback);
    }
  }

  static handlePostOrGetResponse(dynamic response, ApiResponseType responseType,
      Function? successCallback, Function? errorCallback) {
    Map<String, dynamic> result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print(jsonDecode(response.body));
      switch (responseType) {
        case ApiResponseType.PlainString:
          GetPlainStringResponse res = GetPlainStringResponse.fromJson(result);
          if (successCallback != null) successCallback(res.data);
          break;
        case ApiResponseType.SingleRow:
          GetSingleApiResponse res = GetSingleApiResponse.fromJson(result);
          if (successCallback != null) successCallback(res.data);
          break;
        case ApiResponseType.Unformatted:
          // GetSingleApiResponse res = GetSingleApiResponse.fromJson(result);
          if (successCallback != null) successCallback(result);
          break;
        default:
          GetDataApiResponse res = GetDataApiResponse.fromJson(result);

          if (successCallback != null) successCallback(res.data);
      }
    } else {

      handleError(result, errorCallback);
    }
  }

  static deleteRequest(ApiResponseType responseType,
      String uri, Function successCallback, Function? errorCallback,
      {bool showRequestDetail = false}) async {
    if (showRequestDetail) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);
      var response = await http.delete(Uri.tryParse('$baseApiUrl${uri}')!);
      handleDeleteResponse(response,responseType, successCallback, errorCallback);
    } else {
      try {

        http.Response response =
            await http.delete(Uri.tryParse('$baseApiUrl${uri}')!);
        handleDeleteResponse(response,responseType, successCallback, errorCallback);
      } on TimeoutException catch (e) {
        handleError({'message': 'Connection Timeout ocurred'}, null);
      } on SocketException catch (e) {
        handleError({'message': 'Network  Error occured'}, null);
      } on Error catch (e) {

        handleError({'message': 'Some error occured ${e}'}, null);
      }
    }
  }

  static postRequest(
      ApiResponseType responseType,
      String uri,
      Map<String, dynamic> body,
      Map<String, String>? additional_header,
      Function successCallback,
      Function? errorCallback,
      {bool showRequestDetail = false}) async {
    UserService us=Get.find();
    var token=us.user?.token;
    Map<String, String> headers = {
      //'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    if(token!=null)
      headers['Authorization']='Bearer '+token;


    if (additional_header != null) headers.addAll(additional_header);

    if (showRequestDetail) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);
      var response = await http.post(Uri.tryParse('$baseApiUrl${uri}')!,
          headers: headers, body: body);

      handlePostOrGetResponse(
          response, responseType, successCallback, errorCallback);
    } else {
      try {
        http.Response response = await http.post(
            Uri.tryParse('$baseApiUrl${uri}')!,
            headers: headers,
            body: body);

        handlePostOrGetResponse(
            response, responseType, successCallback, errorCallback);

      } on TimeoutException catch (e) {
        handleError(
            {'message': 'Connection Timeout ocurred,Please try again'}, null);
      } on SocketException catch (e) {
        handleError({'message': 'Network  Error occured'}, null);
      } on Error catch (e) {

        handleError({'message': 'Some error occured ${e}'}, null);
      }
    }
  }

  static getRequest(ApiResponseType responseType, String uri,
      Function successCallback, Function? errorCallback,
      {bool showRequestDetail = false}) async {
    UserService us=Get.find();
    var token=us.user?.token;

    Map<String, String> headers = {
      //'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    if(token!=null)
      headers['Authorization']='Bearer '+token;
    else{

    }

    if (showRequestDetail) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);
      var response =
          await http.get(Uri.tryParse('$baseApiUrl${uri}')!, headers: headers);
      handlePostOrGetResponse(
          response, responseType, successCallback, errorCallback);
    } else {

        http.Response response = await http.get(
          Uri.tryParse('$baseApiUrl${uri}')!,
          headers: headers,
        );

        handlePostOrGetResponse(
            response, responseType, successCallback, errorCallback);

    }
  }
}
