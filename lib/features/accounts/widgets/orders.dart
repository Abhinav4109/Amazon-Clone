import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/accounts/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Your Orders',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              Text('See all',
                  style: TextStyle(
                      color: GlobalVariables.selectedNavBarColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400))
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 170,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: ((context, index) {
                  return const SingleProduct();
                })),
          )
        ],
      ),
    );
  }
}
