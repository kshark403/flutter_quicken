// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/components/image_not_found.dart';
import 'package:flutter_scale/screens/bottomnavpage/home_screen.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/utils/constants.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    // รับค่า arguments ที่ส่งมาจากหน้าก่อนหน้า
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // print(arguments);

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(arguments['products']['name']),
      ),
      body: ListView(
        children: [
          arguments['products']['image'] != null
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          baseURLImage + arguments['products']['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ImageNotFound(),
                ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              arguments['products']['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Text(
              'Barcode:' + arguments['products']['barcode'],
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              arguments['products']['description'],
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.productUpdate,
                          arguments: {'products': arguments['products']});
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () async {
                      // logger.i('Delete product id: ${arguments['products']['id']}');
                      // Confirm dialog
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Delete'),
                              content: Text(
                                  'Are you sure you want to delete this product?'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () async {
                                    // Call API Delete Product
                                    var response = await CallAPI()
                                        .deleteProductAPI(
                                            arguments['products']['id']);

                                    var body = jsonDecode(response);

                                    if (body['status'] == 'ok') {
                                      // ปิดหน้าจอและส่งค่ากลับไปยังหน้าก่อนหน้า
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();

                                      // Refresh Home Screen
                                      refreshKey.currentState!.show();
                                    }
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
