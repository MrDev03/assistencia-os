// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servico_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetServicoCollection on Isar {
  IsarCollection<Servico> get servicos => this.collection();
}

const ServicoSchema = CollectionSchema(
  name: r'Servico',
  id: -8725635563120208664,
  properties: {
    r'acessorios': PropertySchema(
      id: 0,
      name: r'acessorios',
      type: IsarType.string,
    ),
    r'atendente': PropertySchema(
      id: 1,
      name: r'atendente',
      type: IsarType.string,
    ),
    r'clienteId': PropertySchema(
      id: 2,
      name: r'clienteId',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'data': PropertySchema(id: 4, name: r'data', type: IsarType.string),
    r'dataEntrega': PropertySchema(
      id: 5,
      name: r'dataEntrega',
      type: IsarType.string,
    ),
    r'dataSenha': PropertySchema(
      id: 6,
      name: r'dataSenha',
      type: IsarType.dateTime,
    ),
    r'debitoCredito': PropertySchema(
      id: 7,
      name: r'debitoCredito',
      type: IsarType.string,
    ),
    r'entrada': PropertySchema(id: 8, name: r'entrada', type: IsarType.string),
    r'formaPgto1': PropertySchema(
      id: 9,
      name: r'formaPgto1',
      type: IsarType.string,
    ),
    r'formaPgto2': PropertySchema(
      id: 10,
      name: r'formaPgto2',
      type: IsarType.string,
    ),
    r'fornecedor': PropertySchema(
      id: 11,
      name: r'fornecedor',
      type: IsarType.string,
    ),
    r'garantia': PropertySchema(
      id: 12,
      name: r'garantia',
      type: IsarType.string,
    ),
    r'itensBons': PropertySchema(
      id: 13,
      name: r'itensBons',
      type: IsarType.stringList,
    ),
    r'itensRuins': PropertySchema(
      id: 14,
      name: r'itensRuins',
      type: IsarType.stringList,
    ),
    r'marca': PropertySchema(id: 15, name: r'marca', type: IsarType.string),
    r'modelo': PropertySchema(id: 16, name: r'modelo', type: IsarType.string),
    r'motivo': PropertySchema(id: 17, name: r'motivo', type: IsarType.string),
    r'nomeCliente': PropertySchema(
      id: 18,
      name: r'nomeCliente',
      type: IsarType.string,
    ),
    r'obs': PropertySchema(id: 19, name: r'obs', type: IsarType.string),
    r'parcelas1': PropertySchema(
      id: 20,
      name: r'parcelas1',
      type: IsarType.string,
    ),
    r'parcelas2': PropertySchema(
      id: 21,
      name: r'parcelas2',
      type: IsarType.string,
    ),
    r'pecasUtilizadas': PropertySchema(
      id: 22,
      name: r'pecasUtilizadas',
      type: IsarType.string,
    ),
    r'problema': PropertySchema(
      id: 23,
      name: r'problema',
      type: IsarType.string,
    ),
    r'qualidadeFrontal': PropertySchema(
      id: 24,
      name: r'qualidadeFrontal',
      type: IsarType.string,
    ),
    r'senha': PropertySchema(id: 25, name: r'senha', type: IsarType.string),
    r'senhaPadrao': PropertySchema(
      id: 26,
      name: r'senhaPadrao',
      type: IsarType.string,
    ),
    r'servicos': PropertySchema(
      id: 27,
      name: r'servicos',
      type: IsarType.string,
    ),
    r'status': PropertySchema(id: 28, name: r'status', type: IsarType.string),
    r'tecnico': PropertySchema(id: 29, name: r'tecnico', type: IsarType.string),
    r'tipoDeAparelho': PropertySchema(
      id: 30,
      name: r'tipoDeAparelho',
      type: IsarType.string,
    ),
    r'tipoDeFrontal': PropertySchema(
      id: 31,
      name: r'tipoDeFrontal',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 32,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'valor': PropertySchema(id: 33, name: r'valor', type: IsarType.string),
    r'valor1Double': PropertySchema(
      id: 34,
      name: r'valor1Double',
      type: IsarType.double,
    ),
    r'valor2': PropertySchema(id: 35, name: r'valor2', type: IsarType.double),
    r'valorAcessorios': PropertySchema(
      id: 36,
      name: r'valorAcessorios',
      type: IsarType.string,
    ),
    r'valorOriginalServicoDouble': PropertySchema(
      id: 37,
      name: r'valorOriginalServicoDouble',
      type: IsarType.double,
    ),
    r'valorPeca': PropertySchema(
      id: 38,
      name: r'valorPeca',
      type: IsarType.string,
    ),
    r'valorSomado': PropertySchema(
      id: 39,
      name: r'valorSomado',
      type: IsarType.string,
    ),
    r'valorTotalAcessoriosDouble': PropertySchema(
      id: 40,
      name: r'valorTotalAcessoriosDouble',
      type: IsarType.double,
    ),
    r'valorTotalCustoPecasDouble': PropertySchema(
      id: 41,
      name: r'valorTotalCustoPecasDouble',
      type: IsarType.double,
    ),
  },

  estimateSize: _servicoEstimateSize,
  serialize: _servicoSerialize,
  deserialize: _servicoDeserialize,
  deserializeProp: _servicoDeserializeProp,
  idName: r'id',
  indexes: {
    r'clienteId': IndexSchema(
      id: 8548357859431292524,
      name: r'clienteId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'clienteId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {
    r'clienteLink': LinkSchema(
      id: 8423784700112701813,
      name: r'clienteLink',
      target: r'Cliente',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _servicoGetId,
  getLinks: _servicoGetLinks,
  attach: _servicoAttach,
  version: '3.3.0',
);

int _servicoEstimateSize(
  Servico object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.acessorios;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.atendente;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.data;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.dataEntrega;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.debitoCredito;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.entrada;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.formaPgto1.length * 3;
  bytesCount += 3 + object.formaPgto2.length * 3;
  {
    final value = object.fornecedor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.garantia;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.itensBons.length * 3;
  {
    for (var i = 0; i < object.itensBons.length; i++) {
      final value = object.itensBons[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.itensRuins.length * 3;
  {
    for (var i = 0; i < object.itensRuins.length; i++) {
      final value = object.itensRuins[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.marca;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.modelo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.motivo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nomeCliente;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.obs;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.parcelas1.length * 3;
  bytesCount += 3 + object.parcelas2.length * 3;
  {
    final value = object.pecasUtilizadas;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.problema;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.qualidadeFrontal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.senha;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.senhaPadrao;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.servicos;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tecnico;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tipoDeAparelho;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tipoDeFrontal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.valor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.valorAcessorios;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.valorPeca;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.valorSomado;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _servicoSerialize(
  Servico object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.acessorios);
  writer.writeString(offsets[1], object.atendente);
  writer.writeLong(offsets[2], object.clienteId);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.data);
  writer.writeString(offsets[5], object.dataEntrega);
  writer.writeDateTime(offsets[6], object.dataSenha);
  writer.writeString(offsets[7], object.debitoCredito);
  writer.writeString(offsets[8], object.entrada);
  writer.writeString(offsets[9], object.formaPgto1);
  writer.writeString(offsets[10], object.formaPgto2);
  writer.writeString(offsets[11], object.fornecedor);
  writer.writeString(offsets[12], object.garantia);
  writer.writeStringList(offsets[13], object.itensBons);
  writer.writeStringList(offsets[14], object.itensRuins);
  writer.writeString(offsets[15], object.marca);
  writer.writeString(offsets[16], object.modelo);
  writer.writeString(offsets[17], object.motivo);
  writer.writeString(offsets[18], object.nomeCliente);
  writer.writeString(offsets[19], object.obs);
  writer.writeString(offsets[20], object.parcelas1);
  writer.writeString(offsets[21], object.parcelas2);
  writer.writeString(offsets[22], object.pecasUtilizadas);
  writer.writeString(offsets[23], object.problema);
  writer.writeString(offsets[24], object.qualidadeFrontal);
  writer.writeString(offsets[25], object.senha);
  writer.writeString(offsets[26], object.senhaPadrao);
  writer.writeString(offsets[27], object.servicos);
  writer.writeString(offsets[28], object.status);
  writer.writeString(offsets[29], object.tecnico);
  writer.writeString(offsets[30], object.tipoDeAparelho);
  writer.writeString(offsets[31], object.tipoDeFrontal);
  writer.writeDateTime(offsets[32], object.updatedAt);
  writer.writeString(offsets[33], object.valor);
  writer.writeDouble(offsets[34], object.valor1Double);
  writer.writeDouble(offsets[35], object.valor2);
  writer.writeString(offsets[36], object.valorAcessorios);
  writer.writeDouble(offsets[37], object.valorOriginalServicoDouble);
  writer.writeString(offsets[38], object.valorPeca);
  writer.writeString(offsets[39], object.valorSomado);
  writer.writeDouble(offsets[40], object.valorTotalAcessoriosDouble);
  writer.writeDouble(offsets[41], object.valorTotalCustoPecasDouble);
}

Servico _servicoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Servico();
  object.acessorios = reader.readStringOrNull(offsets[0]);
  object.atendente = reader.readStringOrNull(offsets[1]);
  object.clienteId = reader.readLongOrNull(offsets[2]);
  object.createdAt = reader.readDateTimeOrNull(offsets[3]);
  object.data = reader.readStringOrNull(offsets[4]);
  object.dataEntrega = reader.readStringOrNull(offsets[5]);
  object.dataSenha = reader.readDateTimeOrNull(offsets[6]);
  object.debitoCredito = reader.readStringOrNull(offsets[7]);
  object.entrada = reader.readStringOrNull(offsets[8]);
  object.formaPgto1 = reader.readString(offsets[9]);
  object.formaPgto2 = reader.readString(offsets[10]);
  object.fornecedor = reader.readStringOrNull(offsets[11]);
  object.garantia = reader.readStringOrNull(offsets[12]);
  object.id = id;
  object.itensBons = reader.readStringList(offsets[13]) ?? [];
  object.itensRuins = reader.readStringList(offsets[14]) ?? [];
  object.marca = reader.readStringOrNull(offsets[15]);
  object.modelo = reader.readStringOrNull(offsets[16]);
  object.motivo = reader.readStringOrNull(offsets[17]);
  object.nomeCliente = reader.readStringOrNull(offsets[18]);
  object.obs = reader.readStringOrNull(offsets[19]);
  object.parcelas1 = reader.readString(offsets[20]);
  object.parcelas2 = reader.readString(offsets[21]);
  object.pecasUtilizadas = reader.readStringOrNull(offsets[22]);
  object.problema = reader.readStringOrNull(offsets[23]);
  object.qualidadeFrontal = reader.readStringOrNull(offsets[24]);
  object.senha = reader.readStringOrNull(offsets[25]);
  object.senhaPadrao = reader.readStringOrNull(offsets[26]);
  object.servicos = reader.readStringOrNull(offsets[27]);
  object.status = reader.readStringOrNull(offsets[28]);
  object.tecnico = reader.readStringOrNull(offsets[29]);
  object.tipoDeAparelho = reader.readStringOrNull(offsets[30]);
  object.tipoDeFrontal = reader.readStringOrNull(offsets[31]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[32]);
  object.valor = reader.readStringOrNull(offsets[33]);
  object.valor1Double = reader.readDoubleOrNull(offsets[34]);
  object.valor2 = reader.readDoubleOrNull(offsets[35]);
  object.valorAcessorios = reader.readStringOrNull(offsets[36]);
  object.valorOriginalServicoDouble = reader.readDoubleOrNull(offsets[37]);
  object.valorPeca = reader.readStringOrNull(offsets[38]);
  object.valorSomado = reader.readStringOrNull(offsets[39]);
  object.valorTotalAcessoriosDouble = reader.readDoubleOrNull(offsets[40]);
  object.valorTotalCustoPecasDouble = reader.readDoubleOrNull(offsets[41]);
  return object;
}

P _servicoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringList(offset) ?? []) as P;
    case 14:
      return (reader.readStringList(offset) ?? []) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (reader.readStringOrNull(offset)) as P;
    case 28:
      return (reader.readStringOrNull(offset)) as P;
    case 29:
      return (reader.readStringOrNull(offset)) as P;
    case 30:
      return (reader.readStringOrNull(offset)) as P;
    case 31:
      return (reader.readStringOrNull(offset)) as P;
    case 32:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 33:
      return (reader.readStringOrNull(offset)) as P;
    case 34:
      return (reader.readDoubleOrNull(offset)) as P;
    case 35:
      return (reader.readDoubleOrNull(offset)) as P;
    case 36:
      return (reader.readStringOrNull(offset)) as P;
    case 37:
      return (reader.readDoubleOrNull(offset)) as P;
    case 38:
      return (reader.readStringOrNull(offset)) as P;
    case 39:
      return (reader.readStringOrNull(offset)) as P;
    case 40:
      return (reader.readDoubleOrNull(offset)) as P;
    case 41:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _servicoGetId(Servico object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _servicoGetLinks(Servico object) {
  return [object.clienteLink];
}

void _servicoAttach(IsarCollection<dynamic> col, Id id, Servico object) {
  object.id = id;
  object.clienteLink.attach(
    col,
    col.isar.collection<Cliente>(),
    r'clienteLink',
    id,
  );
}

extension ServicoQueryWhereSort on QueryBuilder<Servico, Servico, QWhere> {
  QueryBuilder<Servico, Servico, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Servico, Servico, QAfterWhere> anyClienteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'clienteId'),
      );
    });
  }
}

extension ServicoQueryWhere on QueryBuilder<Servico, Servico, QWhereClause> {
  QueryBuilder<Servico, Servico, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Servico, Servico, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Servico, Servico, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterWhereClause> clienteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'clienteId', value: [null]),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterWhereClause> clienteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'clienteId',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterWhereClause> clienteIdEqualTo(
    int? clienteId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'clienteId', value: [clienteId]),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterWhereClause> clienteIdNotEqualTo(
    int? clienteId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clienteId',
                lower: [],
                upper: [clienteId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clienteId',
                lower: [clienteId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clienteId',
                lower: [clienteId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clienteId',
                lower: [],
                upper: [clienteId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<Servico, Servico, QAfterWhereClause> clienteIdGreaterThan(
    int? clienteId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'clienteId',
          lower: [clienteId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterWhereClause> clienteIdLessThan(
    int? clienteId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'clienteId',
          lower: [],
          upper: [clienteId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterWhereClause> clienteIdBetween(
    int? lowerClienteId,
    int? upperClienteId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'clienteId',
          lower: [lowerClienteId],
          includeLower: includeLower,
          upper: [upperClienteId],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ServicoQueryFilter
    on QueryBuilder<Servico, Servico, QFilterCondition> {
  QueryBuilder<Servico, Servico, QAfterFilterCondition> acessoriosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'acessorios'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> acessoriosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'acessorios'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> acessoriosEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'acessorios',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> acessoriosGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'acessorios',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> acessoriosLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'acessorios',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> acessoriosBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'acessorios',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> acessoriosStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'acessorios',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> acessoriosEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'acessorios',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> acessoriosContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'acessorios',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> acessoriosMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'acessorios',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> acessoriosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'acessorios', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> acessoriosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'acessorios', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> atendenteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'atendente'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> atendenteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'atendente'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> atendenteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'atendente',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> atendenteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'atendente',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> atendenteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'atendente',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> atendenteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'atendente',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> atendenteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'atendente',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> atendenteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'atendente',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> atendenteContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'atendente',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> atendenteMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'atendente',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> atendenteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'atendente', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> atendenteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'atendente', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> clienteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'clienteId'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> clienteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'clienteId'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> clienteIdEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'clienteId', value: value),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> clienteIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'clienteId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> clienteIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'clienteId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> clienteIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'clienteId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> createdAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'data'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'data'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'data',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'data',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'data',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'data',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'data',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'data',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'data',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'data',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'data', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'data', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEntregaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'dataEntrega'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEntregaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'dataEntrega'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEntregaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dataEntrega',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEntregaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dataEntrega',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEntregaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dataEntrega',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEntregaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dataEntrega',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEntregaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'dataEntrega',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEntregaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'dataEntrega',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEntregaContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'dataEntrega',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEntregaMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'dataEntrega',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataEntregaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dataEntrega', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  dataEntregaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'dataEntrega', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataSenhaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'dataSenha'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataSenhaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'dataSenha'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataSenhaEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dataSenha', value: value),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataSenhaGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dataSenha',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataSenhaLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dataSenha',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> dataSenhaBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dataSenha',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> debitoCreditoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'debitoCredito'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  debitoCreditoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'debitoCredito'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> debitoCreditoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'debitoCredito',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  debitoCreditoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'debitoCredito',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> debitoCreditoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'debitoCredito',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> debitoCreditoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'debitoCredito',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> debitoCreditoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'debitoCredito',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> debitoCreditoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'debitoCredito',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> debitoCreditoContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'debitoCredito',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> debitoCreditoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'debitoCredito',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> debitoCreditoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'debitoCredito', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  debitoCreditoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'debitoCredito', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> entradaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'entrada'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> entradaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'entrada'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> entradaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'entrada',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> entradaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'entrada',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> entradaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'entrada',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> entradaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'entrada',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> entradaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'entrada',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> entradaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'entrada',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> entradaContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'entrada',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> entradaMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'entrada',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> entradaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'entrada', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> entradaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'entrada', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto1EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'formaPgto1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto1GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'formaPgto1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto1LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'formaPgto1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto1Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'formaPgto1',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'formaPgto1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'formaPgto1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto1Contains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'formaPgto1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto1Matches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'formaPgto1',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'formaPgto1', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'formaPgto1', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto2EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'formaPgto2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto2GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'formaPgto2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto2LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'formaPgto2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto2Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'formaPgto2',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'formaPgto2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'formaPgto2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto2Contains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'formaPgto2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto2Matches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'formaPgto2',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'formaPgto2', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> formaPgto2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'formaPgto2', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> fornecedorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'fornecedor'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> fornecedorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'fornecedor'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> fornecedorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fornecedor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> fornecedorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fornecedor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> fornecedorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fornecedor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> fornecedorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fornecedor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> fornecedorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fornecedor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> fornecedorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fornecedor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> fornecedorContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fornecedor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> fornecedorMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fornecedor',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> fornecedorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fornecedor', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> fornecedorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fornecedor', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> garantiaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'garantia'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> garantiaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'garantia'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> garantiaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'garantia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> garantiaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'garantia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> garantiaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'garantia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> garantiaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'garantia',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> garantiaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'garantia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> garantiaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'garantia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> garantiaContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'garantia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> garantiaMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'garantia',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> garantiaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'garantia', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> garantiaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'garantia', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> itensBonsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'itensBons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensBonsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'itensBons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensBonsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'itensBons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> itensBonsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'itensBons',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensBonsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'itensBons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensBonsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'itensBons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensBonsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'itensBons',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> itensBonsElementMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'itensBons',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensBonsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'itensBons', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensBonsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'itensBons', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> itensBonsLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'itensBons', length, true, length, true);
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> itensBonsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'itensBons', 0, true, 0, true);
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> itensBonsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'itensBons', 0, false, 999999, true);
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> itensBonsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'itensBons', 0, true, length, include);
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensBonsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'itensBons', length, include, 999999, true);
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> itensBonsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itensBons',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensRuinsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'itensRuins',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensRuinsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'itensRuins',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensRuinsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'itensRuins',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensRuinsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'itensRuins',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensRuinsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'itensRuins',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensRuinsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'itensRuins',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensRuinsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'itensRuins',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensRuinsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'itensRuins',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensRuinsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'itensRuins', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensRuinsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'itensRuins', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> itensRuinsLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'itensRuins', length, true, length, true);
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> itensRuinsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'itensRuins', 0, true, 0, true);
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> itensRuinsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'itensRuins', 0, false, 999999, true);
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensRuinsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'itensRuins', 0, true, length, include);
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  itensRuinsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'itensRuins', length, include, 999999, true);
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> itensRuinsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itensRuins',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> marcaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'marca'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> marcaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'marca'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> marcaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'marca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> marcaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'marca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> marcaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'marca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> marcaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'marca',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> marcaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'marca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> marcaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'marca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> marcaContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'marca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> marcaMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'marca',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> marcaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'marca', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> marcaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'marca', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> modeloIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'modelo'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> modeloIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'modelo'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> modeloEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'modelo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> modeloGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'modelo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> modeloLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'modelo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> modeloBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'modelo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> modeloStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'modelo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> modeloEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'modelo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> modeloContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'modelo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> modeloMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'modelo',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> modeloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'modelo', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> modeloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'modelo', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> motivoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'motivo'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> motivoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'motivo'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> motivoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'motivo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> motivoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'motivo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> motivoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'motivo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> motivoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'motivo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> motivoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'motivo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> motivoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'motivo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> motivoContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'motivo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> motivoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'motivo',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> motivoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'motivo', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> motivoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'motivo', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> nomeClienteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'nomeCliente'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> nomeClienteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'nomeCliente'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> nomeClienteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nomeCliente',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> nomeClienteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nomeCliente',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> nomeClienteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nomeCliente',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> nomeClienteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nomeCliente',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> nomeClienteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'nomeCliente',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> nomeClienteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'nomeCliente',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> nomeClienteContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'nomeCliente',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> nomeClienteMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'nomeCliente',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> nomeClienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nomeCliente', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  nomeClienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nomeCliente', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> obsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'obs'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> obsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'obs'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> obsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'obs',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> obsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'obs',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> obsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'obs',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> obsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'obs',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> obsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'obs',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> obsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'obs',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> obsContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'obs',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> obsMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'obs',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> obsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'obs', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> obsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'obs', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas1EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'parcelas1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas1GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'parcelas1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas1LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'parcelas1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas1Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'parcelas1',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'parcelas1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'parcelas1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas1Contains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'parcelas1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas1Matches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'parcelas1',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'parcelas1', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'parcelas1', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas2EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'parcelas2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas2GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'parcelas2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas2LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'parcelas2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas2Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'parcelas2',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'parcelas2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'parcelas2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas2Contains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'parcelas2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas2Matches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'parcelas2',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'parcelas2', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> parcelas2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'parcelas2', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  pecasUtilizadasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'pecasUtilizadas'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  pecasUtilizadasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'pecasUtilizadas'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> pecasUtilizadasEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pecasUtilizadas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  pecasUtilizadasGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pecasUtilizadas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> pecasUtilizadasLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pecasUtilizadas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> pecasUtilizadasBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pecasUtilizadas',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  pecasUtilizadasStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'pecasUtilizadas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> pecasUtilizadasEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'pecasUtilizadas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> pecasUtilizadasContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'pecasUtilizadas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> pecasUtilizadasMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'pecasUtilizadas',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  pecasUtilizadasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pecasUtilizadas', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  pecasUtilizadasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'pecasUtilizadas', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> problemaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'problema'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> problemaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'problema'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> problemaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'problema',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> problemaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'problema',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> problemaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'problema',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> problemaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'problema',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> problemaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'problema',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> problemaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'problema',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> problemaContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'problema',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> problemaMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'problema',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> problemaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'problema', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> problemaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'problema', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  qualidadeFrontalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'qualidadeFrontal'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  qualidadeFrontalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'qualidadeFrontal'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> qualidadeFrontalEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'qualidadeFrontal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  qualidadeFrontalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'qualidadeFrontal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  qualidadeFrontalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'qualidadeFrontal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> qualidadeFrontalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'qualidadeFrontal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  qualidadeFrontalStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'qualidadeFrontal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  qualidadeFrontalEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'qualidadeFrontal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  qualidadeFrontalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'qualidadeFrontal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> qualidadeFrontalMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'qualidadeFrontal',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  qualidadeFrontalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'qualidadeFrontal', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  qualidadeFrontalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'qualidadeFrontal', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'senha'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'senha'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'senha',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'senha',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'senha',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'senha',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'senha',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'senha',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'senha',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'senha',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'senha', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'senha', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaPadraoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'senhaPadrao'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaPadraoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'senhaPadrao'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaPadraoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'senhaPadrao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaPadraoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'senhaPadrao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaPadraoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'senhaPadrao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaPadraoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'senhaPadrao',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaPadraoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'senhaPadrao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaPadraoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'senhaPadrao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaPadraoContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'senhaPadrao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaPadraoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'senhaPadrao',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> senhaPadraoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'senhaPadrao', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  senhaPadraoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'senhaPadrao', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> servicosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'servicos'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> servicosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'servicos'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> servicosEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'servicos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> servicosGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'servicos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> servicosLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'servicos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> servicosBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'servicos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> servicosStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'servicos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> servicosEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'servicos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> servicosContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'servicos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> servicosMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'servicos',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> servicosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'servicos', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> servicosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'servicos', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'status'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'status'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> statusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> statusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> statusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> statusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> statusContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> statusMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'status',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tecnicoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tecnico'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tecnicoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tecnico'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tecnicoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tecnico',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tecnicoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tecnico',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tecnicoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tecnico',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tecnicoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tecnico',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tecnicoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'tecnico',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tecnicoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'tecnico',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tecnicoContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'tecnico',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tecnicoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'tecnico',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tecnicoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tecnico', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tecnicoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'tecnico', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeAparelhoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tipoDeAparelho'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  tipoDeAparelhoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tipoDeAparelho'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeAparelhoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tipoDeAparelho',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  tipoDeAparelhoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tipoDeAparelho',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeAparelhoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tipoDeAparelho',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeAparelhoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tipoDeAparelho',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  tipoDeAparelhoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'tipoDeAparelho',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeAparelhoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'tipoDeAparelho',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeAparelhoContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'tipoDeAparelho',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeAparelhoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'tipoDeAparelho',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  tipoDeAparelhoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tipoDeAparelho', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  tipoDeAparelhoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'tipoDeAparelho', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeFrontalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tipoDeFrontal'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  tipoDeFrontalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tipoDeFrontal'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeFrontalEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tipoDeFrontal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  tipoDeFrontalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tipoDeFrontal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeFrontalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tipoDeFrontal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeFrontalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tipoDeFrontal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeFrontalStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'tipoDeFrontal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeFrontalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'tipoDeFrontal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeFrontalContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'tipoDeFrontal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeFrontalMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'tipoDeFrontal',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> tipoDeFrontalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tipoDeFrontal', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  tipoDeFrontalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'tipoDeFrontal', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> updatedAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valor'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'valor'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'valor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'valor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'valor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'valor',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'valor', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'valor', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valor1DoubleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valor1Double'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valor1DoubleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'valor1Double'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valor1DoubleEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valor1Double',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valor1DoubleGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valor1Double',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valor1DoubleLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valor1Double',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valor1DoubleBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valor1Double',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valor2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valor2'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valor2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'valor2'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valor2EqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valor2',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valor2GreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valor2',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valor2LessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valor2',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valor2Between(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valor2',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorAcessoriosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valorAcessorios'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorAcessoriosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'valorAcessorios'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorAcessoriosEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valorAcessorios',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorAcessoriosGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valorAcessorios',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorAcessoriosLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valorAcessorios',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorAcessoriosBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valorAcessorios',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorAcessoriosStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'valorAcessorios',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorAcessoriosEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'valorAcessorios',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorAcessoriosContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'valorAcessorios',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorAcessoriosMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'valorAcessorios',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorAcessoriosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'valorAcessorios', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorAcessoriosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'valorAcessorios', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorOriginalServicoDoubleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valorOriginalServicoDouble'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorOriginalServicoDoubleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(
          property: r'valorOriginalServicoDouble',
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorOriginalServicoDoubleEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valorOriginalServicoDouble',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorOriginalServicoDoubleGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valorOriginalServicoDouble',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorOriginalServicoDoubleLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valorOriginalServicoDouble',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorOriginalServicoDoubleBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valorOriginalServicoDouble',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorPecaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valorPeca'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorPecaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'valorPeca'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorPecaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valorPeca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorPecaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valorPeca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorPecaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valorPeca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorPecaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valorPeca',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorPecaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'valorPeca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorPecaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'valorPeca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorPecaContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'valorPeca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorPecaMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'valorPeca',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorPecaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'valorPeca', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorPecaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'valorPeca', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorSomadoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valorSomado'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorSomadoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'valorSomado'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorSomadoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valorSomado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorSomadoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valorSomado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorSomadoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valorSomado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorSomadoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valorSomado',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorSomadoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'valorSomado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorSomadoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'valorSomado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorSomadoContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'valorSomado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorSomadoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'valorSomado',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> valorSomadoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'valorSomado', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorSomadoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'valorSomado', value: ''),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorTotalAcessoriosDoubleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valorTotalAcessoriosDouble'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorTotalAcessoriosDoubleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(
          property: r'valorTotalAcessoriosDouble',
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorTotalAcessoriosDoubleEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valorTotalAcessoriosDouble',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorTotalAcessoriosDoubleGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valorTotalAcessoriosDouble',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorTotalAcessoriosDoubleLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valorTotalAcessoriosDouble',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorTotalAcessoriosDoubleBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valorTotalAcessoriosDouble',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorTotalCustoPecasDoubleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valorTotalCustoPecasDouble'),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorTotalCustoPecasDoubleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(
          property: r'valorTotalCustoPecasDouble',
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorTotalCustoPecasDoubleEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valorTotalCustoPecasDouble',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorTotalCustoPecasDoubleGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valorTotalCustoPecasDouble',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorTotalCustoPecasDoubleLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valorTotalCustoPecasDouble',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition>
  valorTotalCustoPecasDoubleBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valorTotalCustoPecasDouble',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }
}

extension ServicoQueryObject
    on QueryBuilder<Servico, Servico, QFilterCondition> {}

extension ServicoQueryLinks
    on QueryBuilder<Servico, Servico, QFilterCondition> {
  QueryBuilder<Servico, Servico, QAfterFilterCondition> clienteLink(
    FilterQuery<Cliente> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'clienteLink');
    });
  }

  QueryBuilder<Servico, Servico, QAfterFilterCondition> clienteLinkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'clienteLink', 0, true, 0, true);
    });
  }
}

