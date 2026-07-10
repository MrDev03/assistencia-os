import 'dart:io';

import 'package:assistencia_os/models/options_model/options_model.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/atendente_model/atendente_model.dart';
import '../models/cliente_model/cliente_model.dart';
import '../models/empresa_model/empresa_model.dart';
import '../models/estoque_pecas_model/estoque_pecas_model.dart';
import '../models/fornecedor_model/fornecedor_model.dart';
import '../models/servico_model/servico_model.dart';
import '../models/tecnicos_model/tecnicos_model.dart';

class DatabaseHelper {
  static late final Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      [
        ClienteSchema,
        ServicoSchema,
        EmpresaSchema,
        AtendenteSchema,
        TecnicosSchema,
        FornecedorSchema,
        CargoSettingsSchema,
        SubscriptionSettingsSchema,
        EstoquePecasSchema,
      ],
      directory: dir.path,
      inspector: true,
    );

  }


  // STREAM DA ASSINATURA
  static Stream<SubscriptionSettings?> watchSubscription() {
    return isar.subscriptionSettings
        .filter()

        .idEqualTo(0) // sempre o mesmo registro
        .watch(fireImmediately: true)
        .map((list) => list.isNotEmpty ? list.first : null);
  }

  static Stream<bool> watchIsPremium() {
    return watchSubscription().map((sub) => sub?.isPremium ?? false);
  }

  // STREAM DA EMPRESA
  static Stream<Empresa?> watchEmpresa() {
    return isar.empresas
        .filter()
        .idEqualTo(1) // sempre o mesmo registro
        .watch(fireImmediately: true)
        .map((list) => list.isNotEmpty ? list.first : null);
  }

  static Stream<List<Cliente>> watchClientes() {
    return isar.clientes
        .where()
        .watch(fireImmediately: true);
  }

  static Stream<List<Servico>> watchServicos() {
    return isar.servicos
        .where()
        .watch(fireImmediately: true);
  }

  static Stream<List<Servico>> watchServicosPendentes() {
    return isar.servicos
        .filter()
        .statusEqualTo("pendente")
        .or()
        .statusEqualTo("atrasado")
        .watch(fireImmediately: true);
  }

  // -------------------- CLIENTES --------------------
  static Future<int> insertCliente(Cliente cliente) async {
    return await isar.writeTxn<int>(() async {
      return await isar.clientes.put(cliente);
    });
  }

  static Future<List<Cliente>> getAllClientes() async {
    return await isar.clientes.where().findAll();
  }

  static Future<Cliente?> getClienteById(int id) async {
    return await isar.clientes.get(id);
  }

  static Future<Cliente?> getClientePorNomeTelefone(String nome, String telefone) async {
    final isar = Isar.getInstance(); // ou Isar.getInstance('default')

    if (isar == null) {
      print("Erro: Isar não inicializado");
      return null;
    }

    return await isar.clientes
        .filter()
        .nomeEqualTo(nome)
        .and()
        .telefoneEqualTo(telefone)
        .findFirst();
  }


  static Future<int> updateCliente(Cliente cliente) async {
    return await isar.writeTxn<int>(() async {
      return await isar.clientes.put(cliente);
    });
  }

  static Future<void> deleteClienteComServicos(int id) async {

    await isar.writeTxn(() async {
      // 🔥 Deleta todos os serviços locais
      await isar.servicos.filter().clienteIdEqualTo(id).deleteAll();

      // 🔥 Agora deleta o cliente local
      await isar.clientes.delete(id);
    });

  }



  // -------------------- SERVICOS --------------------
  // static Future<int> insertServico(Servico servico) async {
  //   return await isar.writeTxn<int>(() async {
  //     return await isar.servicos.put(servico);
  //   });
  // }

  static Future<int> insertServico(Servico servico, int clienteId) async {
    return await isar.writeTxn<int>(() async {
      // Busca o cliente
      final cliente = await isar.clientes.get(clienteId);
      if (cliente == null) throw Exception("Cliente não encontrado");

      // Salva o serviço
      final servicoId = await isar.servicos.put(servico);

      // Vincula o serviço ao cliente
      cliente.servicosLink.add(servico);
      await cliente.servicosLink.save();

      // Também vincula o cliente dentro do serviço (lado inverso do link)
      servico.clienteLink.value = cliente;
      await servico.clienteLink.save();

      return servicoId;
    });
  }

  static Future<List<Servico>> getAllServicos() async {
    return await isar.servicos.where().findAll();
  }

  static Future<List<Servico>> getServicosPorCliente(int clienteId) async {
    final db = isar;

    return await db.servicos
        .filter()
        .clienteIdEqualTo(clienteId)
        .findAll();
  }

  static Future<int> updateServico(Servico servico) async {
    return await isar.writeTxn<int>(() async {
      return await isar.servicos.put(servico);
    });
  }

  static Future<void> deleteServico(int id) async {
    await isar.writeTxn(() async {
      await isar.servicos.delete(id);
    });
  }

  static Future<void> salvarStatusLocal(int id, String novoStatus, String motivo) async {
    await isar.writeTxn(() async {
      final servico = await isar.servicos.get(id);
      if (servico != null) {
        if (["entregue", "sem solução", "aguardando cliente"].contains(novoStatus)) {
          servico.senha = null;
          servico.senhaPadrao = null;
          servico.dataSenha = null;
          servico.dataEntrega = null;
        }
        if (novoStatus == "sem solução") {
          servico.motivo = motivo == "" ? null : motivo;
          servico.status = novoStatus;
        }
        if (novoStatus != "sem solução") {
          servico.status = novoStatus;
          servico.motivo = null;
        }
        await isar.servicos.put(servico);
      }
    });
  }

  // static Future<List<Servico>> getServicosPorStatus(String status) async {
  //   final isar = DatabaseHelper.isar;
  //
  //   // Faz a consulta filtrando pelos status "pendente" ou "atrasado"
  //   final servicos = await isar.servicos
  //       .filter()
  //       .statusEqualTo(status)
  //       .findAll();
  //   return servicos;
  // }


  // -------------------- ATENDENTES --------------------
  static Future<int> insertAtendente(Atendente atendente) async {
    return await isar.writeTxn<int>(() async {
      return await isar.atendentes.put(atendente);
    });
  }

  static Future<List<Atendente>> getAllAtendentes() async {
    return await isar.atendentes.where().findAll();
  }

  static Future<Atendente?> getAtendenteById(int id) async {
    return await isar.atendentes.get(id);
  }

  static Future<int> updateAtendente(Atendente atendente) async {
    return await isar.writeTxn<int>(() async {
      return await isar.atendentes.put(atendente);
    });
  }

  static Future<void> deleteAtendente(int id) async {
    await isar.writeTxn(() async {
      await isar.atendentes.delete(id);
    });
  }


