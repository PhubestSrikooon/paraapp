import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:paraapp/elements/camera_widget.dart';
import 'package:provider/provider.dart';
import 'package:paraapp/pages/result_screen.dart';
import 'package:paraapp/pages/setting_screen.dart';

class main_screen extends StatefulWidget {
  const main_screen({super.key});

  @override
  State<main_screen> createState() => _main_screenState();
}

class _main_screenState extends State<main_screen> {
  bool showBottomMenu = false;
  ValueNotifier<bool> flashlight = ValueNotifier(false);

  late Camera _camera;

  @override
  void initState() {
    _camera = Camera(
      context: context,
    );
    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      drawer: _drawer(context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            _camera,
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
                                flashlight = ValueNotifier(!flashlight.value);
                                if (flashlight.value) {
                                  _camera.setFlashMode(FlashMode.always);
                                } else {
                                  _camera.setFlashMode(FlashMode.off);
                                }
                              });
                              debugPrint(flashlight.value.toString());
                            },
                            color: Colors.white,
                            icon: flashlight.value
                                ? const Icon(Icons.flash_on)
                                : const Icon(Icons.flash_off)),
                        ElevatedButton(
                            onPressed: () {
                              null;
                            },
                            child: const Text('HiX'))
                      ],
                    ),
                  ),
                )),
            bottomSheet(context, _camera)
          ],
        ),
      ),
    ));
  }
}

ElevatedButton square(Icon icon, String text) {
  return ElevatedButton(
      onPressed: () {
        null;
      },
      child: Row(
        children: [icon, Text(text)],
      ));
}

///////////////////////// fixed layout ///////////////////////////////////////////
Drawer _drawer(BuildContext context) {
  return Drawer(
      child: ListView(
    children: [
      ListTile(
        leading: Icon(Icons.settings),
        title: Text("Setting"),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SettingPage(context: context)));
        },
      ),
      ListTile(
        leading: Icon(Icons.help),
        title: Text("Help"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.info),
        title: Text("About"),
        onTap: () {},
      )
    ],
  ));
}

Positioned bottomSheet(BuildContext context, Camera camera) {
  return Positioned(
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
                offset: const Offset(0, 3), // changes position of shadow
              )
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32))),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(4)),
            RawMaterialButton(
              onPressed: () {
                queryResult(context);
                // camera.captureImage();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      null;
                    },
                    elevation: 2.0,
                    fillColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 35.0,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Scan',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        "Click here to scan the para.",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(4))
          ],
        ),
      ));
}
