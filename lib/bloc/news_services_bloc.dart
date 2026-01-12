import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/articlemodel.dart';
import 'package:news_app/services/news_services.dart';

part 'news_services_event.dart';
part 'news_services_state.dart';

class NewsServicesBloc extends Bloc<NewsservicesEvent, NewsservicesState> {
  final NewsServices _newsServices;

  NewsServicesBloc()
    : _newsServices = NewsServices(Dio()),
      super(NewsservicesInitial()) {
    on<GetNewsEvent>(_onGetNews);
  }

  Future<void> _onGetNews(
    GetNewsEvent event,
    Emitter<NewsservicesState> emit,
  ) async {
    emit(NewsLoading());
    try {
      final articles = await _newsServices.getSportsNews(query: event.category);
      if (articles.isEmpty) {
        emit(NewsError(message: 'No articles found or network error.'));
      } else {
        emit(NewsLoaded(articles: articles));
      }
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }
}
