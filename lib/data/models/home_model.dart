class HomeData {
  Data? data;

  HomeData({this.data});

  HomeData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<TopAds>? topAds;
  List<Retailers>? retailers;
  List<Bonus>? bonus;
  List<RetailersCategories>? retailersCategories;
  int? unreadNotificationCount;

  Data({
    this.topAds,
    this.retailers,
    this.bonus,
    this.retailersCategories,
    this.unreadNotificationCount,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['top_ads'] != null) {
      topAds = <TopAds>[];
      json['top_ads'].forEach((v) {
        topAds!.add(TopAds.fromJson(v));
      });
    }
    if (json['retailers'] != null) {
      retailers = <Retailers>[];
      json['retailers'].forEach((v) {
        retailers!.add(Retailers.fromJson(v));
      });
    }
    if (json['bonus'] != null) {
      bonus = <Bonus>[];
      json['bonus'].forEach((v) {
        bonus!.add(Bonus.fromJson(v));
      });
    }
    if (json['retailers_categories'] != null) {
      retailersCategories = <RetailersCategories>[];
      json['retailers_categories'].forEach((v) {
        retailersCategories!.add(RetailersCategories.fromJson(v));
      });
    }
    unreadNotificationCount = json['unread_notification_count'];
  }
}

class TopAds {
  String? id;
  String? name;
  ImageModel? image;
  String? url;
  int? type;
  int? distance;
  int? sort;

  TopAds({
    this.id,
    this.name,
    this.image,
    this.url,
    this.type,
    this.distance,
    this.sort,
  });

  TopAds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    url = json['url'];
    type = json['type'];
    distance = json['distance'];
    sort = json['sort'];
  }
}

class ImageModel {
  int? id;
  String? path;
  String? pathThumbnail;
  String? mimeType;

  ImageModel({
    this.id,
    this.path,
    this.pathThumbnail,
    this.mimeType,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    pathThumbnail = json['path_thumbnail'];
    mimeType = json['mime_type'];
  }
}

class Retailers {
  String? id;
  String? name;
  ImageModel? logo;
  String? searchText;

  Retailers({
    this.id,
    this.name,
    this.logo,
    this.searchText,
  });

  Retailers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'] != null ? ImageModel.fromJson(json['logo']) : null;
    searchText = json['search_text'];
  }
}

class Bonus {
  String? id;
  String? name;
  String? subTitle;
  String? price;
  String? description;
  String? expirationDate;
  ImageModel? image;
  String? createdAt;
  bool? isClaimed;

  Bonus(
      {this.id,
      this.name,
      this.subTitle,
      this.price,
      this.description,
      this.expirationDate,
      this.image,
      this.createdAt,
      this.isClaimed});

  Bonus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subTitle = json['sub_title'];
    price = json['price'];
    description = json['description'];
    expirationDate = json['expiration_date'];
    image =
        json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    createdAt = json['created_at'];
    isClaimed = json['is_claimed'];
  }
}

class RetailersCategories {
  String? id;
  String? name;
  ImageModel? image;
  bool? active;

  RetailersCategories({this.id, this.name, this.image, this.active});

  RetailersCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image =
        json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    active = json['active'];
  }
}

