To leverage dto_helpers, declare a DTO class extending `DTOValidate`. Here's an example of a SignInDTO:

```dart
import 'package:dto_helpers/dto_helpers.dart';

class SignInDTO extends DTOValidate {
  late String name;
  int? signInCode;

  SignInDTO({required this.name, this.signInCode});

  // Factory constructor for JSON deserialization
  factory SignInDTO.fromJson(dynamic json) {
    return SignInDTO(name: json['name'], signInCode: json['signInCode']);
  }

  // Call this for an empty DTO
  SignInDTO.empty();

  @override
  ValidationResult validate(dynamic json) {
    return super.validateAll([
      IsString(
        value: json['name'],
        propertyName: 'name' // Provides meaningful error messages
      ),
      IsNumber(
        value: json['signInCode'],
        isOptional: true, // Signifies optional fields
        propertyName: 'signInCode'
      )
    ]);
  }
}

// Example usage:
final json = {'name': 'John Doe', 'signInCode': 12345}; // JSON from a network request
final ValidationResult validationResult = SignInDTO.empty().validate(json);
if (!validationResult.isValid) {
  throw Exception('Validation error ${validationResult.message}');
}

SignInDTO signInDTO = SignInDTO.fromJson(json);

```

### Validators

Each of the property validate class like `IsString`, `IsNumber`, `IsBoolean`, `IsList` and `IsEnum` can be used as the following also.

```
// each of these class has a method 'validate', which will
// compute validation result based on the options given.

final result=IsString(value: qrCode).validate();

```
