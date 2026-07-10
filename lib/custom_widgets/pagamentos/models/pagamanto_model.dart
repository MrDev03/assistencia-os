


class PagamantoModel {
  double valorTotal = 0;
  String parcelas = '';

  String valorDigitado = "";
  String valorParceladoSelecionado = '';

  double get valorPago {
    if (valorDigitado.isEmpty) return valorTotal;

    final centavos = int.tryParse(valorDigitado) ?? 0; // tryParse é mais seguro
    return centavos / 100;
  }

  double get troco {
    final t = valorPago - valorTotal;
    return t < 0 ? 0 : t;
  }

  double get restante {
    final r = valorTotal - valorPago;
    return r < 0 ? 0 : r;
  }
}