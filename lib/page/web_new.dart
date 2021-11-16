import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:testapi2/blocs/web_api_even.dart';
import 'package:testapi2/data/model/web_model.dart';
import 'package:testapi2/data/repository/web_repository.dart';

import '../blocs/bloc_webapi.dart';
import '../blocs/web_api_state.dart';

class Web extends StatelessWidget {
  const Web({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => WebApiBloc(webApiRepository: WebApiRepository()),
        child: WebNew(),
      ),
    );
  }
}

class WebNew extends StatefulWidget {
  const WebNew({Key? key}) : super(key: key);

  @override
  _WebNewState createState() => _WebNewState();
}

class _WebNewState extends State<WebNew> {
  late WebApiBloc _webApiBloc;

  // late Future<WedApi> web;
  // Future<WedApi> getDataFromApi() async {
  //   //https://randomuser.me/api/
  //   var uri = Uri.parse(
  //       'https://newsapi.org/v2/everything?q=apple&from=2021-11-11&to=2021-11-11&sortBy=popularity&apiKey=201bb53c584140af889730bdfb3c9001');
  //   var uri1 = Uri.parse(
  //       'https://newsapi.org/v2/everything?q=tesla&from=2021-10-13&sortBy=publishedAt&apiKey=201bb53c584140af889730bdfb3c9001');
  //   var res = await http.get(uri);

  //   if (res.statusCode == 200) {
  //     var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
  //     print(jsonResponse);
  //     return WedApi.fromJson(jsonResponse);
  //   } else {
  //     throw Exception('Failed');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _webApiBloc = BlocProvider.of<WebApiBloc>(context);
    _webApiBloc.add(FetchWebApiEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: 
      Container(
        child: BlocListener<WebApiBloc,WebApiState>(
          listener: (context,state){
              if (state is WebFailState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
          },
      child: BlocBuilder<WebApiBloc, WebApiState>(
          builder: (context, state) {
            if(state is WebApiLoadingState){
              return _buildLoading();
            } else if(state is WebApiSuccessState){
              return _buildArticleList(state.wedApi);
            }else if(state is WebFailState){
              return _buildErrorUi(state.message);
            }

        return Container();
      }),
      )
      )
    );

  }

  Widget _buildArticleList(WedApi wedApi) {
    return Container(
 
  child: new ListView.builder(
          padding: EdgeInsets.only(top: 30),
          itemCount: 1,
          itemBuilder: (context, int index) =>
              buildCustomItem(context, index,wedApi.articles),
        )
    );

  }
}
Widget  buildCustomItem(BuildContext context,int index,List<Article> data){

  return Column(
      children: [
          SizedBox(
            height: 14,
          ),
          RichText(
            text: TextSpan(
              text: 'Flutter',
              style: TextStyle(fontSize: 20, color: Colors.black),
              children: const <TextSpan>[
                TextSpan(text: 'News', style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
          Container(
            width: 400,
            height: 100,
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      print("hello");
                    },
                    child: Image.network(
                     data[index].urlToImage.toString(), 
                      // snapshot.articles[index].urlToImage.toString(),
                      width: 110,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: ListView.builder(itemBuilder: (context, index) {
            SizedBox(
              height: 3,
            );
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: Column(
                children: [
                  Container(
                    width: 380,
                    child: Image.network(
                       data[index].urlToImage.toString()),
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data[index].title.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                     data[index].content.toString(),
                    ),
                  )),
                ],
              )),
            );
          }))
          // Image.network(t.articles[2].urlToImage.toString()),
        ]);
 
}
Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  