extension ServicoQuerySortBy on QueryBuilder<Servico, Servico, QSortBy> {
  QueryBuilder<Servico, Servico, QAfterSortBy> sortByAcessorios() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acessorios', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByAcessoriosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acessorios', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByAtendente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'atendente', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByAtendenteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'atendente', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByClienteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clienteId', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByClienteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clienteId', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByDataEntrega() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataEntrega', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByDataEntregaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataEntrega', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByDataSenha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataSenha', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByDataSenhaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataSenha', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByDebitoCredito() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'debitoCredito', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByDebitoCreditoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'debitoCredito', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByEntrada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entrada', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByEntradaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entrada', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByFormaPgto1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formaPgto1', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByFormaPgto1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formaPgto1', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByFormaPgto2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formaPgto2', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByFormaPgto2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formaPgto2', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByFornecedor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fornecedor', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByFornecedorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fornecedor', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByGarantia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'garantia', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByGarantiaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'garantia', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByMarca() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marca', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByMarcaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marca', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByModelo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelo', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByModeloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelo', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByMotivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivo', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByMotivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivo', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByNomeCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomeCliente', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByNomeClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomeCliente', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByObs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'obs', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByObsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'obs', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByParcelas1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelas1', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByParcelas1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelas1', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByParcelas2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelas2', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByParcelas2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelas2', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByPecasUtilizadas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pecasUtilizadas', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByPecasUtilizadasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pecasUtilizadas', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByProblema() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problema', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByProblemaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problema', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByQualidadeFrontal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualidadeFrontal', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByQualidadeFrontalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualidadeFrontal', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortBySenha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senha', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortBySenhaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senha', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortBySenhaPadrao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senhaPadrao', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortBySenhaPadraoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senhaPadrao', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByServicos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servicos', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByServicosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servicos', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByTecnico() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tecnico', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByTecnicoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tecnico', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByTipoDeAparelho() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoDeAparelho', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByTipoDeAparelhoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoDeAparelho', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByTipoDeFrontal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoDeFrontal', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByTipoDeFrontalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoDeFrontal', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByValor1Double() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor1Double', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByValor1DoubleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor1Double', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByValor2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor2', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByValor2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor2', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByValorAcessorios() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorAcessorios', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByValorAcessoriosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorAcessorios', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy>
  sortByValorOriginalServicoDouble() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorOriginalServicoDouble', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy>
  sortByValorOriginalServicoDoubleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorOriginalServicoDouble', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByValorPeca() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPeca', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByValorPecaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPeca', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByValorSomado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorSomado', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> sortByValorSomadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorSomado', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy>
  sortByValorTotalAcessoriosDouble() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotalAcessoriosDouble', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy>
  sortByValorTotalAcessoriosDoubleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotalAcessoriosDouble', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy>
  sortByValorTotalCustoPecasDouble() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotalCustoPecasDouble', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy>
  sortByValorTotalCustoPecasDoubleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotalCustoPecasDouble', Sort.desc);
    });
  }
}

