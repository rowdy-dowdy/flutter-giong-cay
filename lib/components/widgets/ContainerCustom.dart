import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/services/theme_data.dart';

class ContainerCustom extends ConsumerWidget {
  final Widget? child;
  const ContainerCustom({this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Theme.of(context).custom.padding),
      child: child,
    );
  }
}