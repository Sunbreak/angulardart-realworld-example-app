class Errors {
  dynamic errors;

  Errors({
    this.errors,
  });

  factory Errors.fromJson(Map<String, dynamic> json) {
    return Errors(
      errors: json['errors'],
    );
  }
}
