import 'package:flutter_test/flutter_test.dart';

bool isPerfect(int num) {
  if (num < 1) return false;
  int sum = 0;
  for (int i = 1; i <= num ~/ 2; i++) {
    if (num % i == 0) {
      sum += i;
    }
  }
  return sum == num;
}

int factorial(int n) {
  if (n < 0) throw ArgumentError('Número deve ser não negativo.');
  int result = 1;
  int i = n;
  while (i > 1) {
    result *= i;
    i--;
  }
  return result;
}

bool isPrime(int num) {
  if (num < 2) return false;
  if (num == 2) return true;
  if (num % 2 == 0) return false;
  for (int i = 3; i * i <= num; i += 2) {
    if (num % i == 0) {
      return false;
    }
    
  }
  return true;
}

int sumOfDigits(int num) {
  if (num < 0) throw ArgumentError('Número deve ser não negativo.');
  List<int> valores = num.toString().split('').map(int.parse).toList();
  int sum = 0;
  for (int i = 0; i < valores.length; i++) {
    sum += valores[i];
  }
  return sum;
}

void main() {
  group('Testes de Número perfeito', () {
    test('Número perfeito 6', () {
      expect(isPerfect(6), isTrue);
    });

    test('Número negativo não deve ser perfeito', () {
      expect(isPerfect(-6), isFalse);
    });
  });
  group('Testes de Fatorial', () {
    test('Fatorial de 5', () {
      expect(factorial(5), equals(120));
    });

    test('Fatorial de número negativo deve lançar erro', () {
      expect(() => factorial(-3), throwsArgumentError);
    });
  });
  group('Testes de Número primo', () {
    test('Número primo 7', () {
      expect(isPrime(7), isTrue);
    });
    test('Número não primo 10', () {
      expect(isPrime(10), isFalse);
    });
  });

  group('Testes de Soma dos dígitos', () {
    test('Soma dos dígitos de 123', () {
      expect(sumOfDigits(123), equals(6));
    });
    test('Soma dos dígitos de -1', () {
      expect(() => sumOfDigits(-1), throwsArgumentError);
    });
  });
}
