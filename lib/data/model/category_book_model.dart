class CategoryBookModel {
  String categoryBookid, name;

  CategoryBookModel({
    required this.categoryBookid,
    required this.name,
  });
}

List<CategoryBookModel> categoryBookGrid = [
  CategoryBookModel(
    categoryBookid: "1",
    name: "Tâm lý",
  ),
  CategoryBookModel(
    categoryBookid: "2",
    name: "Văn học",
  ),
  CategoryBookModel(
    categoryBookid: "3",
    name: "Kinh tế",
  ),
  CategoryBookModel(
    categoryBookid: "4",
    name: "Thiếu nhi",
  ),
  CategoryBookModel(
    categoryBookid: "5",
    name: "Giáo khoa",
  ),
  CategoryBookModel(
    categoryBookid: "6",
    name: "Công nghệ",
  ),
];
