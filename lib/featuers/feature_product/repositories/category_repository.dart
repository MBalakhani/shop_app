import 'package:dio/dio.dart';

import '../../../error_handling/app_exception.dart';
import '../../../error_handling/check_exceptions.dart';
import '../../../resources/data_state.dart';
import '../data/data_source/category_api_provider.dart';
import '../data/models/categories_model.dart';

class CategoryRepository {
  CategoryApiProvider apiProvider;
  CategoryRepository(this.apiProvider);

  Future<DataState<CategoriesModel>> fetchCategoryData() async {
    try {
      Response response = await apiProvider.callCategories();
      final CategoriesModel categoriesModel =
          CategoriesModel.fromJson(response.data);
      return DataSuccess(categoriesModel);
    } on AppException catch (e) {
      return await CheckExceptions.getError(e);
    }
  }
}
