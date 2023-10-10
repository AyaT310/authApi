class CheckUser {
  String? phone;
  String? password;

  CheckUser({this.phone, this.password});

  factory CheckUser.fromJson(Map<String, dynamic> data) {
    return CheckUser(
      phone: data["phone"],
      password: data["password"],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> body = {};

    if (password != null) {
      body['password'] = password;
    }
    if (phone != null) {
      body['phone'] = phone;
    }

    return body;
  }
}
