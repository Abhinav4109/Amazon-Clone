import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/widgets/address_bar.dart';
import 'package:amazon_clone/features/product_detail/screens/product_detail_screen.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widgets/searched_product.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.searchQuery});
  static const routeName = '/search-screen';
  final String searchQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices _searchServices = SearchServices();

  List<Product>? products;

  fetchSearchedProduct() async {
    products = await _searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  navigateToSearchScreen(String searchQuery) {
    Navigator.popAndPushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
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
      body: products == null
          ? const Loader()
          : Column(
              children: [
                const AddressBar(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, ProductDetailScreen.routeName,
                              arguments: products![index]);
                        },
                        child: SearchedProduct(product: products![index]),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
