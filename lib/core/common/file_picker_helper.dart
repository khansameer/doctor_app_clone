import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class FilePickerHelper {
  // This method checks for permissions and opens the file picker
  static Future<FilePickerResult?> pickFile({List<String>? allowedExtensions}) async {
    // Check if the platform is Android or iOS
    if (!kIsWeb) {
      // Check if not web
      // Request storage permissions for Android and iOS
      var status = await Permission.storage.request();

      // Check if the permission is granted
      if (!status.isGranted) {
        if (kDebugMode) {
          print('Storage permission is denied.');
        }
        return null;
      }
    }

    // Open the file picker
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions:allowedExtensions?? ['jpg', 'pdf', 'doc'],
    );
    // Check if the user picked a file
    if (result != null) {

      if(kIsWeb){

        return result;
       // result?.files.first.bytes
      }
      if (kDebugMode) {
        print('');
      }
      // Return the path of the selected file
      return result;
    }

    // Return null if no file was picked
    return null;
  }
}
