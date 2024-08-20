class CategoryModel {
  String categoryid, imageUrl, name;

  CategoryModel({
    required this.categoryid,
    required this.imageUrl,
    required this.name,
  });
}

List<CategoryModel> categoriesGrid = [
  CategoryModel(
    categoryid: "1",
    imageUrl: "Ruler.png",
    name: "Văn phòng phẩm",
  ),
  CategoryModel(
    categoryid: "2",
    imageUrl: "Open_Book.png",
    name: "Sách",
  ),
  CategoryModel(
    categoryid: "3",
    imageUrl: "Discount.png",
    name: "Khuyến mãi",
  ),
  CategoryModel(
    categoryid: "4",
    imageUrl: "New.png",
    name: "Sản phẩm mới",
  ),
];
