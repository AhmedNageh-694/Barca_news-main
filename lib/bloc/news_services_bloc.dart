import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_services_event.dart';
part 'news_services_state.dart';

class NewsServicesBloc extends Bloc<NewsservicesEvent, NewsservicesState> {
  NewsServicesBloc() : super(NewsservicesInitial());
}
