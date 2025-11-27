import 'package:ecommerce_web_app/views/sidebar_screens/banner_screen.dart';
import 'package:ecommerce_web_app/views/sidebar_screens/buyer_screen.dart';
import 'package:ecommerce_web_app/views/sidebar_screens/category_screen.dart';
import 'package:ecommerce_web_app/views/sidebar_screens/order_screen.dart';
import 'package:ecommerce_web_app/views/sidebar_screens/product_screen.dart';
import 'package:ecommerce_web_app/views/sidebar_screens/subCategory_screen.dart';
import 'package:ecommerce_web_app/views/sidebar_screens/vendor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = VendorScreen();

  screenSelector(item) {
    switch (item.route) {
      case VendorScreen.id:
        setState(() {
          _selectedScreen = VendorScreen();
        });

        break;

      case BuyerScreen.id:
        setState(() {
          _selectedScreen = BuyerScreen();
        });

        break;

      case ProductScreen.id:
        setState(() {
          _selectedScreen = ProductScreen();
        });

        break;

      case BannerScreen.id:
        setState(() {
          _selectedScreen = BannerScreen();
        });

        break;

      case CategoryScreen.id:
        setState(() {
          _selectedScreen = CategoryScreen();
        });

        break;
         case SubcategoryScreen.id:
        setState(() {
          _selectedScreen = SubcategoryScreen();
        });

        break;

      case OrderScreen.id:
        setState(() {
          _selectedScreen = OrderScreen();
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Management"),
      ),
      body: _selectedScreen,

      sideBar: SideBar(
        header: Container(
          height: 85,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          child: Center(child: Text("Multi Vendor Admin",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.7
          )),),
        ),
        items: const [
          AdminMenuItem(
            title: 'Vendors',
            route: VendorScreen.id,
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'Buyers',
            route: BuyerScreen.id,
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: OrderScreen.id,
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Category',
            route: CategoryScreen.id,
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: 'SubCategory',
            route: SubcategoryScreen.id,
            icon: Icons.category_outlined,
          ),
          AdminMenuItem(
            title: 'Upload Banner',
            route: BannerScreen.id,
            icon: CupertinoIcons.upload_circle,
          ),
          AdminMenuItem(
            title: 'Products',
            route: ProductScreen.id,
            icon: CupertinoIcons.shopping_cart,
          ),
        ],
        selectedRoute: VendorScreen.id,
        onSelected: (item) {
          screenSelector(item);
        },
      ),
    );
  }
}
