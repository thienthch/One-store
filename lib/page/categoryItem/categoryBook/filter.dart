import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  final Function(int) onFilterSelected;

  const Filter({Key? key, required this.onFilterSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 50, left: 50),
                child: Text(
                  "Sắp xếp theo",
                  style: TextStyle(
                    // color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 50, right: 50),
                child: DropdownButtonFormField<String>(
                  value: 'Mới nhất', // Giá trị mặc định
                  onChanged: (newValue) {
                    // Xử lý khi người dùng thay đổi lựa chọn
                    print('Lựa chọn mới: $newValue');
                  },
                  items: <String>[
                    'Mới nhất',
                    'Cũ nhất',
                    'Giá thấp lên cao',
                    'Giá cao xuống thấp',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.orange), // Màu viền đen
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  isExpanded: true, // Tự động thu gọn khi nhiều dữ liệu
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 50),
                child: Text(
                  "Mức giá",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 50, right: 50),
                child: DropdownButtonFormField<String>(
                  value: 'Tất cả', // Giá trị mặc định
                  onChanged: (newValue) {
                    // Xử lý khi người dùng thay đổi lựa chọn
                    print('Lựa chọn mới: $newValue');
                  },
                  items: <String>[
                    'Tất cả',
                    '0 - 50.000 VND',
                    '51.000 - 100.000 VND',
                    '101.000 - 150.000 VND',
                    '151.000 - 200.000 VND',
                    '200.000 VND trở lên',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.orange), // Màu viền cam
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  isExpanded: true, // Tự động thu gọn khi nhiều dữ liệu
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 100.0,
              left: 100.0,
              top: 20.0,
            ), // Đặt khoảng cách viền
            child: TextButton(
              onPressed: () {
                // Xử lý khi nút được nhấn
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFEC8F5E), // Màu nền cam
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0), // Bo góc
                ),
              ),
              child: const Text(
                "Lọc",
                style: TextStyle(color: Colors.white, fontSize: 15), // Màu cam
              ),
            ),
          )
        ],
      ),
    );
  }
}
