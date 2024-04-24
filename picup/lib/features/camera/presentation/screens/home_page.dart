import 'package:app_settings/app_settings.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:picup/common/presentation/app_button.dart';
import 'package:picup/common/presentation/app_snackbar.dart';
import 'package:picup/features/camera/presentation/controllers/camera_controller.dart';
import 'package:picup/util/constants.dart';

final camereDescProvider = Provider<List<CameraDescription>?>((ref) {
  return null;
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  double zoom = 1.0;
  late CameraController controller;
  bool isTaking = false;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
        ref.read(camereDescProvider)![0], ResolutionPreset.max);

    controller.initialize().then((_) {
      controller.setFlashMode(FlashMode.off);
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Permission.camera.status,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == PermissionStatus.granted) {
                return getCamera(context);
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Please enable camera permission",
                        textAlign: TextAlign.center,
                        style: TextHeadersContatns.h3
                            .copyWith(color: ColorConstants.PRIMARY_50),
                      ),
                      AppButton(
                        onTap: () async {
                          await AppSettings.openAppSettings();
                          setState(() {});
                        },
                        text: "Open Settings",
                        variation: AppButtonVariation.secondary,
                      )
                    ],
                  ),
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Stack getCamera(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onScaleUpdate: (details) async {
            var maxZoomLevel = await controller.getMaxZoomLevel();

            var dragIntensity = details.scale;
            if (dragIntensity > 1 && zoom < maxZoomLevel) {
              zoom += 0.01;
              print(details.scale);
            } else if (dragIntensity < 1 && zoom > 1) {
              zoom -= 0.01;
            }
            setState(() {
              controller.setZoomLevel(zoom);
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Align(
              alignment: Alignment.center,
              child: CameraPreview(
                controller,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, 0.8),
          child: BlurryContainer(
            color: ColorConstants.PRIMARY_400.withOpacity(0.4),
            height: 110,
            width: MediaQuery.of(context).size.width - 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: SvgPicture.asset(
                        "assets/icons/Group.svg",
                        width: 45,
                      ),
                      onPressed: () {
                        context.go("/schedule");
                      },
                    ),
                    Text(
                      "Schedule",
                      style: TextBodyConstants.bold14
                          .copyWith(color: ColorConstants.PRIMARY_50),
                    )
                  ],
                ).animate(delay: Duration(milliseconds: 500)).fadeIn(),
                isTaking
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: LoadingAnimationWidget.waveDots(
                            color: ColorConstants.PRIMARY_50, size: 40),
                      )
                    : IconButton(
                        icon: Container(
                            height: 120,
                            width: 120,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstants.PRIMARY_50,
                            ),
                            child: Center(
                                child: Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstants.PRIMARY_400,
                              ),
                            ))),
                        onPressed: () async {
                          setState(() {
                            isTaking = true;
                          });

                          final file = await controller.takePicture();

                          final res = await ref
                              .read(camerControllerProvider.notifier)
                              .savePhoto(path: file.path);

                          res.fold(
                              (l) => null,
                              (r) => showSnackBar(context,
                                  "Added camera photo to gallery: $r"));
                          setState(() {
                            isTaking = false;
                          });
                        },
                      ).animate(delay: Duration(milliseconds: 500)).fadeIn(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: SvgPicture.asset(
                        "assets/icons/Group (1).svg",
                        width: 45,
                      ),
                      onPressed: () {
                        context.go("/my_courses");
                      },
                    ),
                    Text(
                      "My Folders",
                      style: TextBodyConstants.bold14
                          .copyWith(color: ColorConstants.PRIMARY_50),
                    )
                  ],
                ).animate(delay: Duration(milliseconds: 500)).fadeIn(),
              ],
            ),
          ),
        ).animate().fadeIn(),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              Icons.settings,
              color: ColorConstants.PRIMARY_100,
            ),
            onPressed: () => context.push("/settings"),
          ),
        ),
      ],
    );
  }
}