// -------------------- TECNICOS --------------------

  static Future<int> insertTecnico(Tecnicos tecnico) async {
    return await isar.writeTxn<int>(() async {
      return await isar.tecnicos.put(tecnico);
    });
  }

  static Future<List<Tecnicos>> getAllTecnicos() async {
    return await isar.tecnicos.where().findAll();
  }

  static Future<Tecnicos?> getTecnicoById(int id) async {
    return await isar.tecnicos.get(id);
  }

  static Future<int> updateTecnico(Tecnicos tecnico) async {
    return await isar.writeTxn<int>(() async {
      return await isar.tecnicos.put(tecnico);
    });
  }

  static Future<void> deleteTecnico(int id) async {
    await isar.writeTxn(() async {
      await isar.tecnicos.delete(id);
    });
  }


// -------------------- FORNECEDORES --------------------

  static Future<int> insertFornecedor(Fornecedor fornecedor) async {
    return await isar.writeTxn<int>(() async {
      return await isar.fornecedors.put(fornecedor);
    });
  }

  static Future<List<Fornecedor>> getAllFornecedores() async {
    return await isar.fornecedors.where().sortByNome().findAll();
  }

  static Future<Fornecedor?> getFornecedorById(int id) async {
    return await isar.fornecedors.get(id);
  }

  static Future<int> updateFornecedor(Fornecedor fornecedor) async {
    return await isar.writeTxn<int>(() async {
      return await isar.fornecedors.put(fornecedor);
    });
  }

  static Future<void> deleteFornecedor(int id) async {
    await isar.writeTxn(() async {
      await isar.fornecedors.delete(id);
    });
  }