extension ServicoQuerySortThenBy
    on QueryBuilder<Servico, Servico, QSortThenBy> {
  QueryBuilder<Servico, Servico, QAfterSortBy> thenByAcessorios() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acessorios', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByAcessoriosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acessorios', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByAtendente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'atendente', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByAtendenteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'atendente', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByClienteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clienteId', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByClienteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clienteId', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByDataEntrega() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataEntrega', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByDataEntregaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataEntrega', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByDataSenha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataSenha', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByDataSenhaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataSenha', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByDebitoCredito() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'debitoCredito', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByDebitoCreditoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'debitoCredito', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByEntrada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entrada', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByEntradaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entrada', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByFormaPgto1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formaPgto1', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByFormaPgto1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formaPgto1', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByFormaPgto2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formaPgto2', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByFormaPgto2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formaPgto2', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByFornecedor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fornecedor', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByFornecedorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fornecedor', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByGarantia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'garantia', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByGarantiaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'garantia', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByMarca() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marca', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByMarcaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marca', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByModelo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelo', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByModeloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelo', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByMotivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivo', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByMotivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motivo', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByNomeCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomeCliente', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByNomeClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomeCliente', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByObs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'obs', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByObsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'obs', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByParcelas1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelas1', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByParcelas1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelas1', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByParcelas2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelas2', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByParcelas2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelas2', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByPecasUtilizadas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pecasUtilizadas', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByPecasUtilizadasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pecasUtilizadas', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByProblema() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problema', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByProblemaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problema', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByQualidadeFrontal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualidadeFrontal', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByQualidadeFrontalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualidadeFrontal', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenBySenha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senha', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenBySenhaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senha', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenBySenhaPadrao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senhaPadrao', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenBySenhaPadraoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senhaPadrao', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByServicos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servicos', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByServicosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servicos', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByTecnico() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tecnico', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByTecnicoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tecnico', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByTipoDeAparelho() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoDeAparelho', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByTipoDeAparelhoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoDeAparelho', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByTipoDeFrontal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoDeFrontal', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByTipoDeFrontalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoDeFrontal', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByValor1Double() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor1Double', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByValor1DoubleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor1Double', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByValor2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor2', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByValor2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor2', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByValorAcessorios() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorAcessorios', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByValorAcessoriosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorAcessorios', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy>
  thenByValorOriginalServicoDouble() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorOriginalServicoDouble', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy>
  thenByValorOriginalServicoDoubleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorOriginalServicoDouble', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByValorPeca() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPeca', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByValorPecaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPeca', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByValorSomado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorSomado', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy> thenByValorSomadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorSomado', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy>
  thenByValorTotalAcessoriosDouble() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotalAcessoriosDouble', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy>
  thenByValorTotalAcessoriosDoubleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotalAcessoriosDouble', Sort.desc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy>
  thenByValorTotalCustoPecasDouble() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotalCustoPecasDouble', Sort.asc);
    });
  }

  QueryBuilder<Servico, Servico, QAfterSortBy>
  thenByValorTotalCustoPecasDoubleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorTotalCustoPecasDouble', Sort.desc);
    });
  }
}

