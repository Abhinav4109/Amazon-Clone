import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/accounts/screens/account_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const routeName = '/actual-name';
  const BottomBar({super.key});
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(child: Text('Cart Screen'),)
  ];
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          backgroundColor: GlobalVariables.backgroundColor,
          iconSize: 28,
          onTap: (page)=> updatePage(page),
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: bottomBarBorderWidth,
                          color: _page == 0
                              ? GlobalVariables.selectedNavBarColor
                              : Colors.transparent),
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
                          width: bottomBarBorderWidth,
                          color: _page == 1
                              ? GlobalVariables.selectedNavBarColor
                              : Colors.transparent),
                    ),
                  ),
                  child: const Icon(Icons.person_outlined),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: SizedBox(
                  width: bottomBarWidth,
                  child: badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -13, end: -3),
                    badgeContent:  Text(userCartLen.toString(), style: const TextStyle(color: Colors.white),),
                    badgeStyle:
                        badges.BadgeStyle(badgeColor: GlobalVariables.selectedNavBarColor),
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                ),
                label: '')
          ]),
    );
  }
}
