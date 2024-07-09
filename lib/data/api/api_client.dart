import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop_bag_app/data/api/result.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/secrets/secret_constants.dart';

class ApiClient {
  Future<Object> getProduct({required String productId}) {
    return handleApiCall(
      () async {
        final response =
            await http.get(Uri.parse(getProductByIdUrl(productId)));

        if (response.statusCode != 200) {
          return Failure(message: 'Unable to get product');
        }

        return Success(
          data: Product.fromJson(
            jsonDecode(response.body),
          ),
        );
      },
    );
  }

  Future<Object> getListOfProducts() {
    return handleApiCall(
      () async {
        final response = await http.get(Uri.parse(getProductsUrl));

        if (response.statusCode != 200) {
          return Failure(message: 'Unable to get products');
        }


        final data = jsonDecode(response.body);

        final productsJson = data['items'] as List<dynamic>;

        return Success(
          data: productsJson
              .map(
                (e) => Product.fromJson(e),
              )
              .toList(),
        );
      },
    );
  }

  Future<Object> handleApiCall(Future<Object> Function() call) async {
    try {
      return await call();
    } on HttpException {
      log('HttpException');

      return Failure(message: 'No Internet');
    } on FormatException catch (e) {
      log('$e');

      return Failure(message: 'Invalid input');
    } on SocketException {
      log('SocketException');

      return Failure(message: 'Internet error');
    } on TimeoutException {
      log('TimeoutException');

      return Failure(message: 'Request Timed out');
    } catch (e) {
      log('$e');

      return Failure(message: 'Unknown error');
    }
  }
}
