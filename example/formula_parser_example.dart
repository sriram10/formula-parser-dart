import 'package:formula_parser/formula_parser.dart';

void main() {
  // Create a FormulaParser instance with the expression and variables
  var exp = FormulaParser('a*b+324', {'a': 10, 'b': 20});

  // Expression can be a complex one like below as well.
  // This works too!
  // Might look pretty long.
  // var exp = FormulaParser(
  //     '4.5 + 5.5^2 + ADD(4,4) + ADD(1, MUL(2,10)) + MUL(2, DIVI(2,3)) + DIVI(2,2) + AVG(2,3,4,5)/5 + POWER(2,2) + SQRT(4) + 5^2');

  if (exp.error) {
    print(exp.errorMessage);
  } else {
    print('Expression: ${exp.parsedExpression}');
    // Parse the expression
    var result = exp.parse;
    print(result);

    if (result['isSuccess']) {
      print('Result: ${result['value']}');
    } else {
      // Print the error information if parsing fails
      print(result['isFailure']);
      print(result['position']);
      print(result['message']);
    }
  }
}
