import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/screens/product_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  updatePage(page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    const ProductScreen(),
    const Center(child: Text('Admin Analytics')),
    const Center(child: Text('Admin Inbox'))
  ];

  double bottomBarBorderWidth = 5;
  double bottomBarWidth = 42;
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 120,
                  height: 45,
                  child: Image.asset('assets/images/amazon_in.png'),
                ),
                const Text(
                  'Admin',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          onTap: (value) {
            updatePage(value);
          },
          iconSize: 28,
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: _page == 0
                              ? GlobalVariables.selectedNavBarColor
                              : Colors.transparent,
                          width: bottomBarBorderWidth),
                    ),
                  ),
                  child: const Icon(Icons.home_outlined),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: _page == 1
                              ? GlobalVariables.selectedNavBarColor
                              : Colors.transparent,
                          width: bottomBarBorderWidth),
                    ),
                  ),
                  child: const Icon(Icons.analytics_outlined),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: _page == 2
                              ? GlobalVariables.selectedNavBarColor
                              : Colors.transparent,
                          width: bottomBarBorderWidth),
                    ),
                  ),
                  child: const Icon(Icons.all_inbox_outlined),
                ),
                label: '')
          ]),
    );
  }
}
