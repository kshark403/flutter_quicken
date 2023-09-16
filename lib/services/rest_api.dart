// ignore_for_file: prefer_interpolation_to_compose_strings, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_scale/main.dart';
import 'package:flutter_scale/models/product_model.dart';
import 'package:flutter_scale/services/dio_config.dart';
import 'package:http_parser/http_parser.dart';

class CallAPI {
  // Create Dio Instance
  final Dio _dioWithAuth = DioConfig.dioWithAuth;
  final Dio _dio = DioConfig.dio;

  // Login API Method
  loginAPI(data) async {
    final response = await _dio.post('auth/login', data: data);
    // logger.d(response.data);
    return jsonEncode(response.data);
  }

  // Register API Method
  registerAPI(data) async {
    final response = await _dio.post('auth/register', data: data);
    // logger.d(response.data);
    return jsonEncode(response.data);
  }

  // ----------------------------------------
  // CRUD Product API Call Method
  // ----------------------------------------

  // Get All Product API Method
  Future<List<ProductModel>> getAllProducts() async {
    final response = await _dioWithAuth.get('products');
    if (response.statusCode == 200) {
      // logger.d(response.data);
      final List<ProductModel> products =
          productModelFromJson(json.encode(response.data));
      return products;
    }
    throw Exception('Failed to load products');
  }

  // Create Product API Method
  Future<String> addProductAPI(ProductModel product, {File? imageFile}) async {
    FormData data = FormData.fromMap({
      'name': product.name,
      'description': product.description,
      'barcode': product.barcode,
      'stock': product.stock,
      'price': product.price,
      'category_id': product.categoryId,
      'user_id': product.userId,
      'status_id': product.statusId,
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });

    final response = await _dioWithAuth.post('products', data: data);
    if (response.statusCode == 200) {
      // logger.d(response.data);
      return jsonEncode(response.data);
    }
    throw Exception('Failed to create product');
  }

  // Update Product API Method
  Future<String> updateProductAPI(ProductModel product,
      {File? imageFile}) async {
    FormData data = FormData.fromMap({
      'name': product.name,
      'description': product.description,
      'barcode': product.barcode,
      'stock': product.stock,
      'price': product.price,
      'category_id': product.categoryId,
      'user_id': product.userId,
      'status_id': product.statusId,
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });

    final response =
        await _dioWithAuth.put('products/${product.id}', data: data);
    if (response.statusCode == 200) {
      // logger.d(response.data);
      return jsonEncode(response.data);
    }
    throw Exception('Failed to update product');
  }

  // Delete Product API Method
  Future<String> deleteProductAPI(int id) async {
    final response = await _dioWithAuth.delete('products/$id');
    if (response.statusCode == 200) {
      // logger.d(response.data);
      return jsonEncode(response.data);
    }
    throw Exception('Failed to delete product');
  }
}
