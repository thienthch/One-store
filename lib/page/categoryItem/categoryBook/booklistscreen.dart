import 'package:flutter/material.dart';
import 'package:one_store/data/model/product_model.dart';
import 'package:one_store/page/product/productdetailscreen.dart';
import 'package:one_store/data/model/category_book_model.dart';
import 'categorybooklistview.dart';
import 'productgridlistbook.dart';
import 'filter.dart';

class BookListScreen extends StatefulWidget {
  final String categoryId;

  BookListScreen({required this.categoryId});

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<ProductModel> filteredProducts = [];
  String selectedCategoryId = '';
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    filterProducts(selectedCategoryId);
  }

  void filterProducts(String categoryId) {
    setState(() {
      selectedCategoryId = categoryId;
      if (categoryId.isEmpty) {
        filteredProducts = productsGrid;
      } else {
        filteredProducts = productsGrid
            .where((product) => product.categoryBook == categoryId)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryBookModel> categories = [
      CategoryBookModel(categoryBookid: '', name: 'Tất cả'),
      ...categoryBookGrid,
    ];
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Filter(
        onFilterSelected: (int selectedFilter) {
          // Xử lý lựa chọn bộ lọc ở đây
          // Ví dụ: filterProducts(selectedFilter.toString());
        },
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/layout/layout_2.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/image/logo_2.png",
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                      Spacer(flex: 1),
                      IconButton(
                        iconSize: 40,
                        icon: const Icon(Icons.notifications,
                            color: Colors.white),
                        onPressed: () {
                          // Hành động khi nút được nhấn
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 130,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CategoryBookListView(
                          categories: categories,
                          onCategorySelected: (selectedCategory) {
                            filterProducts(selectedCategory.categoryBookid);
                          },
                          selectedCategoryId: selectedCategoryId,
                        ),
                      ),
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.tune, color: Colors.black),
                        onPressed: () {
                          // Hành động khi nút được nhấn
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                bottom: 0,
                child: ProductGrid(products: filteredProducts),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
