import 'package:camera_camera/camera_camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picup/common/presentation/app_snackbar.dart';
import 'package:picup/features/camera/presentation/controllers/camera_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        context.push('/schedule');
      }),
      body: CameraCamera(onFile: (file) async {
        final res = await ref
            .read(camerControllerProvider.notifier)
            .savePhoto(file: file);

        showSnackBar(context, "hello");
        res.fold((l) => print(l), (r) => showSnackBar(context, r));
      }),
    );
  }
}
