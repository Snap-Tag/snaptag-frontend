class Tags {
  final String tag_id;
  final String tag_name;
  Tags({
    required this.tag_id,
    required this.tag_name,
  });
  factory Tags.fromSqfliteDatabase(Map<String, dynamic> map) => Tags(
      tag_id: map['tagID']?.toString() ?? 'null',
      tag_name: map['tag']?.toString() ?? 'null');
}
