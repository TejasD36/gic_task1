import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import '../../controllers/cart_price_controller.dart';
import '../../modals/cart_modal.dart';
import '../../utils/app_constant.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
  Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text('Cart Screen',style: TextStyle(color: AppConstant.appTextColor),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid)
            .collection('cartOrders')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: Get.height / 5,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No products found!"),
            );
          }

          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                CartModal cartModal = CartModal(
                  productId: productData['productId'],
                  categoryId: productData['categoryId'],
                  productName: productData['productName'],
                  categoryName: productData['categoryName'],
                  salePrice: productData['salePrice'],
                  fullPrice: productData['fullPrice'],
                  productImages: productData['productImages'],
                  deliveryTime: productData['deliveryTime'],
                  isSale: productData['isSale'],
                  productDescription: productData['productDescription'],
                  createdAt: productData['createdAt'],
                  updatedAt: productData['updatedAt'],
                  productQuantity: productData['productQuantity'],
                  productTotalPrice: double.parse(
                      productData['productTotalPrice'].toString()),
                );

                //calculate price
                productPriceController.fetchProductPrice();
                return SwipeActionCell(
                  key: ObjectKey(cartModal.productId),
                  trailingActions: [
                    SwipeAction(
                      title: "Delete",
                      forceAlignmentToBoundary: true,
                      performsFirstActionWithFullSwipe: true,
                      onTap: (CompletionHandler handler) async {

                        await FirebaseFirestore.instance
                            .collection('cart')
                            .doc(user!.uid)
                            .collection('cartOrders')
                            .doc(cartModal.productId)
                            .delete();

                      },
                    )
                  ],
                  child: Card(
                    elevation: 5,
                    color: AppConstant.appTextColor,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appMainColor,
                        backgroundImage:
                        NetworkImage(cartModal.productImages[0]),
                      ),
                      title: Text(cartModal.productName),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(cartModal.productTotalPrice.toString()),
                          SizedBox(
                            width: Get.width / 20.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (cartModal.productQuantity > 1) {
                                await FirebaseFirestore.instance
                                    .collection('cart')
                                    .doc(user!.uid)
                                    .collection('cartOrders')
                                    .doc(cartModal.productId)
                                    .update({
                                  'productQuantity':
                                  cartModal.productQuantity - 1,
                                  'productTotalPrice':
                                  (double.parse(cartModal.fullPrice) *
                                      (cartModal.productQuantity - 1))
                                });
                              }
                            },
                            child: const CircleAvatar(
                              radius: 14.0,
                              backgroundColor: AppConstant.appMainColor,
                              child: Text('-'),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 20.0,
                            child: Text("  ${cartModal.productQuantity}"),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (cartModal.productQuantity > 0) {
                                await FirebaseFirestore.instance
                                    .collection('cart')
                                    .doc(user!.uid)
                                    .collection('cartOrders')
                                    .doc(cartModal.productId)
                                    .update({
                                  'productQuantity':
                                  cartModal.productQuantity + 1,
                                  'productTotalPrice':
                                  double.parse(cartModal.fullPrice) +
                                      double.parse(cartModal.fullPrice) *
                                          (cartModal.productQuantity)
                                });
                              }
                              // else if(cartModal.productQuantity == 0){
                              //   await FirebaseFirestore.instance
                              //       .collection('cart')
                              //       .doc(user!.uid)
                              //       .collection('cartOrders')
                              //       .doc(cartModal.productId)
                              //       .update({
                              //     'productQuantity': '0',
                              //     'productTotalPrice': '0'
                              //   });
                              // }
                            },
                            child: const CircleAvatar(
                              radius: 14.0,
                              backgroundColor: AppConstant.appMainColor,
                              child: Text('+'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
                  () => Text(
                " Total Rs. ${productPriceController.totalPrice.value.toStringAsFixed(1)} /-",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: Container(
                  width: Get.width / 2.0,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: AppConstant.appSecondaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextButton(
                    child: const Text(
                      "Checkout",
                      style: TextStyle(color: AppConstant.appTextColor),
                    ),
                    onPressed: () {
                      Get.to(() => const CheckOutScreen());
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}