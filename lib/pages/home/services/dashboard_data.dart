import '../../../models/cliente_model/cliente_model.dart';
import '../../../models/empresa_model/empresa_model.dart';
import '../../../models/servico_model/servico_model.dart';

class DashboardData {
  final List<Cliente> clientes;
  final List<Servico> servicos;
  final List<Servico> servicosPendentes;
  final Empresa? empresa;
  final bool subscription;

  late final int aguardandoCliente;
  late final int semSolucao;
  late final int emAndamento;
  late final int atrasados;
  late final int entregue;

  DashboardData({
    required this.clientes,
    required this.servicos,
    required this.servicosPendentes,
    required this.empresa,
    required this.subscription,
  }) {
    int c = 0;
    int f = 0;
    int p = 0;
    int a = 0;
    int e = 0;

    for (final s in servicos) {
      switch ((s.status ?? '').toLowerCase()) {
        case 'aguardando cliente':
          c++;
          break;

        case 'sem solução':
          f++;
          break;

        case 'em andamento':
          p++;
          break;

        case 'atrasado':
          a++;
          break;

        case 'entregue':
          e++;
          break;
      }
    }

    aguardandoCliente = c;
    semSolucao = f;
    emAndamento = p;
    atrasados = a;
    entregue = e;
  }
}
