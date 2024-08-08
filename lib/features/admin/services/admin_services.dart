import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/snackbar.dart';
import 'package:amazon_clone/features/admin/screens/product_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void addProduct({
    required BuildContext context,
    required String name,
    required String description,
    required int price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dz5uulicj', 'vij76bv5');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          // from list, getting the path of each element (file)
          CloudinaryFile.fromFile(images[i].path, folder: 'product/$name'),
        );
        imageUrls.add(res.secureUrl);
        Product product = Product(
          productName: name,
          discription: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price,
        );
        http.Response apiRes =
            await http.post(Uri.parse('$serverUri/admin/add-product'),
                headers: {
                  'Content-Type': 'application/json; charset=UTF-8',
                  'x-auth-token': userProvider.user.token,
                },
                body: product.toJson());
        httpErrorHandling(
            res: apiRes,
            onSucess: () {
              Navigator.of(context).pushNamed(ProductScreen.routeName);
              showSnackBar(
                  context: context, content: 'Product Succefully Added!');
            },
            // ignore: use_build_context_synchronously
            context: context);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    List<Product> productList = [];
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res =
          await http.get(Uri.parse('$serverUri/admin-get-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      // ignore: use_build_context_synchronously
      httpErrorHandling(
          res: res,
          onSucess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          },
          // ignore: use_build_context_synchronously
          context: context);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return productList;
  }

  deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$serverUri/admin-delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandling(
        res: res,
        // ignore: use_build_context_synchronously
        context: context,
        onSucess: () {
          onSuccess();
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: e.toString());
    }
  }
}
