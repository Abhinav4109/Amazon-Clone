import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/snackbar.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void addProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
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
          CloudinaryFile.fromFile(images[i].path, folder: name),
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
              Navigator.pop(context);
              showSnackBar(
                  context: context, content: 'Product Succefully Added!');
            },
            // ignore: use_build_context_synchronously
            context: context);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
