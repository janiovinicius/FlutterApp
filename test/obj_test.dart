import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class Pessoa {
  late int _id;
  String nome;

  Pessoa(this.nome);

  int get id => _id;

  set id(int id) {
    if (id > 0) {
      _id = id;
    } else {
      throw ArgumentError('Identificador deve ser não negativo.');
    }
  }
}

mixin Ano {
  late int _ano;

  int get ano => _ano;

  set ano(int ano) {
    if (ano > 0) {
      _ano = ano;
    } else {
      throw ArgumentError('Ano deve ser não negativo.');
    }
  }
}

class Aluno extends Pessoa with Ano {
  Aluno(super.nome, int ano) {
    this.ano = ano;
  }
}

class Professor extends Pessoa {
  Professor(super.nome);
}

class Disciplina {
  String nome;
  Disciplina(this.nome);
}

class Turma with Ano {
  Disciplina disciplina;
  Professor professor;
  final List<Aluno> _alunos = [];

  Turma(this.disciplina, this.professor, int ano) {
    this.ano = ano;
  }

  void matricular(Aluno aluno) {
    if (aluno.ano == ano) {
      _alunos.add(aluno);
    } else {
      throw ArgumentError('Ano deve ser mesmo.');
    }
  }
}

class Historico extends Turma {
  Map<Aluno, List<double>> notas = {};

  Historico(super.disciplina, super.professor, super.ano);

  @override
  void matricular(Aluno aluno) {
    super.matricular(aluno);
    notas[aluno] = [];
  }

  void adicionarNota(Aluno aluno, double nota) {
    if (nota < 0 || nota > 10) {
      throw ArgumentError('Nota deve estar entre 0 e 10.');
    }
    if (notas.containsKey(aluno)) {
      notas[aluno]!.add(nota);
    } else {
      throw Exception("Aluno não matriculado.");
    }
  }

  double media(Aluno aluno) {
    double media = 0;
    if (!notas.containsKey(aluno) || notas[aluno]!.isEmpty) {
    return 0.0;
    }
    for (double nota in notas[aluno]!) {
      media += nota;
    }
    media /= notas[aluno]!.length;
    return media;
  }

  bool isAprovado(Aluno aluno) {
    return media(aluno) >= 6;
  }
}

void main() {
  test('Testar matrícula de alunos', () {
    Disciplina disciplina1 = Disciplina('Flutter');
    Professor professor1 = Professor('Paulo Junior');
    Historico historico1 = Historico(disciplina1, professor1, 2023);
    // Cadastrar primeiro aluno sem erros
    Aluno aluno1 = Aluno('Maria', 2023);
    aluno1.id = 1;
    historico1.matricular(aluno1);

    expect(historico1.media(aluno1), 0.0);
    // Cadastrar segundo aluno com erros
    Aluno aluno2 = Aluno('Paula', 2022);
    try {
      aluno2.id = 0;
    } catch (error) {
      expect(error, isA<ArgumentError>());
    }
    try {
      historico1.matricular(aluno2);
    } catch (error) {
      expect(error, isA<ArgumentError>());
    }
  });
  test('Testar média dos alunos', () {
    Disciplina disciplina2 = Disciplina('Flutter');
    Professor professor2 = Professor('Paulo Junior');
    Historico historico2 = Historico(disciplina2, professor2, 2023);
    // Cadastrar primeiro aluno sem erros
    Aluno aluno2 = Aluno('Maria', 2023);
    aluno2.id = 1;
    historico2.matricular(aluno2);
    historico2.adicionarNota(aluno2, 10);
    historico2.adicionarNota(aluno2, 7);
    historico2.adicionarNota(aluno2, 6);
    historico2.adicionarNota(aluno2, 9);
    historico2.isAprovado(aluno2);
  
    expect(historico2.media(aluno2), 8);
    expect(historico2.isAprovado(aluno2), true);
  
  
  });
}
