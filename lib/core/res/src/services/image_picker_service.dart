import 'package:image_picker/image_picker.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';

class ImagePickerService {

  final ImagePicker _picker;

  ImagePickerService(this._picker);

  Future<List<String>> pickMultipleImages(int maxLength) async {
    //!Note
    /// This package has issue that it's not prevent user
    /// from choosing maximum size we provide it enable user to choose
    /// any count and return only first n length so i replace it with
    /// the second package

    // final files = await _picker.pickMultiImage();
    // return files.map((e) => e.path).toList();

    try {
      final result =
          await MultipleImagesPicker.pickImages(maxImages: maxLength);
      final paths = <String>[];
      for (var element in result) {
        final path = await LecleFlutterAbsolutePath.getAbsolutePath(
            uri: element.identifier!);
        paths.add(path!);
      }

      return paths;
    } catch (e) {
      return [];
    }
  }
}
