import 'package:flutter/material.dart';

/// Loading indicator for sliver contexts
class SliverLoadingIndicator extends StatelessWidget {
  final double topPadding;

  const SliverLoadingIndicator({super.key, this.topPadding = 100});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

/// Error message for sliver contexts
class SliverErrorMessage extends StatelessWidget {
  final String message;

  const SliverErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: Text(message)),
      ),
    );
  }
}

/// Empty state for sliver contexts
class SliverEmptyState extends StatelessWidget {
  final String message;

  const SliverEmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(child: Text(message)),
      ),
    );
  }
}
