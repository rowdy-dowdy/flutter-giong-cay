import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({this.preferredSize = const Size.fromHeight(kToolbarHeight), super.key});

  @override
    final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text('Home').tr(),
      // leading: const Icon(Icons.menu_rounded),
      backgroundColor: Colors.transparent,
      // backgroundColor: Theme.of(context).colorScheme.background.withAlpha(200),
      // flexibleSpace: ClipRect(
      //   child: BackdropFilter(
      //     filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
      //     child: Container(
      //       color: Colors.transparent,
      //     ),
      //   ),
      // ),
      actions: [
        InkWell(
          onTap: (){},
          child: Container(
            width: 56, height: 56,
            child: Center(
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(Icons.person, size: 20, color: Theme.of(context).colorScheme.background,)
              ),
            ),
          ),
        )
      ],
    );
  }
}