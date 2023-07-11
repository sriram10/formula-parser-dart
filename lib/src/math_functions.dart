/// This file contains common mathematical functions and their implementations.
/// It also includes a list of available math functions and their corresponding keys.
/// The [mathFunction] function takes a function name and a list of arguments and returns the result of the function.
/// The [comparisonFunctions], [functionsWithOneBoolArg], [functionsWithOneNumberArg],
/// [functionsWithTwoNumberArg], and [functionsWithOneListArg] maps store the implementations for different functions.
/// Each function implementation is associated with a key.
///
/// Example usage:
/// ```dart
/// dynamic result = mathFunction('add', [2, 3]);
/// print(result); // Output: 5
/// ```

import 'dart:math' as math;

// List of available math functions
final List<String> availableFunctions = [
  ...comparisonFunctions.keys,
  ...functionsWithOneBoolArg.keys,
  ...functionsWithOneNumberArg.keys,
  ...functionsWithTwoNumberArg.keys,
  ...functionsWithOneListArg.keys
];

final comparisonFunctions = {
  'lt': (a, b) => a < b,
  'gt': (a, b) => a > b,
  'lte': (a, b) => a <= b,
  'gte': (a, b) => a >= b,
  'eq': (a, b) => a == b,
  'ne': (a, b) => a != b,
};

final functionsWithOneBoolArg = {
  'not': (bool a) => !a,
};

final functionsWithOneNumberArg = {
  'exp': math.exp,
  'log': math.log,
  'sin': math.sin,
  'asin': math.asin,
  'cos': math.cos,
  'acos': math.acos,
  'tan': math.tan,
  'atan': math.atan,
  'sqrt': math.sqrt,
  'ceil': (num a) => a.ceil(),
  'floor': (num a) => a.floor(),
  'round': (num a) => a.round(),
  'abs': (num a) => a.abs(),
};

final functionsWithTwoNumberArg = {
  'add': (num a, num b) => a + b,
  'sub': (num a, num b) => a - b,
  'mul': (num a, num b) => a * b,
  'divi': (num a, num b) => a / b,
  'power': (num a, num b) => math.pow(a, b),
};

final functionsWithOneListArg = {
  'avg': (List<num> l) {
    num sum = l.fold(0, (num v1, num v2) => v1 + v2);
    return sum / l.length;
  }
};

/// Common mathematical functions.
dynamic mathFunction(String name, List<num> args) {
  if (args.isEmpty) {
    return null;
  }

  final String fnName = name.toLowerCase();

  if (!availableFunctions.contains(fnName)) {
    return null;
  }

  if (args.length == 1 && functionsWithOneNumberArg.keys.contains(fnName)) {
    num v1 = args[0];
    return functionsWithOneNumberArg[fnName]!(v1);
  }

  if (args.length == 2 && comparisonFunctions.keys.contains(fnName)) {
    dynamic v1 = args[0], v2 = args[1];
    return comparisonFunctions[fnName]!(v1, v2);
  }

  if (args.length == 2 && functionsWithTwoNumberArg.keys.contains(fnName)) {
    num v1 = args[0], v2 = args[1];
    return functionsWithTwoNumberArg[fnName]!(v1, v2);
  }

  if (args.isNotEmpty && functionsWithOneListArg.keys.contains(fnName)) {
    return functionsWithOneListArg[fnName]!(args);
  }

  return null;
}
