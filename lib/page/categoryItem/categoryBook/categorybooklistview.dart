import 'package:flutter/material.dart';
import '../../../data/model/category_book_model.dart'; // Thay thế bằng tên file chứa model của bạn

class CategoryBookListView extends StatelessWidget {
  final List<CategoryBookModel> categories;
  final Function(CategoryBookModel) onCategorySelected;
  final String selectedCategoryId;

  CategoryBookListView({
    required this.categories,
    required this.onCategorySelected,
    required this.selectedCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45, // Bạn có thể điều chỉnh chiều cao theo ý muốn
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onCategorySelected(
                  categories[index]); // Gọi hàm callback khi danh mục được nhấn
            },
            child: Container(
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: categories[index].categoryBookid == selectedCategoryId
                    ? Color(0xFFF1EB90) // Highlight the selected category
                    : Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  categories[index].name,
                  style: TextStyle(
                    color: categories[index].categoryBookid ==
                            selectedCategoryId
                        ? Colors
                            .black // Change text color for selected category
                        : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
