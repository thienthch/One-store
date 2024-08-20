import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:one_store/data/model/category_model.dart';
import 'package:one_store/data/model/product_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'homescreen.dart';

Widget buildImage(String urlImage, int index, BoxFit fit) => Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      // color: Colors.grey,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          urlImage,
          fit: fit, // Thêm cách hình ảnh được hiển thị trong khung
        ),
      ),
    );

class GridItems extends StatelessWidget {
  final int index;

  GridItems(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          color: Color(0xFFF3B664),
          // boxShadow: [
          //   BoxShadow(
          //     color: Color(0xFFFFFFFF),
          //     blurRadius: 1,
          //     offset: Offset(4.5, 4.5),k
          //   ),
          // ],
          // border: Border.all(color: Colors.orange, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        children: [
          Image(
            image: AssetImage(
                "assets/image/category/${categoriesGrid[index].imageUrl}"),
          ),
          const SizedBox(height: 19),
          Text(
            categoriesGrid[index].name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class GridProductItems extends StatelessWidget {
  final int index;

  GridProductItems(this.index);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        decoration: const BoxDecoration(
          color: Color(0xFFF3B664),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image(
                image: AssetImage(
                    "assets/image/book/${productsGrid[index].imageUrl}"),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 19),
            // Text(
            //   productsGrid[index].name,
            //   style: const TextStyle(
            //     color: Colors.white,
            //     fontSize: 5,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
          ],
        ),
      ),
    );
  }
}
