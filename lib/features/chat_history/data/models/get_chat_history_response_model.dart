class Data {
  List<Sessions>? sessions;

  Data({
    this.sessions,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(Sessions.fromJson(v));
      });
    }
  }
}

class Sessions {
  String? id;
  int? userId;
  String? name;
  String? createdAt;
  bool? isCompleted;
  String? completedAt;

  Sessions({
    this.id,
    this.userId,
    this.name,
    this.createdAt,
    this.isCompleted,
    this.completedAt,
  });

  Sessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    createdAt = json['createdAt'];
    isCompleted = json['isCompleted'];
    completedAt = json['completedAt'];
  }
}
