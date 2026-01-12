import 'package:flutter/material.dart';
import 'package:news_app/widget/news_list_view_builder.dart';

class CategotyView extends StatelessWidget {
  const CategotyView({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category), centerTitle: true),
      body: CustomScrollView(
        slivers: [Newslistviewbuilder(category: category)],
      ),
    );
  }
}
