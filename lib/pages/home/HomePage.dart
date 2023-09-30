import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/components/loading/HomeListLoading.dart';
import 'package:sample/components/widgets/ContainerCustom.dart';
import 'package:sample/controllers/diary/diary_controller.dart';
import 'package:sample/controllers/home_controller.dart';
import 'package:sample/services/theme_data.dart';
import 'package:sample/utils/utils.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<HomePage> {

  String getCurrentDay() {
    return DateFormat.EEEE(context.locale.toString()).format(DateTime.now());
  }

  String getCurrentDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        AppBar(
          title: const Text('pages.Home').tr(),
          leading: const Icon(Icons.menu_rounded),
          actions: [
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(Icons.person, size: 20, color: Theme.of(context).colorScheme.background,)
            )
          ],
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return RefreshIndicator(
                onRefresh: () async {
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  // padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: ContainerCustom(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("data", style: TextStyle(fontSize: 20),),
                          Text("data", style: TextStyle(color: Theme.of(context).colorScheme.outline),)
                          // Container(height: 200, color: Theme.of(context).extension<CustomColors>()?.sourceCustomcolor1,),
                          // Container(height: 200, color: Colors.red,),
                          // Container(height: 200, color: Colors.green,)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}