part of 'news_services_bloc.dart';

@immutable
sealed class NewsservicesState {}

final class NewsservicesInitial extends NewsservicesState {}

final class NewsLoading extends NewsservicesState {}

final class NewsLoaded extends NewsservicesState {
  final List<ArticleModel> articles;
  NewsLoaded({required this.articles});
}

final class NewsError extends NewsservicesState {
  final String message;
  NewsError({required this.message});
}
