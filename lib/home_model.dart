class HomeModel{

  final int? userId;
  final int? id;
  final String? title;

  HomeModel({this.userId, this.id, this.title});

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
  );
}