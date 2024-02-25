import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/schedule/data/repository/schedule_repository_impl.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

class CoursesControllerNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    //Return nothing
  }

  Future<Either<Fail, void>> addCourse(Course course) async {
    state = AsyncValue.loading();
    final res =
        await ref.read(scheduleRepositoryProvider).addCourse(course: course);
    state = AsyncValue.data('');
    return res;
  }
}

final coursesControllerProvider =
    AsyncNotifierProvider<CoursesControllerNotifier, void>(
        CoursesControllerNotifier.new);
