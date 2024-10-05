class PaginatedResponse<T> {
  final int pageNo;
  final int totalPage;
  final List<T> data;

  PaginatedResponse({
    required this.pageNo,
    required this.totalPage,
    required this.data,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> map, {
    required Function(List<dynamic> jsonData) mappingData,
  }) {
    return PaginatedResponse(
      pageNo: map['pageNo'] ?? 0,
      totalPage: map['totalPage'] ?? 0,
      data: mappingData(map['result']),
    );
  }

  @override
  String toString() {
    return 'PaginatedResponse(pageNo:$pageNo, totalPage:$totalPage, data:${data.length})';
  }
}
