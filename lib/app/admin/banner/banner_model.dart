class BannerModel {
  final String id;
  final String url;

  BannerModel({required this.id, required this.url});

  factory BannerModel.fromJson(Map<String, dynamic> json, String id) {
    return BannerModel(id: id, url: json['bannerUrl'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url};
  }
}
