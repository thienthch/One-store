import 'package:flutter/material.dart';
import 'package:one_store/data/model/product_model.dart';
import 'package:one_store/globals.dart';
import 'package:diacritic/diacritic.dart'; // Import thư viện diacritic

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";
  List<ProductModel> searchResults = [];
  List<ProductModel> latestProducts = [];
  bool isSearchNotEmpty = false; // Track if search query is not empty

  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    // Sắp xếp productsGrid theo updateBook và lấy 3 sản phẩm mới nhất
    latestProducts = List<ProductModel>.from(productsGrid)
      ..sort((a, b) => b.updateBook.compareTo(a.updateBook));
    latestProducts = latestProducts.take(3).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      query = newQuery;
      isSearchNotEmpty = newQuery.isNotEmpty;
      if (query.isEmpty) {
        searchResults = [];
      } else {
        searchResults = productsGrid
            .where((product) => removeDiacritics(product.name.toLowerCase())
                .contains(removeDiacritics(query.toLowerCase())))
            .toList();
      }
    });
  }

  void _showFilterDialog() {
    // Hàm này sẽ hiển thị hộp thoại lọc
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Options'),
          content: Text('Here you can add your filter options.'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _clearSearchField() {
    setState(() {
      query = "";
      isSearchNotEmpty = false;
      searchResults = [];
    });
    _searchController.clear(); // Clear the text field controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: Color(0xFFF3B664), // Outer border color
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: _showFilterDialog,
                        color: Color(0xFFF3B664),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(
                            color: Color(0xFFF3B664),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm sản phẩm...',
                            hintStyle: TextStyle(
                              color: Color(0xFFF3B664),
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15.0),
                          ),
                          onChanged: _updateSearchQuery,
                        ),
                      ),
                    ],
                  ),
                  if (isSearchNotEmpty)
                    Positioned(
                      right: 40,
                      child: IconButton(
                        icon: Icon(Icons.close_rounded),
                        onPressed: _clearSearchField,
                        color: Color(0xFFF3B664),
                      ),
                    ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.tune),
                      onPressed: _showFilterDialog,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: searchResults.isEmpty && query.isEmpty
                  ? _buildLatestProducts()
                  : searchResults.isEmpty
                      ? Center(
                          child: Text(
                            'Không tìm thấy sản phẩm nào',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        )
                      : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestProducts() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              top: 10,
              bottom: 10,
            ),
            child: Text(
              'Gợi ý',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: latestProducts.map((product) {
              return Container(
                width: MediaQuery.of(context).size.width / 3 - 10,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 180,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(children: [
                          const SizedBox(height: 8),
                          Image.asset(
                            'assets/image/book/${product.imageUrl}',
                            fit: BoxFit.cover,
                          ),
                          Text(
                            product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ])),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final product = searchResults[index];
        return _buildProductTile(product);
      },
    );
  }

  Widget _buildProductTile(ProductModel product) {
    return GridTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 254,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  child: SizedBox(
                    height: 170,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/image/book/${product.imageUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${product.price} VNĐ',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
