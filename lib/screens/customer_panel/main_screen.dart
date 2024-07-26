import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../utils/app_constant.dart';
import '../../widgets/all_products_widgets.dart';
import '../../widgets/banner_widget.dart';
import '../../widgets/category_widget.dart';
import '../../widgets/custom_drawer_widget.dart';
import '../../widgets/flash_sale_widget.dart';
import '../../widgets/heading_widget.dart';
import 'all_categories_screen.dart';
import 'all_flash_sale_products.dart';
import 'all_products_screen.dart';
import 'cart_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppConstant.appSecondaryColor,
            statusBarIconBrightness: Brightness.light),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: const TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => const CartScreen()),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 90.0,
            ),
            //banners
            const BannerWidget(),

            //heading
            HeadingWidget(
              headingTitle: "Categories",
              headingSubTitle: "According to your budget",
              onTap: () => Get.to(() => const AllCategoriesScreen()),
              buttonText: "See More >",
            ),

            const CategoriesWidget(),

            //heading
            HeadingWidget(
              headingTitle: "Flash Sale",
              headingSubTitle: "According to your budget",
              onTap: () => Get.to(() => const AllFlashSaleProductScreen()),
              buttonText: "See More >",
            ),

            const FlashSaleWidget(),

            //heading
            HeadingWidget(
              headingTitle: "All Products",
              headingSubTitle: "According to your budget",
              onTap: () => Get.to(() => const AllProductsScreen()),
              buttonText: "See More >",
            ),

            const AllProductsWidget(),
          ],
        ),
      ),
    );
  }
}