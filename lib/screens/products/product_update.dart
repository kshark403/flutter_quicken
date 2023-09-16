// ignore_for_file: unused_field, prefer_final_fields, avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_scale/models/product_model.dart';
import 'package:flutter_scale/screens/bottomnavpage/home_screen.dart';
import 'package:flutter_scale/screens/products/components/product_form.dart';
import 'package:flutter_scale/services/rest_api.dart';

class ProductUpdateScreen extends StatefulWidget {
  const ProductUpdateScreen({super.key});

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  // สร้างตัวแปรไว้เก็บค่าจากฟอร์ม
  final _formKey = GlobalKey<FormState>();

  // Model ข้อมูลสินค้า
  var _product = ProductModel(
      id: 0,
      name: null,
      description: null,
      barcode: null,
      stock: 0,
      price: 0,
      categoryId: 1,
      userId: 1,
      statusId: 1);

  // ไฟล์รูปภาพ
  File? _imageFile;

  Widget build(BuildContext context) {
    // รับค่า arguments ที่ส่งมาจากหน้าก่อนหน้า
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // set ค่าเริ่มต้นให้กับ Model
    _product.id = arguments['products']['id'];
    _product.name = arguments['products']['name'];
    _product.description = arguments['products']['description'];
    _product.barcode = arguments['products']['barcode'];
    _product.stock = arguments['products']['stock'];
    _product.price = arguments['products']['price'];
    _product.categoryId = arguments['products']['category_id'];
    _product.userId = arguments['products']['user_id'];
    _product.statusId = arguments['products']['status_id'];

    print(_product.toJson());

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Update product'),
        actions: [
          // Save Button
          IconButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // print('Form Validate');
                  // print(_product.toJson());
                  // print(_imageFile);

                  // Call API Add Product
                  var response = await CallAPI()
                      .updateProductAPI(_product, imageFile: _imageFile);

                  var body = jsonDecode(response);

                  if (body['status'] == 'ok') {
                    // ปิดหน้าจอและส่งค่ากลับไปยังหน้าก่อนหน้า
                    Navigator.pop(context, true);
                    Navigator.pop(context, true);

                    // อัพเดทข้อมูลใหม่ล่าสุด
                    refreshKey.currentState!.show();
                  }
                } else {
                  print('Form Not Validate');
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductForm(
              _product,
              callBackSetImage: _callBackSetImage,
              formKey: _formKey,
            ),
          ],
        ),
      ),
    );
  }

  void _callBackSetImage(File? imageFile) {
    setState(() {
      _imageFile = imageFile;
    });
  }

  void roductImageUpload(File? imageFile) {}
}
