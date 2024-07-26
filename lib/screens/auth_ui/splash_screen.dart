import 'package:customer_product_management_system/controllers/get_user_data_controller.dart';
import 'package:customer_product_management_system/screens/admin_panel/admin_main_screen.dart';
import 'package:customer_product_management_system/screens/auth_ui/welcome_screen.dart';
import 'package:customer_product_management_system/screens/customer_panel/main_screen.dart';
import 'package:customer_product_management_system/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), (){
      loggedIn(context);
    });
  }
  
  Future<void> loggedIn(BuildContext context) async{
    if(user != null){
      final GetUserDataController getUserDataController = Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);
      
      if(userData[0]['isAdmin']){
        Get.offAll(()=> const AdminMainScreen());
      }else{
        Get.offAll(()=> const MainScreen());
        
      }
    }else{
      Get.to(()=>const WelcomeScreen());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appSecondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Get.width,
            alignment: Alignment.center,
            child: Lottie.asset('assets/images/splash-icon.json'),
          )
        ],
      ),
    );
  }
}
