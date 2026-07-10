// import 'package:assistencia_os/pages/serviços/servico_step.dart';
// import 'package:assistencia_os/pages/serviços/cliente_step.dart';
// import 'package:flutter/material.dart';
//
//
// class NovaOS2 extends StatefulWidget {
//   const NovaOS2({super.key});
//
//   @override
//   State<NovaOS2> createState() => _NovaOS2State();
// }
//
// class _NovaOS2State extends State<NovaOS2> with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final nomeController = TextEditingController();
//   final telefoneController = TextEditingController();
//   bool mostrandoCadastroServico = false;
//   int clienteId = 0;
//
//
//   late AnimationController fadeController;
//   late Animation<double> fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     fadeController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     fadeAnimation = CurvedAnimation(
//       parent: fadeController,
//       curve: Curves.easeInOut,
//     );
//     fadeController.forward();
//   }
//
//   @override
//   void dispose() {
//     nomeController.dispose();
//     telefoneController.dispose();
//     fadeController.dispose();
//     super.dispose();
//   }
//
//   void avancar() {
//     if (_formKey.currentState!.validate()) {
//       fadeController.reverse().then((_) {
//         setState(() {
//           mostrandoCadastroServico = true;
//         });
//         fadeController.forward();
//       });
//     }
//   }
//
//   void voltar() {
//     fadeController.reverse().then((_) {
//       setState(() {
//         mostrandoCadastroServico = false;
//       });
//       fadeController.forward();
//     });
//   }
//
//   Widget telaMode () {
//     if(mostrandoCadastroServico == false){
//       return NovaOS();
//     }else{
//       return CadastroServicoPage(clienteId: clienteId);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Nova O.S'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: AnimatedSize(
//           duration: Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//           child: FadeTransition(
//             opacity: fadeAnimation,
//             child: Card(
//               elevation: 8,
//               margin: EdgeInsets.all(16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: telaMode(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// 🔸 Tela 1: Formulário do Cliente
//   Widget _formularioClienteWidget() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Dados do Cliente',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           const SizedBox(height: 16),
//           TextFormField(
//             controller: nomeController,
//             decoration: InputDecoration(
//               labelText: 'Nome',
//               border: OutlineInputBorder(),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Informe o nome';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 16),
//           TextFormField(
//             controller: telefoneController,
//             decoration: InputDecoration(
//               labelText: 'Telefone',
//               border: OutlineInputBorder(),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Informe o telefone';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: avancar,
//             icon: Icon(Icons.arrow_forward),
//             label: Text('Avançar'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// 🔸 Tela 2: Cadastro de Serviço (simulada)
//   Widget cadastroServicoWidget() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           'Cadastro de Serviço',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         const SizedBox(height: 16),
//         TextFormField(
//           decoration: InputDecoration(
//             labelText: 'Descrição do Serviço',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         const SizedBox(height: 16),
//         TextFormField(
//           decoration: InputDecoration(
//             labelText: 'Valor',
//             border: OutlineInputBorder(),
//           ),
//           keyboardType: TextInputType.number,
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             OutlinedButton.icon(
//               onPressed: voltar,
//               icon: Icon(Icons.arrow_back),
//               label: Text('Voltar'),
//             ),
//             ElevatedButton.icon(
//               onPressed: () {
//                 // Aqui você finaliza a OS, salva no banco, etc.
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Ordem de serviço criada!')),
//                 );
//               },
//               icon: Icon(Icons.check),
//               label: Text('Finalizar'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
