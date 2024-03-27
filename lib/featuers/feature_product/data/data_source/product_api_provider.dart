import 'package:dio/dio.dart';
import '../../../../config/constants.dart';
import '../../../../error_handling/check_exceptions.dart';
import '../../../../params/products_params.dart';

class ProductsApiProvider {
  Dio dio;
  ProductsApiProvider(this.dio);

  dynamic callAllProducts(ProductsParams productsParams) async {
    try {
      final response = await dio.post(
        "${Constants.baseUrl}/products",
        data: {
          "start": productsParams.start,
          "step": productsParams.step,
          "categories": productsParams.categories,
          "maxPrice": productsParams.maxPrice,
          "minPrice": productsParams.minPrice,
          "sortby": productsParams.sortBy,
          'search': productsParams.search
        },
      );

      return response;
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }
}
