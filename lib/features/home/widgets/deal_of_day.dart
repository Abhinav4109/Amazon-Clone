import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});
  @override
  State<DealOfDay> createState() => _DealOfDay();
}

class _DealOfDay extends State<DealOfDay> {
  final HomeServices _homeServices = HomeServices();
  Product? product;
  @override
  void initState() {
    super.initState();
    dealofday();
  }

  dealofday() async {
    product = await _homeServices.dealoftheday(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.productName.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product!.productName,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.network(
                        product!.images[0],
                        height: 220,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$${product!.price}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product!.discription,
                      overflow: TextOverflow.ellipsis,
                    ),
                    product!.images.length == 1
                        ? const SizedBox()
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: product!.images
                                  .map(
                                    (e) => Image.network(
                                      e,
                                      fit: BoxFit.fitWidth,
                                      width: 100,
                                      height: 100,
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                  ],
                ),
              );
  }
}
