import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/common/presentation/app_progress_indicator.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';
import 'package:picup/features/schedule/presentation/controllers/courses_controller.dart';
import 'package:picup/features/schedule/presentation/controllers/get_courses.dart';
import 'package:picup/features/schedule/presentation/widgets/add_course_bottomsheet.dart';
import 'package:picup/main.dart';
import 'package:picup/util/constants.dart';
import 'package:time_planner/time_planner.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  final List<TimePlannerTask> list = [];
  @override
  Widget build(BuildContext context) {
    getDayNum(DaysCourse day) {
      switch (day) {
        case DaysCourse.sun:
          return 0;

        case DaysCourse.mon:
          return 1;
        case DaysCourse.tue:
          return 2;
        case DaysCourse.wed:
          return 3;
        case DaysCourse.thu:
          return 4;
        case DaysCourse.fri:
          return 5;
        case DaysCourse.sat:
          return 6;
      }
    }

    getTimeTask(Course course) {
      for (DaysCourse day in course.days) {
        return TimePlannerTask(
          color: ColorConstants.PRIMARY_400,
          minutesDuration: (course.endTime.hour - course.startTime.hour) * 60 +
              (course.endTime.minute - course.startTime.minute),
          dateTime: TimePlannerDateTime(
              day: getDayNum(day),
              hour: course.startTime.hour,
              minutes: course.startTime.minute),
          child: Text(
            course.name,
            style: TextBodyConstants.bold12,
            textAlign: TextAlign.center,
          ),
        );
      }
    }

    final coursesProvider = ref.watch(getCoursesProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Schedule",
            style: TextHeadersContatns.h3.copyWith(
                color: ColorConstants.PRIMARY_50, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: coursesProvider.when(
        data: (courses) {
          courses.map((course) {
            for (DaysCourse day in course.days) {
              list.add(TimePlannerTask(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(course.name),
                    actions: [
                      TextButton(
                        onPressed: () {},
                        child: Text("Delete"),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Edit"),
                      )
                    ],
                  ),
                ),
                color: ColorConstants.PRIMARY_400,
                minutesDuration:
                    (course.endTime.hour - course.startTime.hour) * 60 +
                        (course.endTime.minute - course.startTime.minute),
                dateTime: TimePlannerDateTime(
                    day: getDayNum(day),
                    hour: course.startTime.hour,
                    minutes: course.startTime.minute),
                child: Text(
                  course.name,
                  style: TextBodyConstants.bold12,
                  textAlign: TextAlign.center,
                ),
              ));
            }
          }).toList();

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final res = await showModalBottomSheet<Course>(
                  backgroundColor: ColorConstants.PRIMARY_400,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const AddCourseBottomsheet(),
                  ),
                );
                if (res != null) {
                  list.add(getTimeTask(res) as TimePlannerTask);
                  print("added");
                }
                setState(() {});
                print("hello world");
              },
              backgroundColor: ColorConstants.PRIMARY_400,
              tooltip: "Add Course",
              child: const Icon(
                Icons.add,
                color: ColorConstants.PRIMARY_100,
              ),
            ),
            body: TimePlanner(
              tasks: list,
              style: TimePlannerStyle(
                  cellWidth: 50,
                  cellHeight: 70,
                  backgroundColor: ColorConstants.PRIMARY_100,
                  dividerColor: ColorConstants.PRIMARY_500),
              startHour: 4,
              endHour: 23,
              headers: [
                TimePlannerTitle(
                  title: "SUN",
                  titleStyle: TextBodyConstants.bold14
                      .copyWith(color: ColorConstants.PRIMARY_400),
                ),
                TimePlannerTitle(
                  title: "MON",
                  titleStyle: TextBodyConstants.bold14
                      .copyWith(color: ColorConstants.PRIMARY_400),
                ),
                TimePlannerTitle(
                  title: "TUE",
                  titleStyle: TextBodyConstants.bold14
                      .copyWith(color: ColorConstants.PRIMARY_400),
                ),
                TimePlannerTitle(
                  title: "WED",
                  titleStyle: TextBodyConstants.bold14
                      .copyWith(color: ColorConstants.PRIMARY_400),
                ),
                TimePlannerTitle(
                  title: "THU",
                  titleStyle: TextBodyConstants.bold14
                      .copyWith(color: ColorConstants.PRIMARY_400),
                ),
                TimePlannerTitle(
                  title: "FRI",
                  titleStyle: TextBodyConstants.bold14
                      .copyWith(color: ColorConstants.PRIMARY_400),
                ),
                TimePlannerTitle(
                  title: "SAT",
                  titleStyle: TextBodyConstants.bold14
                      .copyWith(color: ColorConstants.PRIMARY_400),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => SizedBox(
          child: Text(error.toString()),
        ),
        loading: () => const AppProgressIndicator(),
      ),
    );
  }
}
