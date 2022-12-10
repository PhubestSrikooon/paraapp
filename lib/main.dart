import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:paraapp2/theme_provider.dart';
import 'package:paraapp2/pages/display_picture_screen.dart';
import 'package:paraapp2/pages/resule_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParaApp',
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  var _isCameraReady = false;
  late XFile _imageFile;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isFlashOn = false;
  bool _isProcesss = false;

  @override
  void initState() {
    super.initState();
    initCamera();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _cameraController != null
          ? _initializeControllerFuture = _cameraController.initialize()
          : null;
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _isCameraReady = true;
    });
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController =
        CameraController(firstCamera, ResolutionPreset.veryHigh);
    _initializeControllerFuture = _cameraController.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      _isCameraReady = true;
    });
  }

  void FlashSet(bool flashstatus) {
    if (flashstatus) {
      _cameraController.setFlashMode(FlashMode.torch);
    } else {
      _cameraController.setFlashMode(FlashMode.off);
    }
  }

  captureImage(BuildContext context) async {
    if (_isProcesss) {
      return;
    } else {
      setState(() {
        _isProcesss = true;
        debugPrint("Processing");
      });
      await _cameraController
          .takePicture()
          .then((value) => {
                setState(() {
                  _imageFile = value;
                }),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(
                              imageFile: _imageFile,
                            )))
              })
          .catchError((onError) => {print(onError)});
    }
    setState(() {
      _isProcesss = false;
      debugPrint("Done");
    });
  }

  Widget cameraWidget(context) {
    // set the camera preview fit the screen
    var camera = _cameraController.value;
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * camera.aspectRatio;
    if (scale < 1) {
      scale = 1 / scale;
    }
    return Transform.scale(
      // make camera preview fit the screen
      scale: scale,
      child: Center(
        child: AspectRatio(
          aspectRatio: _cameraController.value.aspectRatio,
          child: CameraPreview(_cameraController),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: _drawer(context),
        body: FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SafeArea(
                  child: Stack(
                children: [
                  cameraWidget(context),
                  Positioned(
                      top: 0,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black, Colors.transparent])),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    scaffoldKey.currentState?.openDrawer();
                                  },
                                  color: Colors.white,
                                  icon: const Icon(Icons.menu)),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isFlashOn = !_isFlashOn;
                                      FlashSet(_isFlashOn);
                                    });
                                  },
                                  color: Colors.white,
                                  icon: _isFlashOn
                                      ? const Icon(Icons.flash_on)
                                      : const Icon(Icons.flash_off)),
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                      bottom: 0,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              )
                            ],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32))),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.all(4)),
                            RawMaterialButton(
                              onPressed: () async {
                                await captureImage(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RawMaterialButton(
                                    onPressed: () {
                                      null;
                                    },
                                    elevation: 2.0,
                                    fillColor:
                                        Theme.of(context).colorScheme.primary,
                                    padding: const EdgeInsets.all(15.0),
                                    shape: const CircleBorder(),
                                    child: _isProcesss
                                        // circular progress indicator loading
                                        ? CircularProgressIndicator(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          )
                                        : Icon(
                                            Icons.camera_alt,
                                            size: 35.0,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        _isProcesss ? "Processing" : "Scan",
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      Text(
                                        _isProcesss ? "..." : "Click to scan",
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(4))
                          ],
                        ),
                      ))
                ],
              ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

Drawer _drawer(BuildContext context) {
  return Drawer(
      child: ListView(
    children: [
      ListTile(
        leading: Icon(Icons.help),
        title: Text("Help"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.info),
        title: Text("About"),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Scaffold()));
        },
      )
    ],
  ));
}
