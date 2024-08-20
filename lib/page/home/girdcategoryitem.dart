import 'package:flutter/material.dart';
import 'package:one_store/data/model/category_model.dart';
import '../categoryItem/categoryBook/booklistscreen.dart';

class GridItems extends StatelessWidget {
  final int index;

  GridItems(this.index);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookListScreen(
                  categoryId: categoriesGrid[index].categoryid,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(25),
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: const BoxDecoration(
              color: Color(0xFFF3B664),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
