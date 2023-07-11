import 'package:formula_parser/formula_parser.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests without options', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('expression with arithmetic operators', () {
      final exp = FormulaParser('1+2+3-5');
      final result = exp.parse;
      expect(result.isSuccess, isTrue);
      expect(result.value.compareTo(1) == 0, isTrue);
    });

    test('expression with arithmetic methods', () {
      final exp = FormulaParser('ADD(1,MUL(2, 2))'); // 1+2*2=5
      final result = exp.parse;
      expect(result.isSuccess, isTrue);
      expect(result.value.compareTo(5) == 0, isTrue);
    });

    test('expression with arithmetic methods and operators', () {
      final exp = FormulaParser(
          'ADD(1,MUL(2, 2))+2^2+SQRT(4)'); // 1+2*2+(2^2)+sqrt(4)=11
      final result = exp.parse;
      expect(result.isSuccess, isTrue);
      expect(result.value.compareTo(11) == 0, isTrue);
    });
  });

  group('A group of tests with options', () {
    var options = {'a': 10, 'b': 20.5, 'test': 30, 'x': 40};
    test('expression with arithmetic operators', () {
      // 10 + 20.5 + 5 * 4 / 10 = 32.5
      final exp = FormulaParser('a+b+5*4/a', options);
      final result = exp.parse;
      expect(result.isSuccess, isTrue);
      expect(result.value.compareTo(32.5) == 0, isTrue);
    });

    test('expression with arithmetic methods', () {
      final exp =
          FormulaParser('ADD(a,MUL(test, x))', options); // 10+30*40=1210
      final result = exp.parse;
      expect(result.isSuccess, isTrue);
      expect(result.value.compareTo(1210) == 0, isTrue);
    });

    test('expression with arithmetic methods and operators', () {
      var options = {'a': 1, 'b': 2, 'c': 2, 'd': 4};
      final exp = FormulaParser(
          'ADD(a,MUL(b, b))+c^2+SQRT(d)', options); // 1+2*2+(2^2)+sqrt(4)=11
      final result = exp.parse;
      expect(result.isSuccess, isTrue);
      expect(result.value.compareTo(11) == 0, isTrue);
    });
  });
}
