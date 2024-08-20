import 'package:flutter/material.dart';
import 'package:one_store/data/model/product_model.dart';
import 'package:one_store/page/product/productdetailscreen.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;

  ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Số cột
                crossAxisSpacing: 10, // Khoảng cách giữa các cột
                mainAxisSpacing: 10, // Khoảng cách giữa các hàng
                childAspectRatio:
                    3 / 4, // Tỷ lệ chiều rộng / chiều cao của một ô
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(product),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 254,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white, // Đặt màu nền ở đây
                            borderRadius: BorderRadius.circular(
                                10.0), // Điều chỉnh bán kính bo góc ở đây
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3), // Điều chỉnh bóng đổ
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
                                ), // Điều chỉnh bán kính bo góc trên cùng
                                child: SizedBox(
                                  height: 170, // Chiều cao cố định của hình ảnh
                                  width: double
                                      .infinity, // Chiều rộng chiếm toàn bộ ô lưới
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1, // Giới hạn số dòng là 2
                                        overflow: TextOverflow
                                            .ellipsis, // Thêm dấu "..."
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
