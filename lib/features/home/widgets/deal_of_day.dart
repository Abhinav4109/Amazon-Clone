import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});
  @override
  State<DealOfDay> createState() => _DealOfDay();
}

class _DealOfDay extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const Text(
            'Deal of the day',
            style: TextStyle(fontSize: 20),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/macbook.png',
              height: 220,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            '\$100',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 2),
          const Text(
            'Macbook Air M2 2022',
            overflow: TextOverflow.ellipsis,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Image.asset('assets/images/macbook.png', width: 100, height: 70, fit: BoxFit.fitWidth),
                const SizedBox(width: 4),
                Image.asset('assets/images/macbook.png', width: 100, height: 70, fit: BoxFit.fitWidth),
                const SizedBox(width: 4),
                Image.asset('assets/images/macbook.png', width: 100, height: 70, fit: BoxFit.fitWidth),
                const SizedBox(width: 4),
                Image.asset('assets/images/macbook.png', width: 100, height: 70, fit: BoxFit.fitWidth),
              ],
            ),
          )
        ],
      ),
    );
  }
}
