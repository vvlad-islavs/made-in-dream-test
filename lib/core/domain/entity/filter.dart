class Filter {
  bool hasPhoto;
  int maxMinutes;

  String searchText;

  Filter({this.hasPhoto = true, this.maxMinutes = 0, this.searchText = ''});

  Filter copyWith({bool? hasPhoto, int? maxMinutes, String? searchText}) => Filter(
    hasPhoto: hasPhoto ?? this.hasPhoto,
    maxMinutes: maxMinutes ?? this.maxMinutes,
    searchText: searchText ?? this.searchText,
  );
}
