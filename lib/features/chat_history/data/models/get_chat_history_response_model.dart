class Data {
  List<Sessions>? sessions;
  int? totalCount;
  int? pageNumber;
  int? pageSize;
  int? totalPages;
  bool? hasPreviousPage;
  bool? hasNextPage;

  Data(
      {this.sessions,
      this.totalCount,
      this.pageNumber,
      this.pageSize,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(Sessions.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
  }
}

class Sessions {
  String? id;
  int? userId;
  String? name;
  String? createdAt;
  bool? isCompleted;
  String? completedAt;

  Sessions(
      {this.id,
      this.userId,
      this.name,
      this.createdAt,
      this.isCompleted,
      this.completedAt});

  Sessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    createdAt = json['createdAt'];
    isCompleted = json['isCompleted'];
    completedAt = json['completedAt'];
  }
}
