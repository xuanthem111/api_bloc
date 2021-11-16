import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:testapi2/blocs/web_api_even.dart';
import 'package:testapi2/blocs/web_api_state.dart';
import 'package:http/http.dart' as http;
import 'package:testapi2/data/model/web_model.dart';

import 'dart:convert' as convert;

import 'package:testapi2/data/repository/web_repository.dart';

class WebApiBloc extends Bloc<WebApiEvent, WebApiState> {
  WebApiRepository webApiRepository;

  WebApiBloc({required this.webApiRepository}) : super(WebApiLoadingState());

  WebApiLoadingState get initialState => WebApiLoadingState();

  @override
  Stream<WebApiState> mapEventToState(WebApiEvent event) async* {
    if (event is FetchWebApiEvent) {
      yield WebApiLoadingState();
      try {
        WedApi wedApi = await webApiRepository.getWebApi();
        print("Bloc Success");
        yield WebApiSuccessState(wedApi: wedApi);
      } catch (e) {
        print(await webApiRepository.getWebApi());
        yield WebFailState(message: "???");
      }
    }

    // LoadImageBloc(LoadImageState initialState) : super(initialState);

    // Future<WedApi> fetchApi(String? link) async {
    //   var uri = Uri.parse(link ?? '');
    //   var res = await http.get(uri);
    //   if (res.statusCode == 200) {
    //     var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
    //     print(jsonResponse);
    //     return WedApi.fromJson(jsonResponse);
    //   } else {
    //     throw Exception('Failed');
    //   }
    // }
  }
}
