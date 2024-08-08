import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class CatogeryDealsScreen extends StatefulWidget {
  static const routeName = '/catogery-screen';
  final String catogery;
  const CatogeryDealsScreen({super.key, required this.catogery});

  @override
  State<CatogeryDealsScreen> createState() => _CatogeryDealsScreenState();
}

class _CatogeryDealsScreenState extends State<CatogeryDealsScreen> {
  List<Product>? productsList;
  final HomeServices _homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProduct();
  }

  fetchCategoryProduct() async {
    productsList =
        await _homeServices.fetchCatogeryWiseProducts(context, widget.catogery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(
            widget.catogery,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: productsList == null
          ? const Loader()
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Keep shopping for ${widget.catogery}',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 170,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productsList!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.4,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final product = productsList![index];
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(
                                      product.images[0],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  product.productName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
