import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/components/loading/HomeListLoading.dart';
import 'package:sample/components/widgets/ContainerCustom.dart';
import 'package:sample/controllers/diary/diary_controller.dart';
import 'package:sample/controllers/home_controller.dart';
import 'package:sample/services/theme_data.dart';
import 'package:sample/utils/utils.dart';

class HomePageAppBar extends ConsumerWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text('Home').tr(),
      // leading: const Icon(Icons.menu_rounded),
      backgroundColor: Theme.of(context).colorScheme.background.withAlpha(200),
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: kToolbarHeight,
            color: Colors.transparent,
          ),
        ),
      ),
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

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // padding: const EdgeInsets.only(top: kToolbarHeight),
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
                        const SizedBox(height: kToolbarHeight + 10,),
                        ContainerCustom(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text("Hello", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),).tr().animate()
                                .fadeIn(duration: 900.ms).move(begin: const Offset(0, -16), curve: Curves.easeOutQuad),
                              const SizedBox(height: 5,),
                              Text("Your farming diary", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),).tr()
                                .animate().fadeIn(duration: 900.ms, delay: 200.ms).move(begin: const Offset(0, -16), curve: Curves.easeOutQuad),
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
                                  left: index == 0 ? padding : 0,
                                  right: padding
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
                                        color: Theme.of(context).colorScheme.secondaryContainer,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                    ),
                                    const SizedBox(width: 16,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text("My products", style: TextStyle(fontWeight: FontWeight.w600),
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
                          )
                        ).animate(delay: 500.ms)
                        .fadeIn(duration: 900.ms)
                        .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
                        .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
                      
                        const SizedBox(height: 20,),
                        ContainerCustom(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 5/3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    const Text("Learn mint easily", style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                    ),),
                                    const SizedBox(width: 10,),
                                    const Spacer(),
                                    ElevatedButton(
                                      onPressed: (){}, 
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: Text("Show Tips".toUpperCase(), style: TextStyle(
                                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                                        fontWeight: FontWeight.w600
                                      ), )
                                    )
                                  ],
                                )
                              ],
                            ),
                          ).animate(delay: 200.ms).fadeIn(duration: 900.ms).move(begin: const Offset(0, 16), curve: Curves.easeOutQuad),
                        ),

                        const SizedBox(height: 20,),
                        ContainerCustom(
                          child: AlignedGridView.count(
                            shrinkWrap: true,
                            itemCount: 10,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.secondaryContainer,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    const Text("Up comming Harvet", style: TextStyle(
                                      fontWeight: FontWeight.w600
                                    ), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                    const SizedBox(height: 4,),
                                    Text("Patient 3 days", style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      fontSize: 12,
                                    )),
                                  ],
                                ),
                              ).animate(delay: (500 * index).ms)
                              .fadeIn(duration: 900.ms)
                              .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
                              .move(begin: const Offset(0, 16), curve: Curves.easeOutQuad);
                            },
                          ),
                        ),

                        const SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
        ),

        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: HomePageAppBar()
        )
      ],
    );
  }
}