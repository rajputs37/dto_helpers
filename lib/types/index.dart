class ValidationResult {
  bool isValid;
  String? message;
  ValidationResult({required this.isValid, this.message});

  set setIsValid(bool value) {
    isValid = value;
  }

  set setMessage(String value) {
    message = value;
  }
}

abstract class PropertyValidate {
  ValidationResult validate();
}

abstract class DTOValidate {
  ValidationResult validate(dynamic json);
  ValidationResult validateAll(List<PropertyValidate> list) {
    for (var element in list) {
      final validationResult = element.validate();

      if (!validationResult.isValid) {
        return validationResult;
      }
    }
    return ValidationResult(isValid: true);
  }
}
