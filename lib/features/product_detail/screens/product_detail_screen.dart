import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/product_detail/services/product_detail_services.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail-screen';
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailServices _productDetailsServices = ProductDetailServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  navigateToSearchScreen(String searchQuery) {
    Navigator.popAndPushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  addtocart() {
    _productDetailsServices.addToCart(
        context: context, product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          navigateToSearchScreen(value);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search Amazon.in',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(top: 9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    color: Colors.transparent,
                    height: 42,
                    child: const Icon(Icons.mic, color: Colors.black, size: 25),
                  ),
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(widget.product.id!), Stars(rating: avgRating)],
              ),
              const SizedBox(height: 35),
              Text(
                widget.product.productName,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CarouselSlider(
                  items: widget.product.images.map(
                    (i) {
                      return Builder(
                        builder: (BuildContext context) => Image.network(
                          i,
                          fit: BoxFit.contain,
                          height: 200,
                        ),
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 250,
                  ),
                ),
              ),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: RichText(
                  text: TextSpan(
                    text: 'Deal Price: ',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '\$${widget.product.price}',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(widget.product.discription),
              ),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomButton(
                  buttonText: 'Buy Now',
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: CustomButton(
                  buttonText: 'Add to Cart',
                  onPressed: () {
                    addtocart();
                  },
                  color: const Color.fromRGBO(254, 216, 19, 1),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'Rate The Product',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RatingBar.builder(
                initialRating: myRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: GlobalVariables.secondaryColor,
                ),
                onRatingUpdate: (rating) {
                  _productDetailsServices.rateProduct(
                    context: context,
                    product: widget.product,
                    rating: rating,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
