import 'package:equatable/equatable.dart';

abstract class WebApiEvent extends Equatable{

  @override
  List<Object> get props =>[];

}

class  FetchWebApiEvent extends WebApiEvent{

}