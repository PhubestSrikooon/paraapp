import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

class Classification {
  Future<void> loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  Future<dynamic> classifyImage(XFile imagePath) async {
    var output = await Tflite.runModelOnImage(
        path: imagePath.path,
        numResults: 1,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    return output;
  }
}
