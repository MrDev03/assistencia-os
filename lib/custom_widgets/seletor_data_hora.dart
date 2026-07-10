import 'dart:io';
import 'dart:ui';

import 'package:assistencia_os/pages/configuracoes/components/horario_funcionamento_page.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:win32/win32.dart';

import '../db_helper/db_helper.dart';

class SeletorDataHoraGlobal {
  static Future<DateTime?> selecionar(BuildContext context) async {
    // =========================================================
    // 💻 ROTA WINDOWS E DESKTOPS
    // =========================================================
    // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    //   final theme = Theme.of(context).colorScheme;
    //   final DateTime agora = DateTime.now();
    //
    //   final dataSelecionada = await showDatePicker(
    //     context: context,
    //     initialDate: agora,
    //     firstDate: agora,
    //     lastDate: DateTime(2100),
    //   );
    //
    //   if (dataSelecionada == null || !context.mounted) return null;
    //
    //   final horaSelecionada = await showTimePicker(
    //     context: context,
    //     initialTime: TimeOfDay.now(),
    //   );
    //
    //   if (horaSelecionada == null || !context.mounted) return null;
    //
    //   final dataFinal = DateTime(
    //     dataSelecionada.year,
    //     dataSelecionada.month,
    //     dataSelecionada.day,
    //     horaSelecionada.hour,
    //     horaSelecionada.minute,
    //   );
    //
    //   if (dataFinal.isBefore(DateTime.now())) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: const Text('Selecione um horário no futuro.'),
    //         backgroundColor: theme.error,
    //       ),
    //     );
    //     return null;
    //   }
    //
    //   return dataFinal;
    // }

    // =========================================================
    // 📱 ROTA MOBILE (Modal Customizado Premium)
    // =========================================================
    return await showModalBottomSheet<DateTime>(
      sheetAnimationStyle: const AnimationStyle(
          duration: Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn
      ),
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return const _CustomDateTimePickerModal();
      },
    );
  }
}

// ============================================================================
// O WIDGET CUSTOMIZADO (LÓGICA E UI)
// ============================================================================
class _CustomDateTimePickerModal extends StatefulWidget {
  const _CustomDateTimePickerModal();

  @override
  State<_CustomDateTimePickerModal> createState() => _CustomDateTimePickerModalState();
}

class _CustomDateTimePickerModalState extends State<_CustomDateTimePickerModal> {
  late DateTime _dataSelecionada;
  TimeOfDay? _horaSelecionada;
  String _mensagemErro = '';

  final ScrollController _scrollController = ScrollController();

  final List<DateTime> _diasDisponiveis = List.generate(
    30,
        (index) => DateTime.now().add(Duration(days: index)),
  );

