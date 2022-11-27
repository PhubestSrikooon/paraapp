import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:paraapp/providers/providers.dart';
import 'package:permission_handler/permission_handler.dart';

class Camera extends StatefulWidget {
  final BuildContext context;
  Camera({super.key, required this.context});

  _CameraState st1 = _CameraState();
  @override
  State<Camera> createState() => st1;

  void setFlashMode(FlashMode mode) {
    st1.toggleFlash(mode);
    debugPrint(mode.toString());
    st1.setState(() {});
  }

  void captureImage() {
    st1.takePicture();
  }
}

class _CameraState extends State<Camera> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  String s1 = "Wow";

  bool _isCameraPermissionGranted = false;
  bool _isCameraInitialized = false;

  getPermissionStatus() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;
    if (status.isGranted) {
      debugPrint('Camera Permission: GRANTED');
      setState(() {
        _isCameraPermissionGranted = true;
      });
    } else {
      debugPrint('Camera Permission: DENIED');
    }
  }

  @override
  void initState() {
    getPermissionStatus();
    startCamera();
    super.initState();
  }

  void toggleFlash(FlashMode flashMode) {
    cameraController.setFlashMode(flashMode);
  }

  void takePicture() {
    cameraController.takePicture().then((value) {
      debugPrint(value.path);
    });
  }

  void startCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.ultraHigh,
        enableAudio: false);

    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = cameraController.value.isInitialized;
      });
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCameraInitialized && _isCameraPermissionGranted) {
      return SizedBox(
          width: MediaQuery.of(this.context).size.width,
          height: MediaQuery.of(this.context).size.height,
          child: CameraPreview(cameraController));
    } else {
      return SizedBox(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                "This application require permission to acess the camera"),
            ElevatedButton(
              onPressed: () {
                getPermissionStatus();
                startCamera();
                debugPrint(
                    '${_isCameraInitialized.toString()} ${_isCameraPermissionGranted}');
              },
              child: Text("Give Permission"),
            ),
            const Text(
                "After allow permission restart the application is require"),
          ],
        )),
      );
    }
  }
}
