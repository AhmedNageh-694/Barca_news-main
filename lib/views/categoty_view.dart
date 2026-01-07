import 'package:flutter/material.dart';
import 'package:news_app/widget/news_list_view_builder.dart';

class CategotyView extends StatelessWidget {
  const CategotyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Player'), centerTitle: true),
      body: const CustomScrollView(
        slivers: [
          Newslistviewbuilder(category: 'fcbarcelona'),
        ],
      ),
    );
  }
}
