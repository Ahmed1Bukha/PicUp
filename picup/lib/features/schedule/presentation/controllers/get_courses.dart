import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/schedule/data/repository/schedule_repository_impl.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

final getCoursesProvider = FutureProvider<List<Course>>((ref) async {
  return ref.read(scheduleRepositoryProvider).getCourses();
});
