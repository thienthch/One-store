import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:one_store/data/model/category_model.dart';
import 'package:one_store/data/model/product_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'homescreen.dart';

class GridProductItems extends StatelessWidget {
  final int index;

  GridProductItems(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        children: [
          Image(
            height: 130,
            image:
                AssetImage("assets/image/book/${productsGrid[index].imageUrl}"),
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              productsGrid[index].name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${productsGrid[index].price} VND',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
