import 'package:petitparser/petitparser.dart';
import 'math_functions.dart';

/// Creates a function based on the given left, value, and right arguments
/// if the expression is ADD(2,3) then this function will receive,
/// left = [ADD, (]
/// value = [2, 3] can be a List
/// right = [)]
/// and will return 5
///
/// If the expression is a math function with only one argument like POWER(5.6) or SQRT(9) then,
/// left = [ROUND, (] or [SQRT, (]
/// value = 5.6 or 9 // can be a number (int / double / num)
/// right = [)]
dynamic _createFunction(left, value, right) {
  if (left.runtimeType == List) {
    /// check if the value is a list of multiple arguments
    /// eg. [1, 2, 3]
    /// To handle math functions with more than one argument
    /// Eg., ADD, MUL, DIVI, AVG, POWER
    /// value is List<Object?> - check is for petitparser 4.4.0
    /// where in petitparser 5.x it is List<dynamic>
    if (value.runtimeType == List || value is List<Object?>) {
      // Convert value to a list of numbers
      List v = value
          .toString()
          .replaceAll(RegExp(r'[\[\]]'), '')
          .split(',')
          .toList();
      List<num> args = v.map((e) {
        return double.parse(e);
      }).toList();
      return mathFunction(left[0], args);
    }

    // handle math functions with only one argument
    if ([int, double, num].contains(value.runtimeType)) {
      return mathFunction(left[0], [value]);
    }
  }

  return value;
}

/// Creates a parser using PetitParser library
final parser = () {
  final number = (digit().plus() &
          (digit().plus() & char('.') & digit().plus()).optional() &
          (char('.') & digit().plus()).optional() &
          (pattern('eE') & pattern('+-').optional() & digit().plus())
              .optional())
      .flatten('number expected')
      .trim()
      .map(double.parse);
  final boolean = (string('true') &
          string('True').optional() &
          string('false').optional() &
          string('False').optional())
      .flatten('true or false expected')
      .trim()
      .optional();

  final builder = ExpressionBuilder();

  builder.group().primitive(number.or(boolean));

  builder.group().wrapper(word().star().trim().flatten().seq(char('(').trim()),
      char(')').trim(), _createFunction);

  builder.group()
    ..prefix(char('+').trim(), (op, a) => a)
    ..prefix(char('-').trim(), (op, a) {
      return -1 * (a as num);
    })
    ..postfix(string('false').trim(), (op, a) => false)
    ..postfix(string('true').trim(), (op, a) => false);

  /// Rule gets applied in this order
  /// 1. First apply in this order ^, *, /, +, -
  /// 2. check comparison operators <=, >=, ==, !=, <, >
  /// 3. Apply negation operator !
  builder.group().left(char('^').trim(),
      (a, op, b) => mathFunction('POWER', [a as num, b as num]));

  builder.group()
    ..left(char('*').trim(),
        (a, op, b) => mathFunction('MUL', [a as num, b as num]))
    ..left(char('/').trim(),
        (a, op, b) => mathFunction('DIVI', [a as num, b as num]));

  builder.group()
    ..left(char('+').trim(),
        (a, op, b) => mathFunction('ADD', [a as num, b as num]))
    ..left(char('-').trim(),
        (a, op, b) => mathFunction('SUB', [a as num, b as num]));

  /// TODO: fix this to support ! operator
  /// this might fail in few scenarios and yet to be tested thoroughly
  builder.group().prefix(char('!').trim(), (op, a) {
    print(a.runtimeType);
    if (a.runtimeType == bool) {
      print(a.toString().toLowerCase());
      return !(a as bool);
    } else {
      print(a.toString().toLowerCase());
      if (['false', '0', '0.0', 'null', 'Null']
          .contains(a.toString().toLowerCase())) {
        return true; // return the opposite
      }
      return false;
    }
  });

  builder.group()
    ..left(char('<').seq(char('=')).trim(),
        (a, op, b) => mathFunction('LTE', [a as num, b as num]))
    ..left(string('>=').trim(),
        (a, op, b) => mathFunction('GTE', [a as num, b as num]))
    ..left(string('==').trim(),
        (a, op, b) => mathFunction('EQ', [a as num, b as num]))
    ..left(string('!=').trim(),
        (a, op, b) => mathFunction('NE', [a as num, b as num]))
    ..left(char('<').trim(),
        (a, op, b) => mathFunction('LT', [a as num, b as num]))
    ..left(char('>').trim(),
        (a, op, b) => mathFunction('GT', [a as num, b as num]));

  builder.group().left(char(',').trim(), (a, op, b) => [a, b]);

  return builder.build().end();
}();
