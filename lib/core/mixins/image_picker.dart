import 'package:image_picker/image_picker.dart';

mixin ImagePickerMixin {
  Future<XFile?> pickImageFromGallery({ImageSource? source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source ?? ImageSource.gallery,
    );
    return image;
  }
}
