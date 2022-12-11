// import 'package:tflite/tflite.dart';

// class classification {
//   final imagePath;
//   classification({this.imagePath});

//   Future<void> classifyImage() async {
//     var output = await Tflite.runModelOnImage(
//       path: imagePath,
//       imageMean: 127.5,
//       imageStd: 127.5,
//       numResults: 2,
//       threshold: 0.5,
//       asynch: true,
//     );
//     print(output);
//   }
// }
