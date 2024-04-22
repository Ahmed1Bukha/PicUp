import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';
import 'package:picup/features/my_courses/presentation/widgets/show_course_widget.dart';
import 'package:picup/features/schedule/presentation/controllers/get_courses.dart';
import 'package:picup/util/constants.dart';
import 'package:open_file/open_file.dart';

class MyCoursesScreen extends ConsumerWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "My Courses",
          style: TextHeadersContatns.h3.copyWith(
              color: ColorConstants.PRIMARY_50, fontWeight: FontWeight.bold),
        ),
      ),
      body: ref.watch(getCoursesProvider).when(
            data: (data) => data.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Courses added yet!",
                          style: TextHeadersContatns.h3.copyWith(
                            color: ColorConstants.PRIMARY_50,
                          ),
                        ),
                        TextButton(
                            onPressed: () => context.go("/schedule"),
                            child: Text(
                              "Add courses",
                              style: TextHeadersContatns.h3.copyWith(
                                  color: ColorConstants.PRIMARY_50,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  )
                : ListView(
                    children: AnimateList(
                      interval: Duration(milliseconds: 300),
                      children: data
                          .map((e) => ShowCourseWidget(
                                courseInfo: e,
                                onTap: () async {
                                  await Gal.open();
                                },
                              ))
                          .toList(),
                      effects: [
                        const SlideEffect(
                          begin: Offset(-1, 0),
                          end: Offset(0, 0),
                          curve: Curves.easeInOut,
                          duration: Durations.long4,
                        ),
                        const FadeEffect(duration: Durations.long4)
                      ],
                    ),
                  ),
            error: (error, stackTrace) => Center(
              child: Text("Error: $error"),
            ),
            loading: () => const CircularProgressIndicator(),
          ),
    );
  }
}