  int horaAbertura = 8; // Abre às 08:00
  int horaFechamento = 18; // Fecha às 18:00
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    final agora = DateTime.now();
    _dataSelecionada = DateTime(agora.year, agora.month, agora.day);
    _carregarDados();
  }

  void _carregarDados () async {
    final empresa = await DatabaseHelper.getEmpresa();

    if (empresa != null) {
      setState(() {
        horaAbertura = empresa.horaAbertura ?? 8;
        horaFechamento = empresa.horaFechamento ?? 18;
        _carregando = true;
      });
    } else {
      setState(() => _carregando = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _isHoje(DateTime data) {
    final agora = DateTime.now();
    return data.year == agora.year && data.month == agora.month && data.day == agora.day;
  }

  List<TimeOfDay> _gerarHorarios() {
    // 🟢 CONFIGURAÇÃO DO HORÁRIO COMERCIAL


    List<TimeOfDay> horarios = [];

    for (int h = horaAbertura; h <= horaFechamento; h++) {
      horarios.add(TimeOfDay(hour: h, minute: 0));
      // Evita criar o horário "18:30" se a loja fecha exatamente às 18:00
      if (h < horaFechamento) {
        horarios.add(TimeOfDay(hour: h, minute: 30));
      }
    }

    // Filtro Anti-Passado (Remove os horários de hoje que já passaram)
    if (_isHoje(_dataSelecionada)) {
      final agora = TimeOfDay.now();
      horarios = horarios.where((t) {
        if (t.hour > agora.hour) return true;
        if (t.hour == agora.hour && t.minute > agora.minute) return true;
        return false;
      }).toList();
    }

    return horarios;
  }

  // Nomes curtos
  String _diaDaSemana(int weekday) {
    const dias = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
    return dias[weekday - 1];
  }

  String _nomeMes(int month) {
    const meses = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];
    return meses[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final horariosDisponiveis = _gerarHorarios();

    final horariosAM = horariosDisponiveis.where((h) => h.hour < 12).toList();
    final horariosPM = horariosDisponiveis.where((h) => h.hour >= 12).toList();

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: theme.surface.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: theme.onSurface.withValues(alpha: 0.1), width: 1.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Column(
              children: [
                // --- CABEÇALHO ---
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 16),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const Text(
                        'Agendar Entrega',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- SEÇÃO 1: DATAS ---
                        Row(
                          children: [
                            _buildSectionTitle('📅 Data',theme),
                            const Spacer(),
                            _carregando ?
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                visualDensity: VisualDensity.compact
                              ),
                              onPressed: () async {
                                final result = await Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const HorarioFuncionamentoPage())
                                );
                                if (result == true) {
                                  _carregarDados();
                                }
                              },
                              label: const Text('Definir Horários'),
                              icon: const Icon(Icons.chevron_right_outlined),
                              iconAlignment: IconAlignment.end,
                            ) : LoadingAnimationWidget.staggeredDotsWave(color: theme.primary, size: 25),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 110,
                          child: RawScrollbar(
                            controller: _scrollController,

                            // 2. Comportamento e Estética Premium
                            thumbVisibility: Platform.isWindows || Platform.isMacOS || Platform.isLinux, // Fica visível por padrão no PC
                            thickness: 8, // Uma barra bem fininha e elegante
                            radius: const Radius.circular(10), // Pontas arredondadas
                            thumbColor: theme.primary.withValues(alpha: 0.4), // Cor translúcida
                            interactive: true, // Permite que o usuário do PC clique e arraste a barra

                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: ListView.builder(

                                controller: _scrollController,

                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: _diasDisponiveis.length,
                                itemBuilder: (context, index) {
                                  final dia = _diasDisponiveis[index];
                                  final isSelecionado = dia.day == _dataSelecionada.day && dia.month == _dataSelecionada.month;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _dataSelecionada = DateTime(dia.year, dia.month, dia.day);
                                        _horaSelecionada = null;
                                        _mensagemErro = '';
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: 75,
                                      margin: const EdgeInsets.symmetric(horizontal: 6),
                                      decoration: BoxDecoration(
                                        color: isSelecionado
                                            ? theme.primary
                                        // Fundo super leve para itens não selecionados
                                            : theme.surfaceContainerHighest.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                          color: isSelecionado
                                              ? theme.primary
                                          // Borda suave para itens não selecionados
                                              : theme.onSurface.withValues(alpha: 0.1),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _diaDaSemana(dia.weekday),
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: isSelecionado ? FontWeight.w600 : FontWeight.normal,
                                              color: isSelecionado ? Colors.white : theme.onSurface.withValues(alpha: 0.6),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            dia.day.toString().padLeft(2, '0'),
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: isSelecionado ? Colors.white : theme.onSurface,
                                            ),
                                          ),
                                          Text(
                                            _nomeMes(dia.month),
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: isSelecionado ? Colors.white.withValues(alpha: 0.9) : theme.onSurface.withValues(alpha: 0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),

                        // --- SEÇÃO 2: OPÇÕES RÁPIDAS (Exibe apenas no dia de Hoje) ---
                        if (_isHoje(_dataSelecionada)) ...[
                          _buildSectionTitle('⚡ Acesso Rápido', /*Icons.bolt_rounded,*/ theme),
                          const SizedBox(height: 12),
                          _buildQuickTimeGrid(theme),
                          const SizedBox(height: 32),
                        ],

                        // --- SEÇÃO 3: HORÁRIOS AM ---
                        _buildSectionTitle('🌄 Manhã', /*Icons.wb_twilight_rounded,*/ theme),
                        const SizedBox(height: 12),
                        horariosAM.isEmpty
                            ? _buildEmptyState('Nenhum horário disponível para a manhã.')
                            : _buildTimeGrid(horariosAM, theme),
                        const SizedBox(height: 32),

                        // --- SEÇÃO 4: HORÁRIOS PM ---
                        _buildSectionTitle('☀️ Tarde / Noite', /*Icons.nightlight_round,*/ theme),
                        const SizedBox(height: 12),
                        horariosPM.isEmpty
                            ? _buildEmptyState('Nenhum horário disponível para a tarde/noite.')
                            : _buildTimeGrid(horariosPM, theme),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                // --- RODAPÉ: BOTÃO CONFIRMAR ---
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
                  ),
                  child: Column(
                    children: [
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        child: _mensagemErro.isNotEmpty
                            ? Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            _mensagemErro,
                            style: TextStyle(color: theme.error, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        )
                            : const SizedBox.shrink(),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (_horaSelecionada == null) {
                              setState(() => _mensagemErro = 'Selecione um horário antes de continuar.');
                              return;
                            }

                            final dataFinal = DateTime(
                              _dataSelecionada.year,
                              _dataSelecionada.month,
                              _dataSelecionada.day,
                              _horaSelecionada!.hour,
                              _horaSelecionada!.minute,
                            );

                            Navigator.pop(context, dataFinal);
                          },
                          child: const Text(
                            'Confirmar Agendamento',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Título das Seções com Ícones
  Widget _buildSectionTitle(String title, /*IconData icon,*/ ColorScheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          //Icon(icon, size: 20, color: theme.primary),
          //const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: theme.onSurface),
          ),
        ],
      ),
    );
  }


  // Grade de Horários Rápidos (Daqui a X horas)
  Widget _buildQuickTimeGrid(ColorScheme theme) {
    final agora = DateTime.now();
    final opcoesRapidas = [
      {'label': 'Daqui 30 minutos', 'time': agora.add(const Duration(minutes: 30))},
      {'label': 'Daqui 1 hora', 'time': agora.add(const Duration(hours: 1))},
      {'label': 'Daqui 1h 30m', 'time': agora.add(const Duration(hours: 1, minutes: 30))},
      {'label': 'Daqui 2 horas', 'time': agora.add(const Duration(hours: 2))},
      {'label': 'Daqui 3 horas', 'time': agora.add(const Duration(hours: 3))},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: opcoesRapidas.map((opcao) {
          final dt = opcao['time'] as DateTime;
          final isSelecionado = _horaSelecionada?.hour == dt.hour &&
              _horaSelecionada?.minute == dt.minute &&
              _dataSelecionada.day == dt.day;

          return InkWell(
            onTap: () {
              setState(() {
                // Altera o dia e a hora simultaneamente para bater com a opção escolhida
                _dataSelecionada = DateTime(dt.year, dt.month, dt.day);
                _horaSelecionada = TimeOfDay(hour: dt.hour, minute: dt.minute);
                _mensagemErro = '';
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: _miniCard(
              isSelecionado,
              theme,
              child: Text(
                opcao['label'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelecionado ? FontWeight.bold : FontWeight.w500,
                  color: isSelecionado ? Colors.white : theme.onSurface,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Grade de Horários Normais (AM e PM)
  Widget _buildTimeGrid(List<TimeOfDay> horarios, ColorScheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: horarios.map((hora) {
          final isSelecionado = _horaSelecionada == hora;
          final String horaFormatada = '${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}';

          return InkWell(
            onTap: () {
              setState(() {
                _horaSelecionada = hora;
                _mensagemErro = '';
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: _miniCard(
              isSelecionado,
              theme,
              child: Text(
                horaFormatada,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelecionado ? FontWeight.bold : FontWeight.w500,
                  color: isSelecionado ? Colors.white : theme.onSurface,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _miniCard (bool isSelected, ColorScheme theme, {required Widget child}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? theme.primary : theme.surfaceContainerHighest.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? theme.primary
              : theme.onSurface.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: child,
    );
  }

  Widget _buildEmptyState(String mensagem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        mensagem,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 14, fontStyle: FontStyle.italic),
      ),
    );
  }
}