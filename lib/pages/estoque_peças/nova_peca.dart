import 'dart:io';
import 'package:assistencia_os/custom_widgets/campo_sugestoes.dart';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/dropdown_button_formfield.dart';
import 'package:assistencia_os/custom_widgets/elevated_button.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:isar_community/isar.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../custom_widgets/appbar_btn.dart';
import '../../custom_widgets/auto_complete_descricao.dart';
import '../../custom_widgets/lateral_iconbutom.dart';
import '../../custom_widgets/loading_widget.dart';
import '../../custom_widgets/top_msg.dart';
import '../../models/estoque_pecas_model/estoque_pecas_model.dart';
import '../../sync/modules/estoque_pecas_sync.dart';
import '../listas.dart';
import 'components/codigo_barras_scanner.dart';

class PecaFormScreen extends StatefulWidget {
  final Isar isar;
  final bool isEdit;
  final EstoquePecas? peca;

  const PecaFormScreen({
    super.key,
    required this.isar,
    this.isEdit = false,
    this.peca,
  });

  @override
  State<PecaFormScreen> createState() => _PecaFormScreenState();
}

class _PecaFormScreenState extends State<PecaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: '');


  final EstoquePecasSync _pecaSync = EstoquePecasSync();

  // Controllers
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _tipoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _codigoBarraController = TextEditingController();
  final _valorCustoController = TextEditingController();
  final _valorVendaController = TextEditingController();

   // Controlador do texto
  int _quantidade = 1;
  String? _qualidadeTela;
  bool _isUsada = false;
  bool _isAro = false;
  List<String> _fotosSelecionadas = [];
  final List<String> _listaModelosCompativeis = []; // Lista que será salva
  List<String> _sugestoesModelosDb = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregarSugestoesModelos();

    if (widget.isEdit) {
      _marcaController.text = widget.peca?.marca ?? '';
      _modeloController.text = widget.peca?.modelo ?? '';
      _tipoController.text = widget.peca?.tipo ?? '';
      _descricaoController.text = widget.peca!.descricao ?? '';
      _valorCustoController.text = formatter.format(widget.peca?.valorCusto ?? 0.0).trim();
      _valorVendaController.text = widget.peca?.valorVenda != 0.0 ? formatter.format(widget.peca?.valorVenda ?? 0.0).trim() : '';
      _isUsada = widget.peca?.usada ?? false;
      _isAro = widget.peca?.aro ?? false;
      _qualidadeTela = widget.peca?.qualidadeTela;
      _quantidade = widget.peca?.quantidade ?? 1;
      _codigoBarraController.text = widget.peca?.barCode ?? '';
      _fotosSelecionadas = List.from(widget.peca!.fotosLocal);
      _listaModelosCompativeis.addAll(widget.peca?.modelosCompativeis ?? []);
      print('Fotos selecionadas edit: $_fotosSelecionadas');
    }
  }

  @override
  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _tipoController.dispose();
    _descricaoController.dispose();
    _codigoBarraController.dispose();
    _valorCustoController.dispose();
    _valorVendaController.dispose();
    super.dispose();
  }

  // Função que busca todos os modelos já cadastrados para sugerir
  Future<void> _carregarSugestoesModelos() async {
    // Busca todas as peças (otimização: poderia buscar apenas o campo modelo se o Isar permitisse projeção simples, mas assim funciona bem)
    final todasPecas = await widget.isar.estoquePecas.where().findAll();

    setState(() {
      // 1. Pega o modelo de cada peça
      // 2. Filtra nulos
      // 3. Transforma em Set para remover duplicatas
      // 4. Volta para Lista
      _sugestoesModelosDb = todasPecas
          .map((e) => e.modelo)
          .where((m) => m != null && m.isNotEmpty)
          .cast<String>()
          .toSet()
          .toList();

      // Opcional: Adicionar modelos comuns hardcoded se o banco estiver vazio
      // if (_sugestoesModelosDb.isEmpty) {
      //   _sugestoesModelosDb.addAll(['iPhone 11', 'iPhone 13', 'Galaxy S20', 'Motorola G8']);
      // }
    });
  }

  // --- LÓGICA DE SALVAR NO ISAR ---
  Future<void> _salvarPeca() async {

    if(_tipoController.text == 'Módulo Frontal (Tela)' && _qualidadeTela == null) {
      AppFlushbar.error('A qualidade da tela é obrigatória!');
      return;
    }

    if ((parseDoubleFromText(_valorCustoController.text) > parseDoubleFromText(_valorVendaController.text)) && _valorVendaController.text.isNotEmpty) {
      AppFlushbar.error('O valor de custo não pode ser maior que o valor de venda!');
      return;
    }

    //if (!_formKey.currentState!.validate()) return;
    if (_formKey.currentState!.validate()) {

      final pecaParaSalvar = EstoquePecas()
        ..id = widget.peca?.id ?? Isar.autoIncrement
        ..modelo = _modeloController.text
        ..marca = _marcaController.text
        ..tipo = _tipoController.text
        ..fotosLocal = _fotosSelecionadas
        ..quantidade = _quantidade
        ..usada = _isUsada
        ..descricao = _descricaoController.text
        ..valorCusto = parseDoubleFromText(_valorCustoController.text)
        ..valorVenda = parseDoubleFromText(_valorVendaController.text)
        ..modelosCompativeis = _listaModelosCompativeis
        ..barCode = _codigoBarraController.text
        ..qualidadeTela = _qualidadeTela == '' ? null : _qualidadeTela
        ..dataCadastro = widget.peca?.dataCadastro ?? DateTime.now()
        ..dataUltimaAtualizacao = DateTime.now()
        ..aro = _isAro;

      await widget.isar.writeTxn(() async {
        await widget.isar.estoquePecas.put(pecaParaSalvar);
      });

      try {
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const LoadingWidget(
            message: [
              'Salvando peça',
              'Sincronizando',
              'Aguarde...'
            ],
          ),
        );
        await _pecaSync.push(pecaParaSalvar);

        if (!mounted) return;

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(widget.peca != null ? 'Peça atualizada com sucesso!' : 'Peça cadastrada com sucesso!'
        //     ),
        //     backgroundColor: Colors.green,
        //   ),
        // );

        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pop(context);

        AppFlushbar.success(widget.peca != null ? 'Peça atualizada com sucesso!' : 'Peça cadastrada com sucesso!');


      } catch (e) {

        if (!mounted) return;

        AppFlushbar.error(e.toString());
      }
    }
  }

  // --- LÓGICA DE SELEÇÃO DE FOTOS ---
  Future<void> _adicionarFoto() async {
    const int limiteMaximo = 4;
    final vagas = limiteMaximo - _fotosSelecionadas.length;

    if (vagas <= 0) {
      AppFlushbar.error('Limite máximo de 4 fotos atingido.');
      return;
    }

    try {

      final picker = ImagePicker();

      final List<XFile> images = await picker.pickMultiImage(
        limit: vagas,
        imageQuality: 70,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (images.isEmpty || !mounted) return;

      // 🔹 loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => LoadingWidget(message: ['Carregando ${images.length} foto...'])
      );

      List<String> novosCaminhos = [];

      for (final image in images) {
        if ((_fotosSelecionadas.length + novosCaminhos.length) >= limiteMaximo) {
          break;
        }

        try {
          String caminhoSeguro = await salvarImagemComprimidaLocal(
            arquivoOriginal: image.path,
          );

          novosCaminhos.add(caminhoSeguro);
        } catch (e) {
          AppFlushbar.error('Erro ao salvar imagem: $e');
        }
      }

      if (!mounted) return;

      Navigator.of(context, rootNavigator: true).pop(); // fecha loading

      if (novosCaminhos.isEmpty) return;

      setState(() {
        _fotosSelecionadas.addAll(novosCaminhos);
      });

    } catch (e) {

      AppFlushbar.error('Erro ao selecionar imagens: $e');

    }
  }



  void _removerFoto(int index) {
    setState(() {
      _fotosSelecionadas.removeAt(index);
    });
  }

  double parseDoubleFromText(String text, {double defaultValue = 0.0}) {
    if (text.trim().isEmpty) return defaultValue;

    final cleaned = text
        .replaceAll(RegExp(r'[^\d,.-]'), '') // remove R$, espaços, etc
        .replaceAll('.', '')                  // remove separador de milhar
        .replaceAll(',', '.');                // vírgula → ponto

    return double.tryParse(cleaned) ?? defaultValue;
  }

  Future<String> salvarImagemComprimidaLocal({
    required String arquivoOriginal,
  }) async {

    final origem = File(arquivoOriginal);

    if (!await origem.exists()) {
      AppFlushbar.error('Arquivo não encontrado');
      throw Exception('Arquivo não encontrado');
    }

    final bytes = await origem.readAsBytes();
    final decoded = img.decodeImage(bytes);

    if (decoded == null) {
      AppFlushbar.error('Erro ao decodificar imagem');
      throw Exception('Erro ao decodificar imagem');
    }

    final fixed = img.bakeOrientation(decoded);

    final resized = fixed.width > 1080
        ? img.copyResize(fixed, width: 1080)
        : fixed;

    final jpg = img.encodeJpg(resized, quality: 50);

    final dir = await getApplicationDocumentsDirectory();

    // 📁 pasta personalizada
    final pasta = Directory(
      p.join(dir.path, 'AssistenciaOS', 'imagens'),
    );

    await pasta.create(recursive: true);

    final nome = DateTime.now().millisecondsSinceEpoch.toString();

    final caminhoFinal = p.join(pasta.path, '$nome.jpg');

    final arquivoLocal = File(caminhoFinal);

    await arquivoLocal.writeAsBytes(jpg, flush: true);

    return arquivoLocal.path;
  }



  @override
  Widget build(BuildContext context) {
    // Usando Theme e ColorScheme para consistência
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Editar Peça' : 'Nova Peça',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
        )
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- ÁREA DE FOTOS (ATÉ 3) ---
              _buildSectionTitle(theme, 'Fotos (${_fotosSelecionadas.length}/3)'),
              const SizedBox(height: 12),
              CustomCard(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 120,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Gera um card para cada foto selecionada
                        ...List.generate(_fotosSelecionadas.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: _buildFotoCard(index, colorScheme),
                          );
                        }),

                        // Mostra o botão de adicionar se tiver menos de 3 fotos
                        if (_fotosSelecionadas.length < 3)
                          _buildAddFotoButton(colorScheme),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // --- INFORMAÇÕES BÁSICAS ---
              _buildSectionTitle(theme, 'Informações da Peça'),
              const SizedBox(height: 16),

              CustomCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: CustomTextField(
                            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                            controller: _codigoBarraController, // Certifique-se de ter criado esse controller
                            labelText: 'Código de Barras / SKU', // Ajustei o label para fazer sentido
                            hintText: 'Escaneie ou digite...',
                          ),
                        ),
                        LateralIconbutom(
                          icon: const Icon(CupertinoIcons.barcode_viewfinder), // Ícone de mira/scan
                          tooltip: 'Ler Código de Barras',
                          onPressed: _lerCodigoBarras, // Chama a função criada acima
                          //color: Theme.of(context).colorScheme.primary, // Usa a cor do tema
                        ),
                      ],
                    ),

                    ModeloAutoCompleteField(
                      isar: widget.isar,
                      controller: _modeloController, // O seu controller existente
                      label: 'Modelo do Aparelho',
                      validator: (val) => val == null || val.isEmpty ? 'Modelo obrigatório' : null,
                    ),

                    // CustomTextField(
                    //   controller: _modeloController,
                    //   labelText: 'Modelo',
                    //   hintText: 'Ex: Galaxy S23, XT-600...',
                    //   validator: (val) => val == null || val.isEmpty ? 'Modelo obrigatório' : null,
                    // ),

                    AutoCompleteDescricao( // <--- Substitua aqui
                      tipoController: _tipoController,
                      descricaoController: _descricaoController,
                      validator: (val) => val == null || val.isEmpty ? 'O nome da peça é obrigatório' : null,
                    ), // <--- Substitua aqui


                    ValueListenableBuilder(
                        valueListenable: _tipoController,
                        builder: (context, value, child) {

                          if (!value.text.contains('Módulo Frontal (Tela)')) return const SizedBox.shrink();

                          return CustomDBFF(
                            initialValue: _qualidadeTela,
                            labelText: 'Qualidade da Tela',

                            items: qualidade.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _qualidadeTela = val!;
                              });
                            }, suffixIcon: null,
                          );
                        }
                    ),

                    CustomTextField(
                        controller: _descricaoController,
                        labelText: 'Descrição',
                        hintText: 'Descreva sobre a peça'
                    ),

                    CustomTextField(
                      controller: _valorCustoController,
                      labelText: 'Valor de Custo',
                      hintText: '',
                      prefix: const Text('R\$ '),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CentavosInputFormatter(),
                      ],
                      validator: (val) {
                        final valor = parseDoubleFromText(val!);
                        if ((val == '0.0' || val.isEmpty) && !_isUsada) return 'O valor de custo é obrigatório.';
                        return null;
                      },
                    ),

                    CustomTextField(
                      controller: _valorVendaController,
                      labelText: 'Valor de Venda (Colocada)',
                      hintText: '',
                      prefix: const Text('R\$ '),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CentavosInputFormatter(),
                      ],
                      validator: (val) {
                        final valor = parseDoubleFromText(val!);
                        if (val == '0.0' || val.isEmpty) return 'O valor de venda é obrigatório.';
                        return null;
                      },
                    ),

                    SG(
                      selecionados: _listaModelosCompativeis,
                      sugestoes: _sugestoesModelosDb,
                      labelText: 'Modelos Compatíveis',
                      hintText: 'Ex: iPhone 12, iPhone 12 Pro...',
                      //controller: _compatibilidadeController,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // --- DETALHES E ESTADO ---
              _buildSectionTitle(theme, 'Especificações'),

              const SizedBox(height: 16),

              Row(
                children: [
                  _buildChoiceChip(
                    label: 'Peça Usada',
                    isSelected: _isUsada,
                    onSelected: (val) => setState(() => _isUsada = val),
                    icon: Icons.history,
                  ),
                  const SizedBox(width: 12),

                  ValueListenableBuilder(
                    valueListenable: _tipoController,
                    builder: (context, value, child) {

                      if (!value.text.contains('Módulo Frontal (Tela)')) return const SizedBox.shrink();

                      return _buildChoiceChip(
                        label: 'Com Aro',
                        isSelected: _isAro,
                        onSelected: (val) => setState(() => _isAro = val),
                        icon: Icons.phonelink_setup_rounded, // Ícone alternativo se Framerate não existir
                      );
                    }
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // --- QUANTIDADE EM ESTOQUE ---
              _buildSectionTitle(theme, 'Estoque Inicial'),
              const SizedBox(height: 16),
              _buildQuantitySelector(colorScheme),

              const SizedBox(height: 48),

              // --- BOTÃO SALVAR ---
              CustomElevatedButton(
                click: _salvarPeca,
                label: widget.isEdit ? 'Atualizar' : 'Cadastrar no Estoque',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES (Design System) ---

  // Card que exibe a foto selecionada com opção de remover
  Widget _buildFotoCard(int index, ColorScheme colorScheme) {
    return Stack(
      children: [
      Container(
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: _fotosSelecionadas[index].startsWith('http')
              ? NetworkImage(_fotosSelecionadas[index])
              : FileImage(File(_fotosSelecionadas[index])) as ImageProvider,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => _removerFoto(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  // Botão quadrado pontilhado para adicionar
  Widget _buildAddFotoButton(ColorScheme colorScheme) {
    return GestureDetector(
      onTap: _adicionarFoto,
      child: Container(
        width: 100,
        height: 120,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.2),
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo, color: colorScheme.primary),
            const SizedBox(height: 4),
            Text(
              'Adicionar\nFoto',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: colorScheme.primary, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _lerCodigoBarras() async {

    if (Platform.isWindows) {
      AppFlushbar.error('Indisponível no momento');
      return;
    }

    // Navega para a tela de scanner e aguarda o resultado (String?)
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const ScannerScreen(),
      ),
    );

    // Se o usuário voltou sem escanear, result será null.
    // Se escaneou, result será o código.
    if (result != null && mounted) {
      setState(() {
        _codigoBarraController.text = result;
      });

      // Feedback visual (opcional)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Código lido: $result'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }


  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onPrimaryContainer
      )
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool isSelected,
    required Function(bool) onSelected,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      avatar: isSelected
          ? null // Remove ícone quando selecionado para visual mais limpo (opcional)
          : Icon(icon, size: 16, color: colorScheme.primary),
      selectedColor: colorScheme.primary,
      checkmarkColor: colorScheme.onPrimary,
      labelStyle: TextStyle(
        color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(
          color: isSelected ? Colors.transparent : colorScheme.outline.withValues(alpha: 0.3)
      ),
      showCheckmark: true,
    );
  }

  Widget _buildQuantitySelector(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => setState(() => _quantidade > 0 ? _quantidade-- : null),
            icon: const Icon(Icons.remove_circle_outline),
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              _quantidade.toString().padLeft(2, '0'),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _quantidade++),
            icon: const Icon(Icons.add_circle_outline),
            color: Colors.greenAccent.shade700,
          ),
        ],
      ),
    );
  }

}
