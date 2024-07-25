import 'package:customer_product_management_system/utils/app_constant.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstant.appMainName,style: TextStyle(color: AppConstant.appTextColor),),
        backgroundColor: AppConstant.appMainColor,

      )
    );
  }
}
