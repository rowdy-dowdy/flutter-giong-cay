import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        // color: primary.withOpacity(0.7),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Lottie.asset(
              'assets/lotties/anim_vegetable.json',
            ),
          ),
        ),
      ),
    );
  }
}