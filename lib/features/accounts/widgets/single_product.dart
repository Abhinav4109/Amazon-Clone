import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black12,
              width: 1.5,
            )),
        width: 180,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset(
            "assets/images/macbook.png",
          ),
        ),
      ),
    );
  }
}
