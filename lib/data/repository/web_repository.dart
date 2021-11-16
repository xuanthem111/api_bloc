import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:testapi2/data/model/web_model.dart';

class WebApiRepository {
  Future<WedApi> getWebApi() async {
    String url =
        'https://newsapi.org/v2/everything?q=tesla&from=2021-10-11&sortBy=publishedAt&apiKey=f650a93f63634105a75a352e57de91ec';

    var uri = Uri.parse(url);
    var res = await http.get(uri);
    if (res.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
      print(jsonResponse);
      return WedApi.fromJson(jsonResponse);
    } else {
      print('EEEEE');
      throw Exception();
    }
  }
}
