// class AllRetailers {
//   List<RetailerData>? retailerdata;
//   Pagination? pagination;
//
//   AllRetailers({this.retailerdata, this.pagination});
//
//   AllRetailers.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       retailerdata = <RetailerData>[];
//       json['data'].forEach((v) {
//         retailerdata!.add(RetailerData.fromJson(v));
//       });
//     }
//     pagination = json['pagination'] != null
//         ? Pagination.fromJson(json['pagination'])
//         : null;
//   }
//
// }
//
// class RetailerData {
//   String? id;
//   String? name;
//   bool? isFav;
//   Logo? logo;
//   City? city;
//   City? area;
//   String? latitude;
//   String? longitude;
//   RetailerCategory? retailerCategory;
//
//   RetailerData(
//       {this.id,
//         this.name,
//         this.isFav,
//         this.logo,
//         this.city,
//         this.area,
//         this.latitude,
//         this.longitude,
//         this.retailerCategory});
//
//   RetailerData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     isFav = json['is_fav'];
//     logo = json['logo'] != null ? Logo.fromJson(json['logo']) : null;
//     city = json['city'] != null ? City.fromJson(json['city']) : null;
//     area = json['area'] != null ? City.fromJson(json['area']) : null;
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     retailerCategory = json['retailer_category'] != null
//         ? RetailerCategory.fromJson(json['retailer_category'])
//         : null;
//   }
// }
//
// class Logo {
//   int? id;
//   String? path;
//   String? pathThumbnail;
//   String? mimeType;
//
//   Logo(
//       {this.id,
//         this.path,
//         this.pathThumbnail,
//         this.mimeType,
//         });
//
//   Logo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     path = json['path'];
//     pathThumbnail = json['path_thumbnail'];
//     mimeType = json['mime_type'];
//   }
// }
//
// class City {
//   String? id;
//   String? name;
//
//   City({this.id, this.name});
//
//   City.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
// }
//
// class RetailerCategory {
//   String? id;
//   String? name;
//   Logo? image;
//   bool? active;
//
//   RetailerCategory({this.id, this.name, this.image, this.active});
//
//   RetailerCategory.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'] != null ? Logo.fromJson(json['image']) : null;
//     active = json['active'];
//   }
// }
//
// class Pagination {
//   int? total;
//   int? count;
//   int? perPage;
//   int? currentPage;
//   int? totalPages;
//
//   Pagination(
//       {this.total,
//         this.count,
//         this.perPage,
//         this.currentPage,
//         this.totalPages});
//
//   Pagination.fromJson(Map<String, dynamic> json) {
//     total = json['total'];
//     count = json['count'];
//     perPage = json['per_page'];
//     currentPage = json['current_page'];
//     totalPages = json['total_pages'];
//   }
//
// }



class AllRetailers {
  RetailersData? retailerdata;

  AllRetailers({this.retailerdata});

  AllRetailers.fromJson(Map<String, dynamic> json) {
    retailerdata = json['data'] != null ? RetailersData.fromJson(json['data']) : null;
  }
}

class RetailersData {
  MyRetailers? myRetailers;

  RetailersData({this.myRetailers});

  RetailersData.fromJson(Map<String, dynamic> json) {
    myRetailers = json['retailers'] != null
        ? MyRetailers.fromJson(json['retailers'])
        : null;
  }
}

class MyRetailers {
  List<AllRetailersData>? allRetailersdata;
  Pagination? pagination;

  MyRetailers({this.allRetailersdata, this.pagination});

  MyRetailers.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      allRetailersdata = <AllRetailersData>[];
      json['data'].forEach((v) {
        allRetailersdata!.add(AllRetailersData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}

class AllRetailersData {
  String? id;
  String? name;
  bool? isFav;
  Logo? logo;
  City? city;
  City? area;
  String? latitude;
  String? longitude;
  RetailerCategory? retailerCategory;

  AllRetailersData(
      {this.id,
        this.name,
        this.isFav,
        this.logo,
        this.city,
        this.area,
        this.latitude,
        this.longitude,
        this.retailerCategory});

  AllRetailersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isFav = json['is_fav'];
    logo = json['logo'] != null ?  Logo.fromJson(json['logo']) : null;
    city = json['city'] != null ?  City.fromJson(json['city']) : null;
    area = json['area'] != null ?  City.fromJson(json['area']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
    retailerCategory = json['retailer_category'] != null
        ? RetailerCategory.fromJson(json['retailer_category'])
        : null;
  }
}

class Logo {
  int? id;
  String? path;
  String? pathThumbnail;
  String? mimeType;
  Logo(
      {this.id,
        this.path,
        this.pathThumbnail,
        this.mimeType,
      });

  Logo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    pathThumbnail = json['path_thumbnail'];
    mimeType = json['mime_type'];
  }
}

class City {
  String? id;
  String? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class RetailerCategory {
  String? id;
  String? name;
  Logo? image;
  bool? active;

  RetailerCategory({this.id, this.name, this.image, this.active});

  RetailerCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] != null ? Logo.fromJson(json['image']) : null;
    active = json['active'];
  }
}

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  Pagination(
      {this.total,
        this.count,
        this.perPage,
        this.currentPage,
        this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
  }
}