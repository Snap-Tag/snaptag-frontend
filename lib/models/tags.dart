class Tags {
  final String tagID;
  final String tag;
  Tags({
    required this.tagID,
    required this.tag,
  });
  factory Tags.fromSqfliteDatabase(Map<String, dynamic> map) => Tags(
      tagID: map['tagID']?.toString() ?? 'null',
      tag: map['tag']?.toString() ?? 'null');
}
