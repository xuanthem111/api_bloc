import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:testapi2/data/model/web_model.dart';

abstract class WebApiState extends Equatable {
  @override
  List<Object> get props => [];
}

class WebApiLoadingState extends WebApiState {

  
}

class WebApiSuccessState extends WebApiState {
  late final WedApi wedApi;

  WebApiSuccessState({required this.wedApi});

  @override
  // TODO: implement props
  List<Object> get props => [wedApi];
}

class WebFailState extends WebApiState {
  final String message;

  WebFailState({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
  // final List<Article> articles;

  // LoadImageState({List<Article>? articles})
  //     : this.articles = articles ?? <Article>[];

  // @override
  // // TODO: implement props
  // List<Object?> get props => [articles];


  
