import 'package:wiliams/Plugins/get/get.dart';
import 'package:wiliams/Widgets/form_utils.dart';

class TempImageModel {
  final RxBool isLoading = false.obs;
  String title;
  String path = "";

  TempImageModel({required this.title,required this.path,});
}

class TempVideoModel {
  final RxBool isLoading = false.obs;
  String path;
  String coverPath;

  final MyTextController details = MyTextController();

  TempVideoModel(
    this.coverPath,
    this.path,
  );
}
