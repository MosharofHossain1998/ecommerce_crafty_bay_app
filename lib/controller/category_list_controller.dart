import 'package:get/get.dart';

import '../data/models/category_list_model.dart';
import '../data/service/network_caller.dart';
import '../data/utilities/urls.dart';
class CategotyListController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  CategoryListModel _categoryListModel = CategoryListModel();
  CategoryListModel get categoryListModel => _categoryListModel;

  Future<bool> getCategoryList() async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller().getRequest(Urls.categoryListUrl);
    _isLoading = false;
    if (response.isSuccess) {
      _categoryListModel = CategoryListModel.fromJson(response.responseData);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
