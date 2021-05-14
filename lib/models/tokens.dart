class Tokens {
  String accessToken;
  String refreshToken;

  Tokens(this.accessToken, this.refreshToken);

  Tokens.fromJson(Map<String, dynamic> json) {
    accessToken = json["accessToken"];
    refreshToken = json["refreshToken"];
  }

  Map<String, dynamic> toJson() {
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
    };
  }
}
