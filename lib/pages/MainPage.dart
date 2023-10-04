import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/components/sample/AutomaticKeepAliveClientMixin.dart';
import 'package:sample/pages/calendar/CalendarPage.dart';
import 'package:sample/pages/home/HomePage.dart';
import 'package:sample/pages/planting/PlantingPage.dart';
import 'package:sample/pages/settings/SettingsPage.dart';

class MainPage extends ConsumerStatefulWidget {
  final String location;
  const MainPage({required this.location, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  int currentPageIndex = 0;

  late List<Map<String, dynamic>> menu = [
    {
      "icon": CupertinoIcons.house,
      "iconFill": CupertinoIcons.house_fill,
      "label": "Home",
      "location": "/",
      "page": const HomePage(),
    },
    {
      "icon": CupertinoIcons.clock,
      "iconFill": CupertinoIcons.clock_fill,
      "label": "Calendar",
      "location": "/calendar",
      "page": const CalendarPage(),
    },
    {
      "icon": Icons.eco_outlined,
      "iconFill": Icons.eco_rounded,
      "label": "Planting",
      "location": "/planting",
      "page": const PlantingPage(),
    },
    {
      "icon": CupertinoIcons.settings,
      "iconFill": CupertinoIcons.settings,
      "label": "Personal",
      "location": "/settings",
      "page": const SettingsPage(),
    }
  ];

  void changePage({String? location}) {
    int index = menu.indexWhere((element) => element['location'] == (location ?? widget.location));
    if (index < 0) {
      index = 0;
    }

    // setState(() {
    //   currentPageIndex = index;
    // });

    _tabController.animateTo(index);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: menu.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentPageIndex = _tabController.index;
      });
    });

    // changePage();
  }

  @override
  void didUpdateWidget(MainPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    changePage(location: widget.location);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(menu.length, (index) => 
          KeepAliveClient(
            // key: PageStorageKey(menu[index]['location']),
            child: menu[index]['page'] as Widget
          )
        )
      ),
      // body: widget.child,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              
            ),
            ListTile(
              title: const Text('Business'),
             
            ),
            ListTile(
              title: const Text('School'),
            
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)
          )
        ),
        child: NavigationBar(
          destinations: menu.mapIndexed((i, e) => 
            NavigationDestination(
              icon: Icon(currentPageIndex == i ? e['iconFill'] : e['icon']), 
              label: tr(e['label'])
            )
          ).toList(),
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            // _tabController.animateTo(index);
            // setState(() {
            //   currentPageIndex = index;
            // });
            context.go(menu[index]['location']);
          },
          // animationDuration: const Duration(milliseconds: 100),
          height: 70,
        ),
      ),
    );
  }
}