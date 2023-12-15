import 'dart:io';

List<String> data = [];
void main() async {
  // Đường dẫn đến thư mục bạn muốn lấy danh sách tên file
  String folderPath = 'assets/icons/';

  // Gọi hàm lấy danh sách tên file
  List<String> fileNames = await getFileNamesInFolder(folderPath);

  // In danh sách tên file
  for (String fileName in fileNames) {
    if (!fileName.contains(r'^\.[a-zA-Z0-9]+')) {
      final r = snakeCase(fileName.substring(0, fileName.length - 3));
      data.add("static const String ic${r[0].toUpperCase()}${r.substring(1)} = 'assets/icons/$fileName';");
    }
  }
  final file = File('lib/common/constants/app_icons.dart');
  final isExists = await file.exists();
  if (!isExists) file.createSync(recursive: true);
  file.writeAsStringSync('abstract class AppIcons { \n', mode: FileMode.write);
  file.writeAsStringSync('\tconst AppIcons._();\n', mode: FileMode.writeOnlyAppend);
  file.writeAsStringSync('\n', mode: FileMode.writeOnlyAppend);
  file.writeAsStringSync(data.join('\n\t'), mode: FileMode.writeOnlyAppend);
  file.writeAsStringSync('\n}', mode: FileMode.writeOnlyAppend);
}

// Lấy tên file theo folder
Future<List<String>> getFileNamesInFolder(String folderPath) {
  Directory directory = Directory(folderPath);
  Stream<FileSystemEntity> entityList = directory.list();
  return entityList.where((entity) => entity is File).map((entity) => entity.path.split('/').last).toList();
}

// Convert file name sang icon name
String snakeCase(String text) {
  String a = text.toLowerCase().replaceAllMapped(RegExp(r'[-_\s.]+(.)?'), (match) {
    String? c = match.group(1);
    return c != null ? c.toUpperCase() : '';
  });
  return a.substring(0, 1).toLowerCase() + a.substring(1);
}
