import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CalculateProductRatingController extends GetxController {
  final String productId;
  RxDouble averageRating = 0.0.obs;

  CalculateProductRatingController(this.productId);

  @override
  void onInit() {
    super.onInit();
    calculateAverageRating();
  }

  void calculateAverageRating() {
    FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .collection('review')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        double totalRating = 0;
        int numberOfReviews = 0;
        for (var doc in snapshot.docs) {
          final ratingAsString = doc['rating'] as String;
          // Convert string rating to double
          final rating = double.tryParse(ratingAsString);
          if (rating != null) {
            totalRating += rating;
            numberOfReviews++;
          }
        }
        if (numberOfReviews != 0) {
          averageRating.value = totalRating / numberOfReviews;
        } else {
          averageRating.value = 0.0;
        }
      } else {
        averageRating.value = 0.0;
      }
    });
  }
}