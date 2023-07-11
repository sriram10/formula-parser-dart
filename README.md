Formula Parser for Dart
=======================
A dart plugin to to parse and evaluate mathematical expressions.

[![GitHub Issues](https://img.shields.io/github/issues/sriram10/formula-parser-dart.svg)](https://github.com/sriram10/formula-parser-dart/issues)
[![GitHub Forks](https://img.shields.io/github/forks/sriram10/formula-parser-dart.svg)](https://github.com/sriram10/formula-parser-dart/network)
[![GitHub Stars](https://img.shields.io/github/stars/sriram10/formula-parser-dart.svg)](https://github.com/sriram10/formula-parser-dart/stargazers)
[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/sriram10/formula-parser-dart/main/LICENSE)


Formula Parser is a Dart library that allows you to parse and evaluate mathematical expressions.
The grammar for this library is built using [petitparser](https://pub.dev/packages/petitparser) library.

This library is open source, stable and well tested. Development happens on GitHub. Feel free to report issues or create a pull-request there.

The package is hosted on dart packages. Up-to-date API documentation is created with every release.

## Installation
To use Formula Parser in your Dart project, add the following dependency to your `pubspec.yaml` file:
```yaml
dependencies: 
  formula_parser: ^1.0.0
```
Then, run `flutter packages get`

or to install it on another dart project, run the below command
```
dart pub add formula_parser
```

## Usage
Import the package in your Dart file:
```dart
import 'package:formulaparser/formulaparser.dart';
```

Create a `FormulaParser` instance with the expression and variables:
```dart
var exp = FormulaParser('a+b+150', {'a': 10, 'b': 20 });
```

To parse the expression,
```dart
var result = exp.parse;
```

Check if the parsing was successful:
```dart
if (result.isSuccess) {
  print('Result: \${result.value}');
} else {
  print(result.isFailure);
  print(result.position);
  print(result.message);
}
```

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features
- Parses and evaluates mathematical expressions.
- Supports variables and functions in the expressions.
- Handles error cases and provides error messages.

## Supported Math Functions
The following math functions are supported by the Formula Parser:

| Function  | Description                                | Example                       |
| --------- | ------------------------------------------ | ----------------------------- |
| ADD       | Addition                                   | `ADD(2, 3)`                   |
| SUB       | Subtraction                                | `SUB(5, 2)`                   |
| MUL       | Multiplication                             | `MUL(4, 5)`                   |
| DIVI      | Division                                   | `DIVI(10, 2)`                 |
| AVG       | Average                                    | `AVG(2, 3, 4, 5)`             |
| POWER     | Exponentiation                             | `POWER(2, 3)`                 |
| SQRT      | Square Root                                | `SQRT(4)`                     |
| CEIL      | Ceiling                                    | `CEIL(4.2)`                   |
| FLOOR     | Floor                                      | `FLOOR(4.8)`                  |
| ROUND     | Round                                      | `ROUND(4.5)`                  |
| ABS       | Absolute                                   | `ABS(-4.5)`                   |
| EXP       | Exponential                                | `EXP(2)`                      |
| LOG       | Natural Logarithm                          | `LOG(10)`                     |
| SIN       | Sine                                       | `SIN(0)`                      |
| ASIN      | Arcsine                                    | `ASIN(0)`                     |
| COS       | Cosine                                     | `COS(0)`                      |
| ACOS      | Arccosine                                  | `ACOS(0)`                     |
| TAN       | Tangent                                    | `TAN(0)`                      |
| ATAN      | Arctangent                                 | `ATAN(0)`                     |

To use these functions, you can include them in your expressions. For example:
```dart
var exp = FormulaParser('1+ADD(4,4)+MUL(2,DIVI(2,3))+AVG(2,3,4,5)/5+POWER(2,2)+SQRT(4)+CEIL(4.2)+FLOOR(4.8)+ROUND(4.5)+ABS(-4.5)+EXP(2)+LOG(10)+SIN(0)+ASIN(0)+COS(0)+ACOS(0)+TAN(0)+ATAN(0)');
```
The following comparison functions are supported by the Formula Parser:

| Function  | Description                                | Example                       |
| --------- | ------------------------------------------ | ----------------------------- | 
| EQ        | Equal                                      | `EQ(2,2)`                     |
| NE        | Not Equal                                  | `NE(2,3)`                     |
| LT        | Less Than                                  | `LT(2,3)`                     |
| GT        | Greater Than                               | `GT(2,3)`                     |
| GTE       | Less Than or Equal To                      | `LTE(2,3)`                    |
| LTE       | Greater Than or Equal To                   | `GTE(2,3)`                    |

## Supported Operators
The following operators are supported by the Formula Parser:

| Operator | Description               | Example              |
| -------- | ------------------------- | -------------------- |
| +        | Addition                  | `2 + 3`              |
| -        | Subtraction               | `5 - 2`              |
| *        | Multiplication            | `4 * 5`              |
| /        | Division                  | `10 / 2`             |
| ^        | Exponentiation            | `2 ^ 3`              |
| Comparison Operators                                        |
| ==       | Equal                     | `2 == 2`             |
| !=       | Not Equal                 | `5 != 2`             |
| <        | Less Than                 | `4 < 5`              |
| >        | Greater Than              | `10 > 2`             |
| <=       | Less Than or Equal To     | `2 <= 3`             |
| >=       | Greater Than or Equal To  | `5 >= 2`             |

## Documentation

The `FormulaParser` class provides the following methods and properties:

### `FormulaParser(expression: String, [options: Map<String, dynamic>])`

Constructs a `FormulaParser` instance with the given expression and options.

- `expression`: The mathematical expression to parse.
- `options` (optional): A map of variables to their values.

### `error`

Indicates whether an error occurred during parsing.

- Returns `true` if an error occurred, `false` otherwise.

### `errorMessage`

The error message describing the error that occurred during parsing.

- Returns the error message as a `String`.

### `parsedExpression`

The parsed expression after preprocessing.

- Returns the parsed expression as a `String`.

### `parse`

Parses the expression and returns the result.

- Returns the parsed result.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the [GitHub repository](https://github.com/sriram10/formula-parser-dart).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

