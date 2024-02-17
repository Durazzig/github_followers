import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:multiple_result/multiple_result.dart';

enum RequestType { get, post }

class GFError {
  const GFError({required this.msg});

  final String msg;
}

class Request {
  final String url;
  final Object? body;
  final RequestType method;

  Request({required this.url, this.body, required this.method});
}

class NetworkManager {
  static Future<Map<String, String>> headers() async {
    return {
      "App-Key":
          "hby0Dtky6g6Nems8VA64s3dCS4xAMY4nRPyBc4pu0gDLcKI5uFBPJg9pPnzvEu7C",
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
  }

  static Future<Result<T, GFError>> call<T>({
    required Request request,
    bool parseToListObject = false,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    if (await InternetConnectionChecker.createInstance().hasConnection) {
      if (kDebugMode) {
        log("Request body of ${request.url}");
        log(request.body.toString());
        log("===================================================");
      }
      http.Response response;
      switch (request.method) {
        case RequestType.get:
          response = await http
              .get(
            Uri.parse(request.url),
            headers: await headers(),
          )
              .timeout(
            const Duration(seconds: 60),
            onTimeout: () {
              return http.Response(
                "{\"message\":\"Something went wrong, please try again later\"}",
                408,
              );
            },
          ).catchError(
            (onError) {
              return http.Response(
                "{\"message\":\"Something went wrong, please try again later\"}",
                500,
              );
            },
          );
        case RequestType.post:
          response = await http
              .post(
            Uri.parse(request.url),
            headers: await headers(),
            body: jsonEncode(request.body),
          )
              .timeout(
            const Duration(seconds: 60),
            onTimeout: () {
              return http.Response(
                "{\"message\":\"Something went wrong, please try again later\"}",
                408,
              );
            },
          ).catchError(
            (onError) {
              return http.Response(
                "{\"message\":\"Something went wrong, please try again later\"}",
                500,
              );
            },
          );
      }

      if (kDebugMode) {
        log("Response body of ${request.url}");
        log(response.body);
        log("===================================================");
      }

      try {
        Map<String, dynamic> jsonMap;
        if (parseToListObject) {
          List<dynamic> jsonList = jsonDecode(response.body);
          Map<String, dynamic> wrappedJson = {"data": jsonList};
          jsonMap = wrappedJson;
        } else {
          jsonMap = jsonDecode(response.body);
        }
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          return Success(fromJson(jsonMap));
        } else {
          return Error(
            GFError(
              msg: jsonMap['message'] ??
                  "Something went wrong, please try again later",
            ),
          );
        }
      } catch (e) {
        return const Error(
          GFError(
            msg: "Something went wrong, please try again later",
          ),
        );
      }
    }
    return const Error(
      GFError(
        msg: "Please check your internet connection",
      ),
    );
  }

  static Future<Result<List<T>, GFError>> callList<T>({
    required Request request,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    if (await InternetConnectionChecker.createInstance().hasConnection) {
      if (kDebugMode) {
        log("Request body of ${request.url}");
        log(request.body.toString());
        log("===================================================");
      }
      http.Response response;
      switch (request.method) {
        case RequestType.get:
          response = await http
              .get(
            Uri.parse(request.url),
            headers: await headers(),
          )
              .timeout(
            const Duration(seconds: 60),
            onTimeout: () {
              return http.Response(
                "{\"message\":\"Something went wrong, please try again later\"}",
                408,
              );
            },
          ).catchError(
            (onError) {
              return http.Response(
                "{\"message\":\"Something went wrong, please try again later\"}",
                500,
              );
            },
          );
          break; // Added break to fix missing break in the original code
        case RequestType.post:
          response = await http
              .post(
            Uri.parse(request.url),
            headers: await headers(),
            body: jsonEncode(request.body),
          )
              .timeout(
            const Duration(seconds: 60),
            onTimeout: () {
              return http.Response(
                "{\"message\":\"Something went wrong, please try again later\"}",
                408,
              );
            },
          ).catchError(
            (onError) {
              return http.Response(
                "{\"message\":\"Something went wrong, please try again later\"}",
                500,
              );
            },
          );
          break; // Added break to fix missing break in the original code
      }

      if (kDebugMode) {
        log("Response body of ${request.url}");
        log(response.body);
        log("===================================================");
      }

      try {
        List<dynamic> jsonList = jsonDecode(response.body);
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          List<T> resultList =
              jsonList.map((jsonMap) => fromJson(jsonMap)).toList();
          return Success(resultList);
        } else {
          return Error(
            GFError(
              msg: jsonDecode(response.body)['message'] ??
                  "Something went wrong, please try again later",
            ),
          );
        }
      } catch (e) {
        return const Error(
          GFError(
            msg: "Something went wrong, please try again later",
          ),
        );
      }
    }
    return const Error(
      GFError(
        msg: "Please check your internet connection",
      ),
    );
  }
}
