import 'package:get/get.dart';

import '../data/models/remark_product_list_model.dart';
import '../data/service/network_caller.dart';
import '../data/utilities/urls.dart';

class NewProductController extends GetxController{
  //RemarkProductController({required this.remark});
  // String remark;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  ProductListModel _remarkProductModel=ProductListModel();
  ProductListModel get remarkProductModel=>_remarkProductModel;

  Future<bool> getNewProduct() async {
    _isLoading = true;
    update();
    final response = await NetWorkCaller().getRequest(Urls.newProductUrl);
    _isLoading = false;
    if (response.isSuccess) {
      _remarkProductModel = ProductListModel.fromJson(response.responseData);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}