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
          // leading: const Icon(Icons.menu_rounded),
          backgroundColor: Theme.of(context).colorScheme.background,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ContainerCustom(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text("home.Hello", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),).tr(),
                              const SizedBox(height: 5,),
                              Text("home.Your farming diary", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),).tr(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 104,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 240,
                                margin: EdgeInsets.only(
                                  left: index == 0 ? Theme.of(context).custom.padding : 0,
                                  right: Theme.of(context).custom.padding
                                ),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.background,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                    ),
                                    const SizedBox(width: 16,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("My products", style: TextStyle(fontWeight: FontWeight.w600),
                                            maxLines: 2, overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 5,),
                                          Text("4 Crops", style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(context).colorScheme.onSurfaceVariant
                                          ),)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      
                        const SizedBox(height: 20,),
                        ContainerCustom(
                          // child: ,
                        )
                      ],
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