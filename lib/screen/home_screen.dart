import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jw_calendar/component/calendar.dart';
import 'package:jw_calendar/component/schedule_card.dart';
import 'package:jw_calendar/component/today_banner.dart';
import 'package:jw_calendar/component/schedule_bottom_sheet.dart';
import 'package:jw_calendar/const/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloationActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySelcted,
            ),
            SizedBox(
              height: 8.0,
            ),
            TodayBanner(
              selectedDay: selectedDay,
              scheduleCount: 4,
            ),
            SizedBox(
              height: 8.0,
            ),
            _ScheduleList(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloationActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) {
            return ScheduleBottomSheet();
          },
        );
      },
      backgroundColor: PRIMARY_COLOR,
      child: Icon(
        Icons.add,
      ),
    );
  }

  onDaySelcted(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 8.0,
              );
            },
            itemBuilder: (context, index) {
              return ScheduleCard(
                startTime: 12,
                endTime: 14,
                content: '프로그래밍공부. $index',
                color: Colors.red,
              );
            }),
      ),
    );
  }
}