// -------------------- EMPRESA --------------------

  static Future<int> insertEmpresa(Empresa empresa) async {
    return await isar.writeTxn<int>(() async {
      return await isar.empresas.put(empresa);
    });
  }

  static Future<Empresa?> getEmpresa() async {
    return await isar.empresas.get(1);
  }

  static Future<int> updateEmpresa(Empresa empresa) async {
    return await isar.writeTxn<int>(() async {
      return await isar.empresas.put(empresa);
    });
  }

  static Future<void> deleteEmpresa() async {
    await isar.writeTxn(() async {
      await isar.empresas.delete(1);
    });
  }

}






// import 'dart:io';
// import 'package:assistencia_os/models/fornecedor.dart';
// import 'package:path/path.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import '../models/atendentes.dart';
// import '../models/cliente.dart';
// import '../models/empresa.dart';
// import '../models/servico.dart';
// import '../models/tecnicos.dart';
//
// Future<Database> initDB(String fileName) async {
//   int version = 24;
//   if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
//     sqfliteFfiInit();
//     final dbFactory = databaseFactoryFfi;
//     final path = join(Directory.current.path, fileName);
//     return await dbFactory.openDatabase(
//       path,
//       options: OpenDatabaseOptions(
//         version: version,
//         onCreate: _createDB,
//         onUpgrade: _upgradeDB,
//       ),
//     );
//   } else {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, fileName);
//     return await openDatabase(
//       path,
//       version: version,
//       onCreate: _createDB,
//       onUpgrade: _upgradeDB,
//     );
//   }
// }
//
// Future<void> ensureStatusColumn() async {
//   final db_helper = await DatabaseHelper.instance.database;
//
//   final res = await db_helper.rawQuery("PRAGMA table_info(servicos)");
//   final columns = res.map((c) => c['name'].toString()).toList();
//
//   if (!columns.contains('status')) {
//     await db_helper.execute('ALTER TABLE servicos ADD COLUMN status TEXT;');
//   }
// }
//
//
// Future<void> _createDB(Database db_helper, int version) async {
//   await db_helper.execute('''
//       CREATE TABLE clientes (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         nome TEXT NOT NULL,
//         telefone TEXT NOT NULL,
//         cpf TEXT,
//         email TEXT,
//         rua TEXT,
//         numero TEXT,
//         bairro TEXT,
//         cidade TEXT,
//         estado TEXT,
//         cep TEXT,
//         dataCadastro TEXT NOT NULL
//       )
//     ''');
//
//   await db_helper.execute('''
//       CREATE TABLE servicos (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         clienteId INTEGER NOT NULL,
//         modelo TEXT,
//         marca TEXT,
//         problema TEXT,
//         servicos TEXT,
//         garantia TEXT,
//         valor TEXT,
//         senha TEXT,
//         pecaDesc TEXT,
//         valorPeca TEXT,
//         fornecedor TEXT,
//         qualidade TEXT,
//         selectedTFrontal TEXT,
//         selectedTPeca TEXT,
//         dateTime TEXT,
//         modeFornecedor INTEGER,
//         obs TEXT,
//         entrada TEXT,
//         formaPgto TEXT,
//         debitoCredito TEXT,
//         status TEXT,
//         tecnico TEXT,
//         dataEntrega TEXT,
//         FOREIGN KEY (clienteId) REFERENCES clientes (id) ON DELETE CASCADE
//       )
//     ''');
//
//   await db_helper.execute('''
//       CREATE TABLE empresa (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         nome TEXT NOT NULL,
//         cnpj TEXT NOT NULL,
//         telefone1 TEXT NOT NULL,
//         telefone2 TEXT NOT NULL,
//         endereco TEXT NOT NULL,
//         politicaGarantia TEXT NOT NULL,
//         politicaPrivacidade TEXT NOT NULL,
//         logoPath TEXT NOT NULL
//       )
//     ''');
//   await db_helper.execute('''
//       CREATE TABLE atendentes (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         nome TEXT NOT NULL,
//         numero TEXT,
//         dateTimeCadastro TEXT NOT NULL
//       )
//     ''');
//   await db_helper.execute('''
//       CREATE TABLE tecnicos (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         nome TEXT NOT NULL,
//         numero TEXT,
//         dateTimeCadastro TEXT NOT NULL
//       )
//     ''');
//   await db_helper.execute('''
//       CREATE TABLE fornecedores (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         nome TEXT NOT NULL,
//         numero TEXT,
//         dateTimeCadastro TEXT NOT NULL
//       )
//     ''');
// }
//
// Future<void> _upgradeDB(Database db_helper, int oldVersion, int newVersion) async {
//   // Função que adiciona uma coluna se ela não existir
//   Future<void> addColumnIfNotExists(String table, String column, String definition) async {
//     final res = await db_helper.rawQuery("PRAGMA table_info($table)");
//     final columns = res.map((row) => row['name'].toString()).toList();
//     if (!columns.contains(column)) {
//       await db_helper.execute('ALTER TABLE $table ADD COLUMN $column $definition;');
//     }
//   }
//
//   // Cria tabela se não existir
//   Future<void> createTableIfNotExists(String sql) async {
//     await db_helper.execute(sql);
//   }
//
//   // 🔹 Atualiza servicos
//   await addColumnIfNotExists('servicos', 'obs', 'TEXT');
//   await addColumnIfNotExists('servicos', 'entrada', 'TEXT');
//   await addColumnIfNotExists('servicos', 'formaPgto', 'TEXT');
//   await addColumnIfNotExists('servicos', 'debitoCredito', 'TEXT');
//   await addColumnIfNotExists('servicos', 'status', 'TEXT');
//   await addColumnIfNotExists('servicos', 'tecnico', 'TEXT');
//   await addColumnIfNotExists('servicos', 'dataEntrega', 'TEXT');
//
//   // 🔹 Atualiza fornecedores (só numero pode faltar)
//   await addColumnIfNotExists('fornecedores', 'numero', 'TEXT');
//
//   // 🔹 Cria tabelas se não existirem
//   await createTableIfNotExists('''
//     CREATE TABLE IF NOT EXISTS fornecedores (
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       nome TEXT NOT NULL,
//       numero TEXT,
//       dateTimeCadastro TEXT NOT NULL
//     )
//   ''');
//
//   await createTableIfNotExists('''
//     CREATE TABLE IF NOT EXISTS atendentes (
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       nome TEXT NOT NULL,
//       numero TEXT,
//       dateTimeCadastro TEXT NOT NULL
//     )
//   ''');
//
//   await createTableIfNotExists('''
//     CREATE TABLE IF NOT EXISTS tecnicos (
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       nome TEXT NOT NULL,
//       numero TEXT,
//       dateTimeCadastro TEXT NOT NULL
//     )
//   ''');
// }
//
//
// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();
//   static Database? _database;
//
//   DatabaseHelper._init();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await initDB('assistencia.db_helper');
//     return _database!;
//   }
//
//   Future<void> close() async {
//     final db_helper = await instance.database;
//     db_helper.close();
//   }
//
//   // ✅ Criação das tabelas
//
//
//   Future upgradeDB(Database db_helper, int oldVersion, int newVersion) async {
//     if (oldVersion < 5) {
//       await db_helper.execute('ALTER TABLE servicos ADD COLUMN obs TEXT, ADD COLUMN entrada TEXT, ADD COLUMN formaPgto TEXT, ADD COLUMN debitoCredito TEXT');
//     }
//   }
//
//   //   // -------------------- CLIENTES --------------------
// //
//   Future<int> insertCliente(Cliente cliente) async {
//     final db_helper = await instance.database;
//     return await db_helper.insert('clientes', cliente.toMap());
//   }
//
//   Future<List<Cliente>> getAllClientes() async {
//     final db_helper = await instance.database;
//     final result = await db_helper.query('clientes');
//     return result.map((map) => Cliente.fromMap(map)).toList();
//   }
//
//   Future<Cliente?> getClientePorNomeTelefone(String nome, String telefone) async {
//     final db_helper = await instance.database;
//     final result = await db_helper.query(
//       'clientes',
//       where: 'nome = ? AND telefone = ?',
//       whereArgs: [nome, telefone],
//     );
//     if (result.isNotEmpty) {
//       return Cliente.fromMap(result.first);
//     } else {
//       return null;
//     }
//   }
//   Future<Cliente?> getClienteById(int id) async {
//     final db_helper = await database;
//     final maps = await db_helper.query(
//       'clientes',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//     if (maps.isNotEmpty) {
//       return Cliente.fromMap(maps.first);
//     }
//     return null;
//   }
//
//   Future<void> deleteServicosPorCliente(int clienteId) async {
//     final db_helper = await instance.database;
//     await db_helper.delete(
//       'servicos',
//       where: 'clienteId = ?',
//       whereArgs: [clienteId],
//     );
//   }
//
//   Future<int> updateCliente(Cliente cliente) async {
//     final db_helper = await instance.database;
//     return await db_helper.update(
//       'clientes',
//       cliente.toMap(),
//       where: 'id = ?',
//       whereArgs: [cliente.id],
//     );
//   }
//
//   Future<int> deleteCliente(int id) async {
//     final db_helper = await instance.database;
//     return await db_helper.delete(
//       'clientes',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   // -------------------- SERVICOS --------------------
//
//   Future<int> insertServico(Servico servico) async {
//     final db_helper = await instance.database;
//     return await db_helper.insert('servicos', servico.toMap());
//   }
//
//   Future<int> deleteServico(int id) async {
//     final db_helper = await instance.database;
//     return await db_helper.delete(
//       'servicos',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   Future<List<Servico>> getServicosPorCliente(int clienteId) async {
//     final db_helper = await instance.database;
//     final result = await db_helper.query(
//       'servicos',
//       where: 'clienteId = ?',
//       whereArgs: [clienteId],
//     );
//     return result.map((map) => Servico.fromMap(map)).toList();
//   }
//
//   Future<List<Servico>> getAllServicos() async {
//     final db_helper = await instance.database;
//     final result = await db_helper.query('servicos');
//     return result.map((map) => Servico.fromMap(map)).toList();
//   }
//
// // Buscar serviços finalizados (histórico)
//   Future<List<Servico>> getServicosFinalizados() async {
//     final db_helper = await instance.database;
//     final maps = await db_helper.query("servicos", where: "status = ?", whereArgs: ["finalizado"]);
//     return maps.map((e) => Servico.fromMap(e)).toList();
//   }
//
// // Concluir serviço (muda status para finalizado)
//   Future<void> concluirServico(int id) async {
//     final db_helper = await instance.database;
//     await db_helper.update(
//       "servicos",
//       {"status": "finalizado"},
//       where: "id = ?",
//       whereArgs: [id],
//     );
//   }
//
//   Future<int> updateServico(Servico servico) async {
//     final db_helper = await instance.database;
//     return await db_helper.update(
//       'servicos',
//       servico.toMap(),
//       where: 'id = ?',
//       whereArgs: [servico.id],
//     );
//   }
//
//   Future<List<Servico>> getServicosPendentesOuAtrasados() async {
//     final db_helper = await instance.database;
//     final maps = await db_helper.query(
//       "servicos",
//       where: "status = ? OR status = ?",
//       whereArgs: ["pendente", "atrasado"],
//     );
//     return maps.map((e) => Servico.fromMap(e)).toList();
//   }
//
//   // -------------------- EMPRESA --------------------
//
//   // Inserir Empresa
//   Future<int> insertEmpresa(Empresa empresa) async {
//     final db_helper = await instance.database;
//     return await db_helper.insert('empresa', empresa.toMap());
//   }
//
// // Atualizar Empresa
//   Future<int> updateEmpresa(Empresa empresa) async {
//     final db_helper = await instance.database;
//     return await db_helper.update(
//       'empresa',
//       empresa.toMap(),
//       where: 'id = ?',
//       whereArgs: [empresa.id],
//     );
//   }
//
// // Obter Empresa (só terá uma no banco normalmente)
//   Future<Empresa?> getEmpresa() async {
//     final db_helper = await instance.database;
//     final result = await db_helper.query('empresa');
//     if (result.isNotEmpty) {
//       return Empresa.fromMap(result.first);
//     }
//     return null;
//   }
//
//   Future<void> salvarOuAtualizarEmpresa(Empresa empresa) async {
//     final db_helper = await instance.database;
//
//     if (empresa.id != null) {
//       await db_helper.update(
//         'empresa',
//         empresa.toMap(),
//         where: 'id = ?',
//         whereArgs: [empresa.id],
//       );
//     } else {
//       await db_helper.insert('empresa', empresa.toMap());
//     }
//   }
//
//   Future<void> deletarEmpresa() async {
//     final db_helper = await instance.database;
//     await db_helper.delete('empresa');
//   }
//
//   //============= FORNECEDORES =============
//
//   /// 🔹 Inserir fornecedor
//   Future<int> insertFornecedor(Fornecedores fornecedor) async {
//     final db_helper = await instance.database;
//     return await db_helper.insert('fornecedores', fornecedor.toMap());
//   }
//
//   /// 🔹 Buscar todos fornecedores
//   Future<List<Fornecedores>> getFornecedores() async {
//     final db_helper = await instance.database;
//     final result = await db_helper.query('fornecedores', orderBy: "nome ASC");
//     return result.map((map) => Fornecedores.fromMap(map)).toList();
//   }
//
//   /// 🔹 Atualizar fornecedor
//   Future<int> updateFornecedor(Fornecedores fornecedor) async {
//     final db_helper = await instance.database;
//     return await db_helper.update(
//       'fornecedores',
//       fornecedor.toMap(),
//       where: 'id = ?',
//       whereArgs: [fornecedor.id],
//     );
//   }
//
//   /// 🔹 Deletar fornecedor
//   Future<int> deleteFornecedor(int id) async {
//     final db_helper = await instance.database;
//     return await db_helper.delete(
//       'fornecedores',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   /// 🔹 Fechar DB
//   Future closeFornecedores() async {
//     final db_helper = await instance.database;
//     db_helper.close();
//   }
//
//   //============= TECNICOS =============
//
// // 🔹 Inserir técnico
//   Future<int> insertTecnico(Tecnicos tecnico) async {
//     final db_helper = await instance.database;
//     return await db_helper.insert("tecnicos", tecnico.toMap());
//   }
//
//   // 🔹 Buscar todos os técnicos
//   Future<List<Tecnicos>> getTecnicos() async {
//     final db_helper = await instance.database;
//     final result = await db_helper.query("tecnicos", orderBy: "dateTimeCadastro DESC");
//     return result.map((map) => Tecnicos.fromMap(map)).toList();
//   }
//
//   // 🔹 Buscar técnico por ID
//   Future<Tecnicos?> getTecnicoById(String id) async {
//     final db_helper = await instance.database;
//     final result =
//     await db_helper.query("tecnicos", where: "id = ?", whereArgs: [id]);
//
//     if (result.isNotEmpty) {
//       return Tecnicos.fromMap(result.first);
//     }
//     return null;
//   }
//
//   // 🔹 Atualizar técnico
//   Future<int> updateTecnico(Tecnicos tecnico) async {
//     final db_helper = await instance.database;
//     return await db_helper.update(
//       "tecnicos",
//       tecnico.toMap(),
//       where: "id = ?",
//       whereArgs: [tecnico.id],
//     );
//   }
//
//   // 🔹 Deletar técnico
//   Future<int> deleteTecnico(String id) async {
//     final db_helper = await instance.database;
//     return await db_helper.delete("tecnicos", where: "id = ?", whereArgs: [id]);
//   }
//
//   //================== ATENDENTES ===============
//
//   // 🔹 Inserir atendente
//   Future<int> insertAtendente(Atendentes atendente) async {
//     final db_helper = await instance.database;
//     return await db_helper.insert("atendentes", atendente.toMap());
//   }
//
//   Future<List<Atendentes>> getAtendentes() async {
//     final db_helper = await instance.database;
//     final result = await db_helper.query("atendentes", orderBy: "dateTimeCadastro DESC");
//     return result.map((map) => Atendentes.fromMap(map)).toList();
//   }
//
//   Future<Atendentes?> getAtendenteById(String id) async {
//     final db_helper = await instance.database;
//     final result =
//     await db_helper.query("atendentes", where: "id = ?", whereArgs: [id]);
//     if (result.isNotEmpty) {
//       return Atendentes.fromMap(result.first);
//     }
//     return null;
//   }
//
//   Future<int> updateAtendente(Atendentes atendente) async {
//     final db_helper = await instance.database;
//     return await db_helper.update(
//       "atendentes",
//       atendente.toMap(),
//       where: "id = ?",
//       whereArgs: [atendente.id],
//     );
//   }
//
//   Future<int> deleteAtendente(String id) async {
//     final db_helper = await instance.database;
//     return await db_helper.delete("atendentes", where: "id = ?", whereArgs: [id]);
//   }
//
//
// // Aqui você coloca os métodos de CRUD
// // Exatamente como você já tem (insertCliente, getAllClientes, insertServico, etc.)
// // Só remove a parte de _initDB, que agora está nos arquivos separados por plataforma.
// }
