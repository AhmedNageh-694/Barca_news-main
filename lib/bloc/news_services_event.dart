part of 'news_services_bloc.dart';

@immutable
sealed class NewsservicesEvent {}

class GetNewsEvent extends NewsservicesEvent {
  final String category;
  GetNewsEvent({required this.category});
}
