
import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductService {
  final Dio dio = Dio();

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await dio.get(
        'https://fakestoreapi.com/products',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data ?? e.message ?? 'Something went wrong',
      );
    }
  }
}
