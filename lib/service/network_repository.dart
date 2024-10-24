import 'dart:async';
import 'dart:convert';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'gloable_status_code.dart';

Future callPostMethod(String url, Map<String, dynamic> params) async {
  return await http
      .post(
        Uri.parse(url),
        body: json.encode(params),
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*",
          'accept': '*/*'
        },
      )
      .timeout(const Duration(seconds: 3))
      .then((http.Response response) {
        return getResponse(response);
      });
}

Future callPatchMethod(
    String url, Map<String, dynamic> body, String? token) async {
  Map<String, String> commonHeadersToken = {
    'Content-Type': 'application/json',
    'accept': '*/*',
    "Authorization":
        token != null && token.toString().isNotEmpty ? "Bearer $token" : "",
  };

  return await http
      .patch(
    Uri.parse(url),
    body: utf8.encode(json.encode(body)),
    headers: commonHeadersToken,
  )
      .then((http.Response response) {
    return getResponse(response);
  });
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future callPostMethodWithToken(String url, Map<String, dynamic> params) async {
  String? token = await getAuthToken();
  Map<String, String> commonHeadersToken = {
    'Content-Type': 'application/json',
    'accept': '*/*',
    "Authorization":
        token != null && token.toString().isNotEmpty ? "Bearer $token" : "",
  };
  return await http
      .post(Uri.parse(url),
          body: utf8.encode(json.encode(params)), headers: commonHeadersToken)
      .then((http.Response response) {
    return getResponse(response);
  });
}
Future callPutMethodWithToken(String url, Map<String, dynamic> params) async {
  String? token = await getAuthToken();
  Map<String, String> commonHeadersToken = {
    'Content-Type': 'application/json',
    'accept': '*/*',
    "Authorization":
    token != null && token.toString().isNotEmpty ? "Bearer $token" : "",
  };
  return await http
      .put(Uri.parse(url),
      body: utf8.encode(json.encode(params)), headers: commonHeadersToken)
      .then((http.Response response) {
    return getResponse(response);
  });
}

Future callPostMethodWithToken11(
    String searchKey, Map<String, dynamic> params) async {
  String? token = await getAuthToken();
  Map<String, String> commonHeadersToken = {
    'Content-Type': 'application/json',
    'accept': '*/*',
    "Authorization":
        token != null && token.toString().isNotEmpty ? "Bearer $token" : "",
  };

  final uri = Uri.https('181.215.78.241:5000', searchKey, params);
  return await http.post(uri, headers: commonHeadersToken);
}

Future callDeleteMethod(String url, Map<String, dynamic> params) async {
  String? token = await getAuthToken();
  Map<String, String> commonHeadersToken = {
    'Content-Type': 'application/json',
    'accept': '*/*',
    "Authorization":
        token != null && token.toString().isNotEmpty ? "Bearer $token" : "",
  };
  return await http
      .delete(Uri.parse(url),
          body: utf8.encode(json.encode(params)), headers: commonHeadersToken)
      .then((http.Response response) {
    return getResponse(response);
  });
}

Future callGETMethod({required String url, String? key}) async {
  String? token = await getAuthToken();
  print('=====Token${token}');
  Map<String, String> commonHeadersToken = {
    'Content-Type': 'application/json',
    'accept': '*/*',
    "Authorization":
        token != null && token.toString().isNotEmpty ? "Bearer $token" : "",
  };

  return await http
      .get(Uri.parse(url), headers: commonHeadersToken)
      .then((http.Response response) {
    return getResponse(response);
  });
}

Future callGETMethodWithQuery(String url, Map<String, dynamic> params) async {
  String? token = await getAuthToken();

  Map<String, String> commonHeadersToken = {
    'Content-Type': 'application/json',
    'accept': '*/*',
    "Authorization": token.toString().isNotEmpty ? "Bearer $token" : "",
  };
  final uri = Uri.https("181.215.78.241:5000", url, params);

  return await http
      .get(uri, headers: commonHeadersToken)
      .then((http.Response response) {
    return getResponse(response);
  });
}

Future getResponse(Response response) async {
  globalStatusCode = response.statusCode;
  printWrapped("response--statusCode--${response.statusCode}");
  printWrapped("response--${response.body}");
  if (globalStatusCode == 500 ||
      globalStatusCode == 502 ||
      globalStatusCode == 503) {
    return "{\"status\":\"false\",\"message\":\"Internal server issue\"}";
  } else if (globalStatusCode == 401) {


    showCommonDialog(context: navigatorKey.currentState!.context, title: "Error", content: "your session is expired please login again",
      btnPositive: "Login Again",
      onPressPositive: (){
        pushNamedAndRemoveUntil(context:  navigatorKey.currentState!.context, routeName: RouteName.loginScreen);
      },
      isMessage: true,);

    final parsedJson = jsonDecode(response.body.toString());
    final message = parsedJson['message'].toString();
    return "{\"status\":\"false\",\"message\":\"$message\"}";
  } else if (globalStatusCode == 403) {
    // final parsedJson = jsonDecode(response.body.toString());
    return "{\"status\":\"false\",\"message\":\"Internal server issue\"}";
  } else if (globalStatusCode == 405) {
    //assolyr
    String error = "This Method not allowed.";
    printWrapped("response--$error");
    return "{\"status\":\"0\",\"message\":\"$error\"}";
  } else if (globalStatusCode == 400) {
    final parsedJson = jsonDecode(response.body.toString());
    // final message = parsedJson['message'].toString();
    /* statusValue == false;
    errorMessage == parsedJson['message'].toString();*/
    //  print('====dddd==${response.body.toString()}');

    //  print('======status=par$status');
    return response.body;
  } else if (globalStatusCode == 422) {
    final parsedJson = jsonDecode(response.body.toString());
    final message = parsedJson['message'].toString();
    return "{\"status\":\"false\",\"message\":\"${message.replaceAll(RegExp(r'[^\w\s]+'), '')}\"}";
  } else if (globalStatusCode == 204) {
    final parsedJson = jsonDecode(response.body.toString());
    final message = parsedJson['message'].toString();
    return "{\"status\":\"false\",\"message\":\"${message.replaceAll(RegExp(r'[^\w\s]+'), '')}\"}";
  } else if (globalStatusCode < 200 || globalStatusCode > 404) {
    String error = response.headers['message'].toString();
    printWrapped("response--$error");
    return "{\"status\":\"0\",\"message\":\"$error\"}";
  }
  return response.body;
}
