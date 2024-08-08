import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/accounts/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/product-screen';
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final AdminServices _adminServices = AdminServices();
  List<Product>? products;
  void navigateToAddProduct() {
    Navigator.of(context).pushNamed(AddProductScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  fetchProduct() async {
    products = await _adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    _adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: products!.length,
                itemBuilder: ((context, index) {
                  final productData = products![index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Column(
                      children: [
                        SingleProduct(
                          image: productData.images[0],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                productData.productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteProduct(productData, index);
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                })),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateToAddProduct();
              },
              tooltip: 'Add a product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
