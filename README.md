# dto_helpers

DTO(Data transfer objects) validators package for [Dart](https://dart.dev/).
Supports all platforms.
The <b>dto_helpers</b> package provides a robust set of validators for Data Transfer Objects (DTOs) in Dart applications, ensuring data integrity for various data types including strings, numbers, enums, booleans, and lists.

## Getting Started 🚀

Enhance your Flutter or Dart project by adding dto_helpers to your dependency list:

```yml
dependencies:
  ...
  dto_helpers:
```

## Features ✨

- <b>String Validator</b>: Ensure that your data meets specific string-based criteria.
- <b>List Validator</b>: Validate list sizes and nested list elements.
- <b>Number Validator</b>: Confirm numerical data integrity, ranges, and sign.
- <b>Enum Validator</b>: Check that data matches one of the predefined enum values.
- <b>Boolean Validator</b>: Verify boolean values accurately.

## Usage

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

#### IsString

Ensures the data is a string, with a plethora of checks such as email validation, URL checks, case sensitivity, and more for comprehensive string validation.

```
IsString(
    value,
    isOptional, // will ignore validation if value is null
    isEmail,
    contains,
    notContains,
    isUrl,
    isAlpha,
    isAlphanumeric,
    isBase64,
    isCreditCard,
    isDate,
    isJSON,
    isLowercase,
    isUppercase,
    isUUID,
    isIP,
    isUppercase,
    isIn,// String[],
    maxLen,
    minLen,
    propertyName, // it will contruct a message whenever validation fails, if propertyName is passed
)
```

#### IsNumber

Ensures numerical data is within a specific range and meets criteria like being positive or divisible by a specific number.

```
IsNumber(
    value,
    isOptional, // will ignore validation if value is null
    propertyName, // it will contruct a message whenever validation fails, if propertyName is passed
    isNegative,
    isPositive,
    isDivisibleBy,
    max,
    min
)
```

```
IsNumber(
  value: json['someNumber'],
  min: 0,
  max: 100,
  propertyName: 'someNumber'
)
```

#### IsEnum

Validates if the provided data matches one of the specified enum values.

```
enum UserRole { admin, user, guest }

IsEnum(
  value: json['role'],
  values: UserRole.values,
  propertyName: 'role'
)
```

#### IsBoolean

Checks if the data is a boolean value.

```
IsBoolean(
  value: json['isActive'],
  propertyName: 'isActive'
)
```

#### IsList

Ensures the provided list data meets size requirements and applies additional validators to each element.

```

IsList(
    value,
    maxSize,
    minSize,
    nested, // this property should be a function which will applied to each element of the array. Function should return any one of the propertValidate types, like IsString, IsNumber, IsBoolean, IsEnum or IsList. please see example below
    isOptional, // will ignore validation if value is null
    propertyName, // it will contruct a message whenever validation fails, if propertyName is passed
)

IsList(
  value: json['tags'],
  minSize: 1,
  nested: (element) => IsString(value: element, maxLen: 20),
  propertyName: 'tags'
)
```

### Leveraging dto_helpers effectively 🚀

The <b>dto_helpers</b> package is designed to simplify data validation across your Dart and Flutter applications, enhancing code quality and data integrity.

Feel free to contribute or raise issues on [Github](https://github.com/rajputs37/dto_helpers).
