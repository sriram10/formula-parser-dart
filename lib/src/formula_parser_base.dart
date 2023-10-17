import 'package:formula_parser/src/math_functions.dart';
import 'package:petitparser/petitparser.dart';
import 'parser_core.dart';

/// A class that parses and evaluates mathematical expressions.
class FormulaParser {
  String expression;
  Map<String, dynamic>? options;
  bool _isReservedWordsUsed = false;
  final List<String> _reservedWordsUsed = [];

  String _inputExpression = '';
  String _errorMessage = '';

  /// Constructs a FormulaParser instance with the given expression and options.
  FormulaParser(this.expression, [this.options]) {
    String tempExp = expression;
    options?.forEach((key, value) {
      if (availableFunctions.contains(key.toLowerCase()) &&
          tempExp.contains(key.toLowerCase())) {
        _isReservedWordsUsed = true;
        _reservedWordsUsed.add(key);
      } else {
        tempExp = tempExp.replaceAll(key, value!.toString());
      }
    });

    // remove unnecessary spaces
    // & make it all uppercase to make the parsing easier
    _inputExpression = tempExp.toUpperCase().replaceAll(" ", "");
  }

  /// Indicates whether an error occurred during parsing.
  bool get error {
    try {
      var parsedData = parser.parse(_inputExpression);
      if (parsedData is Failure) {
        _errorMessage = parsedData.message;
        return true;
      }
    } catch (e) {
      _errorMessage = 'INVALID EXPRESSION: ${e.toString()}';
      return true;
    }

    return _isReservedWordsUsed;
  }

  /// The error message describing the error that occurred during parsing.
  String get errorMessage {
    if (_isReservedWordsUsed == true) {
      return 'option contains Reserved words. Remove these Reserved word(s): ${_reservedWordsUsed.toString()}';
    }
    return _errorMessage;
  }

  /// The parsed expression after preprocessing.
  String get parsedExpression => _inputExpression;

  /// Parses the expression and returns the result.
  get parse {
    try {
      var parsedData = parser.parse(_inputExpression);
      if (parsedData is Failure) {
        _errorMessage = parsedData.message;

        return {
          'isFailure': true,
          'isSuccess': false,
          'message': _errorMessage,
          'position': parsedData.position,
          'value': null,
        };
      }

      return {
        'isFailure': false,
        'isSuccess': true,
        'message': '',
        'position': parsedData.position,
        'value': parsedData.value,
      };
    } catch (e) {
      _errorMessage = 'INVALID EXPRESSION: ${e.toString()}';
      return {
        'isFailure': true,
        'isSuccess': false,
        'message': _errorMessage,
        'position': 0,
        'value': null,
      };
    }
  }
}
