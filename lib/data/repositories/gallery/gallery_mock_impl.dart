import 'dart:io';

import 'package:tailor_made/domain.dart';

class GalleryMockImpl extends Gallery {
  @override
  Stream<List<ImageEntity>> fetchAll(String userId) async* {}

  @override
  FileStorageReference? createFile(File file, String userId) {
    return null;
  }
}