extension ServicoQueryWhereDistinct
    on QueryBuilder<Servico, Servico, QDistinct> {
  QueryBuilder<Servico, Servico, QDistinct> distinctByAcessorios({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'acessorios', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByAtendente({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'atendente', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByClienteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clienteId');
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByData({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByDataEntrega({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataEntrega', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByDataSenha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataSenha');
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByDebitoCredito({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'debitoCredito',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByEntrada({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entrada', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByFormaPgto1({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formaPgto1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByFormaPgto2({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formaPgto2', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByFornecedor({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fornecedor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByGarantia({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'garantia', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByItensBons() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itensBons');
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByItensRuins() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itensRuins');
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByMarca({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'marca', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByModelo({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByMotivo({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motivo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByNomeCliente({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomeCliente', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByObs({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'obs', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByParcelas1({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parcelas1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByParcelas2({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parcelas2', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByPecasUtilizadas({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'pecasUtilizadas',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByProblema({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problema', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByQualidadeFrontal({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'qualidadeFrontal',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctBySenha({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senha', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctBySenhaPadrao({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senhaPadrao', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByServicos({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'servicos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByStatus({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByTecnico({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tecnico', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByTipoDeAparelho({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'tipoDeAparelho',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByTipoDeFrontal({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'tipoDeFrontal',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByValor({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByValor1Double() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valor1Double');
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByValor2() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valor2');
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByValorAcessorios({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'valorAcessorios',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Servico, Servico, QDistinct>
  distinctByValorOriginalServicoDouble() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorOriginalServicoDouble');
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByValorPeca({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorPeca', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct> distinctByValorSomado({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorSomado', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Servico, Servico, QDistinct>
  distinctByValorTotalAcessoriosDouble() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorTotalAcessoriosDouble');
    });
  }

  QueryBuilder<Servico, Servico, QDistinct>
  distinctByValorTotalCustoPecasDouble() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorTotalCustoPecasDouble');
    });
  }
}

extension ServicoQueryProperty
    on QueryBuilder<Servico, Servico, QQueryProperty> {
  QueryBuilder<Servico, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> acessoriosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'acessorios');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> atendenteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'atendente');
    });
  }

  QueryBuilder<Servico, int?, QQueryOperations> clienteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clienteId');
    });
  }

  QueryBuilder<Servico, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> dataEntregaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataEntrega');
    });
  }

  QueryBuilder<Servico, DateTime?, QQueryOperations> dataSenhaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataSenha');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> debitoCreditoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'debitoCredito');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> entradaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entrada');
    });
  }

  QueryBuilder<Servico, String, QQueryOperations> formaPgto1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formaPgto1');
    });
  }

  QueryBuilder<Servico, String, QQueryOperations> formaPgto2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formaPgto2');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> fornecedorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fornecedor');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> garantiaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'garantia');
    });
  }

  QueryBuilder<Servico, List<String>, QQueryOperations> itensBonsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itensBons');
    });
  }

  QueryBuilder<Servico, List<String>, QQueryOperations> itensRuinsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itensRuins');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> marcaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'marca');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> modeloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelo');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> motivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motivo');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> nomeClienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomeCliente');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> obsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'obs');
    });
  }

  QueryBuilder<Servico, String, QQueryOperations> parcelas1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parcelas1');
    });
  }

  QueryBuilder<Servico, String, QQueryOperations> parcelas2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parcelas2');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> pecasUtilizadasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pecasUtilizadas');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> problemaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problema');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> qualidadeFrontalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qualidadeFrontal');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> senhaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senha');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> senhaPadraoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senhaPadrao');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> servicosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'servicos');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> tecnicoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tecnico');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> tipoDeAparelhoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoDeAparelho');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> tipoDeFrontalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoDeFrontal');
    });
  }

  QueryBuilder<Servico, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> valorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valor');
    });
  }

  QueryBuilder<Servico, double?, QQueryOperations> valor1DoubleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valor1Double');
    });
  }

  QueryBuilder<Servico, double?, QQueryOperations> valor2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valor2');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> valorAcessoriosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorAcessorios');
    });
  }

  QueryBuilder<Servico, double?, QQueryOperations>
  valorOriginalServicoDoubleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorOriginalServicoDouble');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> valorPecaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorPeca');
    });
  }

  QueryBuilder<Servico, String?, QQueryOperations> valorSomadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorSomado');
    });
  }

  QueryBuilder<Servico, double?, QQueryOperations>
  valorTotalAcessoriosDoubleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorTotalAcessoriosDouble');
    });
  }

  QueryBuilder<Servico, double?, QQueryOperations>
  valorTotalCustoPecasDoubleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorTotalCustoPecasDouble');
    });
  }
}
