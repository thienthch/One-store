class Banner {
  int? id;
  String? img;
  Banner({
    this.id,
    this.img,
  });

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['img'] = img;
    return data;
  }
}
