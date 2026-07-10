import 'dart:io';

import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/elevated_button.dart';
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:assistencia_os/db_helper/db_helper.dart';
import 'package:assistencia_os/sync/modules/empresa_sync.dart';
import 'package:flutter/material.dart';

import '../../../custom_widgets/appbar_btn.dart';
import '../../../custom_widgets/loading_widget.dart';
import '../../../db_helper/empresa_helper.dart';
import '../../../models/empresa_model/empresa_model.dart';
import '../../home/home.dart';
// import '../../models/empresa_model.dart';
// import '../../db_helper/empresa_helper.dart';

class HorarioFuncionamentoPage extends StatefulWidget {
  final bool configPage;
  const HorarioFuncionamentoPage({super.key, this.configPage = false});

  @override
  State<HorarioFuncionamentoPage> createState() => _HorarioFuncionamentoPageState();
}

class _HorarioFuncionamentoPageState extends State<HorarioFuncionamentoPage> {
  // Valores padrão
  int _horaAbertura = 8;
  int _horaFechamento = 18;
  bool _houveAlteracao = false;
  bool _carregando = false;
  EmpresaSync empresaSync = EmpresaSync();

  @override
  void initState() {
    super.initState();
    _carregarHorarios();
  }

  Future<void> _carregarHorarios() async {
    // Exemplo de leitura do banco:
    final empresa = await DatabaseHelper.getEmpresa();
    if (empresa != null) {
      setState(() {
        _horaAbertura = empresa.horaAbertura ?? 8;
        _horaFechamento = empresa.horaFechamento ?? 18;
      });
    }
  }

  Future<void> _salvarHorarios(BuildContext dialogContext) async {
    if (_horaAbertura >= _horaFechamento) {
      AppFlushbar.error('A hora de abertura deve ser menor que a de fechamento.');
      return;
    }

    setState(() => _carregando = true);

    // 1. Mostra o dialog de loading
    showDialog(
      context: dialogContext,
      barrierDismissible: false,
      builder: (_) => const LoadingWidget(
        message: ['Sincronizando', 'Aguarde...'],
      ),
    );

    try {
      final empresa = Empresa();
      //if (empresa == null) throw Exception('Empresa não encontrada localmente.');

      // 2. Atualiza os dados na memória
      empresa.horaAbertura = _horaAbertura;
      empresa.horaFechamento = _horaFechamento;

      // 3. Marca como pendente de sincronização (Offline-first)
      empresa.isDirty = true;

      // 4. Salva no banco local (Isar) PRIMEIRO.
      // Assim, se a internet cair 1 segundo depois, o dado do usuário já está seguro.
      await DatabaseHelper.updateEmpresa(empresa);

      // 5. Tenta enviar para a nuvem
      await empresaSync.push(empresa);

      // 6. Se a linha acima não gerou erro, a internet funcionou.
      // Opcional: Se o seu `empresaSync.push` não alterar o isDirty internamente,
      // nós desmarcamos ele aqui e atualizamos o banco local novamente.
      empresa.isDirty = false;
      await DatabaseHelper.updateEmpresa(empresa);

      AppFlushbar.success('Horários salvos com sucesso!');

    } catch (e) {
      // 7. Se falhar (ex: sem internet), cai aqui.
      // O app não trava e informamos que foi salvo localmente.
      AppFlushbar.success('Salvo localmente! Será sincronizado assim que houver conexão.');

      // print('Erro ao sincronizar: $e'); // Para o seu debug
    } finally {
      // 8. O bloco 'finally' SEMPRE executa, dando erro ou não no 'try'.
      // É o lugar ideal para garantir que o Loading vai fechar.

      if (mounted) {
        setState(() => _carregando = false);
      }

      // Fecha o LoadingWidget com segurança
      if (dialogContext.mounted && Navigator.canPop(dialogContext)) {
        Navigator.pop(dialogContext);
      }

      // Volta para a tela anterior
      if (mounted) {
        if (Platform.isWindows) {

        } else {
          Navigator.pop(context, true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.configPage && context.isDesktop ? null : AppBar(
        title: const Text('Horário Padrão'),
        leading: AppbarBtn(
          onPressed: () {
            if (_houveAlteracao) {
              Navigator.pop(context, true);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Defina o horário de atendimento para agendamentos e previsão de entrega de OS.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // ABERTURA
                    _buildHorarioTile(
                      context: context,
                      icon: Icons.wb_sunny_rounded,
                      iconColor: Colors.orange,
                      title: 'Abertura',
                      value: _horaAbertura,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _horaAbertura = value;
                            _houveAlteracao = true;
                          });
                        }
                      },
                    ),

                    // DIVISOR INTERNO (Estilo Apple, com recuo à esquerda)
                    Divider(height: 1, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2)),

                    // FECHAMENTO
                    _buildHorarioTile(
                      context: context,
                      icon: Icons.nightlight_round,
                      iconColor: Colors.indigo,
                      title: 'Fechamento',
                      value: _horaFechamento,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _horaFechamento = value;
                            _houveAlteracao = true;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(),
        
              // BOTÃO SALVAR
              CustomElevatedButton(
                click: _houveAlteracao ? () => _salvarHorarios(context) : null,
                label: 'Salvar Horários'
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildHorarioTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required int value,
    required ValueChanged<int?> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.all(15),
      // Ícone com fundo colorido e bordas arredondadas
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      // Dropdown em formato de "Chip/Pill"
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: value,
            icon: Icon(
              Icons.expand_more_rounded,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              size: 20,
            ),
            isDense: true,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            dropdownColor: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            // Gera a lista de 0 a 23 com formatação de 2 dígitos
            items: List.generate(24, (index) {
              return DropdownMenuItem(
                value: index,
                child: Text('${index.toString().padLeft(2, '0')}:00'),
              );
            }),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}