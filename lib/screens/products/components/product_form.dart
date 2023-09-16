// ignore_for_file: dead_code, prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_scale/models/product_model.dart';
import 'package:flutter_scale/screens/products/components/product_image.dart';

class ProductForm extends StatefulWidget {
  final ProductModel product;
  final Function(File? file) callBackSetImage;
  final GlobalKey<FormState> formKey;

  const ProductForm(
    this.product, {
    required this.callBackSetImage,
    required this.formKey,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            SizedBox(height: _spacing),
            _buildNameInput(),
            SizedBox(height: _spacing),
            _buildBarcodeInput(),
            SizedBox(height: _spacing),
            _buildDescriptionInput(),
            SizedBox(height: _spacing),
            Row(
              children: [
                Flexible(
                  child: _buildPriceInput(),
                ),
                SizedBox(width: _spacing),
                Flexible(
                  child: _buildStockInput(),
                ),
              ],
            ),
            SizedBox(height: _spacing),
            Row(children: [
              Flexible(
                child: _buildCategoryIdInput(),
              ),
              SizedBox(width: _spacing),
              Flexible(
                child: _buildUserIdInput(),
              ),
              SizedBox(width: _spacing),
              Flexible(
                child: _buildStatusIdInput(),
              ),
            ]),
            ProductImage(
              widget.callBackSetImage,
              image: widget.product.image,
            ),
            SizedBox(height: _spacing),
          ],
        ),
      ),
    );
  }

  // Style input
  InputDecoration _inputStyle(String label) => InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        errorText: false ? 'Value Can\'t Be Empty' : null,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
        labelText: label,
      );

  // Name
  TextFormField _buildNameInput() => TextFormField(
        initialValue: widget.product.name,
        decoration: _inputStyle('name'),
        validator: (value) => value!.isEmpty ? 'Please enter name' : null,
        onSaved: (String? value) {
          widget.product.name = value ?? "";
        },
      );

  // Description with multi line
  TextFormField _buildDescriptionInput() => TextFormField(
        initialValue: widget.product.description,
        decoration: _inputStyle('description'),
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        onSaved: (String? value) {
          widget.product.description = value ?? "";
        },
      );

  // Barcode number only
  TextFormField _buildBarcodeInput() => TextFormField(
        initialValue: widget.product.barcode,
        decoration: _inputStyle('barcode'),
        keyboardType: TextInputType.number,
        validator: (value) => value!.isEmpty ? 'Please enter barcode' : null,
        onSaved: (String? value) {
          widget.product.barcode = value ?? "";
        },
      );

  // Price
  TextFormField _buildPriceInput() => TextFormField(
        initialValue: widget.product.price.toString(),
        decoration: _inputStyle('price'),
        keyboardType: TextInputType.number,
        validator: (value) => value!.isEmpty ? 'Please enter price' : null,
        onSaved: (String? value) {
          var price = 0;
          if (value != null && value.isNotEmpty) {
            price = int.parse(value);
          }
          widget.product.price = price;
        },
      );

  // Stock
  TextFormField _buildStockInput() => TextFormField(
        initialValue: widget.product.stock.toString(),
        decoration: _inputStyle('stock'),
        keyboardType: TextInputType.number,
        validator: (value) => value!.isEmpty ? 'Please enter stock' : null,
        onSaved: (String? value) {
          var stock = 0;
          if (value != null && value.isNotEmpty) {
            stock = int.parse(value);
          }
          widget.product.stock = stock;
        },
      );

  // Category id number
  TextFormField _buildCategoryIdInput() => TextFormField(
        initialValue: widget.product.categoryId.toString(),
        decoration: _inputStyle('category id'),
        keyboardType: TextInputType.number,
        validator: (value) =>
            value!.isEmpty ? 'Please enter category id' : null,
        onSaved: (String? value) {
          var categoryId = 1;
          if (value != null && value.isNotEmpty) {
            categoryId = int.parse(value);
          }
          widget.product.categoryId = categoryId;
        },
      );

  // userId number
  TextFormField _buildUserIdInput() => TextFormField(
        initialValue: widget.product.userId.toString(),
        decoration: _inputStyle('user id'),
        keyboardType: TextInputType.number,
        validator: (value) => value!.isEmpty ? 'Please enter user id' : null,
        onSaved: (String? value) {
          var userId = 1;
          if (value != null && value.isNotEmpty) {
            userId = int.parse(value);
          }
          widget.product.userId = userId;
        },
      );

  // statusId number
  TextFormField _buildStatusIdInput() => TextFormField(
        initialValue: widget.product.statusId.toString(),
        decoration: _inputStyle('status id'),
        keyboardType: TextInputType.number,
        validator: (value) => value!.isEmpty ? 'Please enter status id' : null,
        onSaved: (String? value) {
          var statusId = 1;
          if (value != null && value.isNotEmpty) {
            statusId = int.parse(value);
          }
          widget.product.statusId = statusId;
        },
      );
}
