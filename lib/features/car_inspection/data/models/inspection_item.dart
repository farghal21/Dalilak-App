class InspectionItem {
  final String title;
  final String hint;
  final bool isChecked;

  InspectionItem({
    required this.title,
    required this.hint,
    this.isChecked = false,
  });

  // نسخ الكائن مع تعديل بعض الخصائص
  InspectionItem copyWith({
    String? title,
    String? hint,
    bool? isChecked,
  }) {
    return InspectionItem(
      title: title ?? this.title,
      hint: hint ?? this.hint,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  // تحويل الكائن إلى JSON للحفظ في SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'hint': hint,
      'isChecked': isChecked,
    };
  }

  // إنشاء كائن من JSON
  factory InspectionItem.fromJson(Map<String, dynamic> json) {
    return InspectionItem(
      title: json['title'] as String,
      hint: json['hint'] as String,
      isChecked: json['isChecked'] as bool? ?? false,
    );
  }
}
