import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/components/sample/ExpandedSection.dart';
import 'package:sample/components/sample/TimeLine.dart';
import 'package:sample/components/sample/TimeLineTop.dart';
import 'package:sample/main.dart';
import 'package:sample/services/theme_data.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

  List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  DateTime _selectedDay = DateTime.now();
  bool isShowCalendar = true;

  late PageController _pageController;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();

    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay.value));
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay.value = focusedDay;
    });

    _selectedEvents.value = _getEventsForDay(_selectedDay);
  }

  final data = [1,2,3,4,5,6,7,8,9];

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text('Calendar', style: TextStyle(
            // color: Theme.of(context).colorScheme.onPrimary
          ),).tr(),
          // backgroundColor: Theme.of(context).colorScheme.primary,
          iconTheme: IconThemeData(
            // color: Theme.of(context).colorScheme.onPrimary
          ),
        ),
        ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (context, value, _) {
            return _CalendarHeader(
              focusedDay: value,
              isShowCalendar: isShowCalendar,
              onLeftArrowTap: () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              onRightArrowTap: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              onChangeShowCalendar: () {
                setState(() {
                  isShowCalendar = !isShowCalendar;
                });
              }
            );
          }
        ),
        ExpandedSection(
          expand: isShowCalendar,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            // margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.background
                ),
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.outlineVariant
                )
              )
            ),
            child: TableCalendar(
              locale: context.locale.toString(),
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay.value,
              onCalendarCreated: (controller) => _pageController = controller,
              headerVisible: false,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: _onDaySelected,
              eventLoader: _getEventsForDay,
              onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() => _calendarFormat = format);
                }
              },
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontWeight: FontWeight.w600
                ),
                weekendStyle: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontWeight: FontWeight.w600
                ),
                // dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date)[0],
              ),
        
              daysOfWeekHeight: 30,
              calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600
                ),
                outsideTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontWeight: FontWeight.w600
                ),
                weekendTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  // borderRadius: BorderRadius.circular(14)
                  shape: BoxShape.circle
                ),
                selectedTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600
                ),
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  // borderRadius: BorderRadius.circular(14)
                  shape: BoxShape.circle
                ),
                todayTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w600
                ),
                markerSize: 5,
                markerMargin: const EdgeInsets.symmetric(horizontal: 1),
                markerDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle
                ),
                tablePadding: const EdgeInsets.symmetric(horizontal: 10)
              ),
            ),
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Container(
              // padding: const EdgeInsets.all(padding),
              child: Column(
                children: [
                  Timeline(
                    padding: const EdgeInsets.symmetric(horizontal: padding, vertical: 12),
                    indicatorSize: 10,
                    indicatorColor: Theme.of(context).colorScheme.secondary,
                    gutterSpacing: 20,

                    indicatorColors: data.map((e) => 
                      Theme.of(context).colorScheme.secondary
                    ).toList(),

                    leftChildren: data.map((e) => 
                      Text("21:20", style: TextStyle(fontWeight: FontWeight.w500),),
                    ).toList(),

                    children: data.map((e) => 
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(20)
                              ),
                            )
                          ],
                        ),
                      ),
                    ).toList(),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onChangeShowCalendar;
  final VoidCallback onRightArrowTap;
  final bool isShowCalendar;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.isShowCalendar,
    required this.onChangeShowCalendar
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat("MMMM - yyyy", context.locale.toString()).format(focusedDay).toCapitalize();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.background)
        )
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(!isShowCalendar ? Icons.arrow_drop_down_rounded: Icons.arrow_drop_up_rounded),
            onPressed: onChangeShowCalendar,
          ),
          const SizedBox(width: 10,),
          Text(
            headerText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: onLeftArrowTap,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}