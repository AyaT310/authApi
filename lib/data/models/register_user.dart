class RegisterUser {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? birthdate;
  String? referralCode;
  String? code;

  RegisterUser({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.birthdate,
    this.phone,
    this.referralCode,
    this.code,
  });

  factory RegisterUser.fromJson(Map<String, dynamic> data) {
    return RegisterUser(
      firstName: data["first_name"],
      lastName: data["last_name"],
      email: data["email"],
      password: data["password"],
      birthdate: data["birth_date"],
      referralCode: data["referral_code"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "phone": phone,
      "birth_date": birthdate,
      "referral_code": referralCode,
      "code": code,
    };
  }
}
