class CategoryModel {
  final String strCategory;
  final String strCategoryThumb;

  const CategoryModel({
    required this.strCategory,
    required this.strCategoryThumb,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      strCategory: json['strCategory'] as String,
      strCategoryThumb: json['strCategoryThumb'] as String,
    );
  }
}
