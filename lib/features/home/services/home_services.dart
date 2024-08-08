import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/snackbar.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<Product>> fetchCatogeryWiseProducts(
      BuildContext context, String catogery) async {
    List<Product> productList = [];
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.get(
        Uri.parse('$serverUri/getproduct/catogerywise?category=$catogery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
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

  dealoftheday({required BuildContext context}) async {
    Product product = Product(
      productName: '',
      discription: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res =
          await http.get(Uri.parse('$serverUri/api/highratedpro'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandling(
          res: res,
          onSucess: () {
            product = Product.fromJson(res.body);
          },
          // ignore: use_build_context_synchronously
          context: context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: e.toString());
    }
    return product;
  }
}
