// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetClienteCollection on Isar {
  IsarCollection<Cliente> get clientes => this.collection();
}

const ClienteSchema = CollectionSchema(
  name: r'Cliente',
  id: 8668185751114761648,
  properties: {
    r'bairro': PropertySchema(id: 0, name: r'bairro', type: IsarType.string),
    r'cep': PropertySchema(id: 1, name: r'cep', type: IsarType.string),
    r'cidade': PropertySchema(id: 2, name: r'cidade', type: IsarType.string),
    r'cpf': PropertySchema(id: 3, name: r'cpf', type: IsarType.string),
    r'createdAt': PropertySchema(
      id: 4,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dataCadastro': PropertySchema(
      id: 5,
      name: r'dataCadastro',
      type: IsarType.string,
    ),
    r'email': PropertySchema(id: 6, name: r'email', type: IsarType.string),
    r'estado': PropertySchema(id: 7, name: r'estado', type: IsarType.string),
    r'isDirty': PropertySchema(id: 8, name: r'isDirty', type: IsarType.bool),
    r'nome': PropertySchema(id: 9, name: r'nome', type: IsarType.string),
    r'numero': PropertySchema(id: 10, name: r'numero', type: IsarType.string),
    r'rua': PropertySchema(id: 11, name: r'rua', type: IsarType.string),
    r'telefone': PropertySchema(
      id: 12,
      name: r'telefone',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 13,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _clienteEstimateSize,
  serialize: _clienteSerialize,
  deserialize: _clienteDeserialize,
  deserializeProp: _clienteDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'servicosLink': LinkSchema(
      id: 6342503043422893857,
      name: r'servicosLink',
      target: r'Servico',
      single: false,
    ),
  },
  embeddedSchemas: {},

  getId: _clienteGetId,
  getLinks: _clienteGetLinks,
  attach: _clienteAttach,
  version: '3.3.0',
);

int _clienteEstimateSize(
  Cliente object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.bairro;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.cep;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.cidade;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.cpf;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.dataCadastro.length * 3;
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.estado;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nome;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.numero;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.rua;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.telefone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _clienteSerialize(
  Cliente object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bairro);
  writer.writeString(offsets[1], object.cep);
  writer.writeString(offsets[2], object.cidade);
  writer.writeString(offsets[3], object.cpf);
  writer.writeDateTime(offsets[4], object.createdAt);
  writer.writeString(offsets[5], object.dataCadastro);
  writer.writeString(offsets[6], object.email);
  writer.writeString(offsets[7], object.estado);
  writer.writeBool(offsets[8], object.isDirty);
  writer.writeString(offsets[9], object.nome);
  writer.writeString(offsets[10], object.numero);
  writer.writeString(offsets[11], object.rua);
  writer.writeString(offsets[12], object.telefone);
  writer.writeDateTime(offsets[13], object.updatedAt);
}

Cliente _clienteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Cliente();
  object.bairro = reader.readStringOrNull(offsets[0]);
  object.cep = reader.readStringOrNull(offsets[1]);
  object.cidade = reader.readStringOrNull(offsets[2]);
  object.cpf = reader.readStringOrNull(offsets[3]);
  object.createdAt = reader.readDateTimeOrNull(offsets[4]);
  object.dataCadastro = reader.readString(offsets[5]);
  object.email = reader.readStringOrNull(offsets[6]);
  object.estado = reader.readStringOrNull(offsets[7]);
  object.id = id;
  object.isDirty = reader.readBool(offsets[8]);
  object.nome = reader.readStringOrNull(offsets[9]);
  object.numero = reader.readStringOrNull(offsets[10]);
  object.rua = reader.readStringOrNull(offsets[11]);
  object.telefone = reader.readStringOrNull(offsets[12]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[13]);
  return object;
}

P _clienteDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _clienteGetId(Cliente object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _clienteGetLinks(Cliente object) {
  return [object.servicosLink];
}

void _clienteAttach(IsarCollection<dynamic> col, Id id, Cliente object) {
  object.id = id;
  object.servicosLink.attach(
    col,
    col.isar.collection<Servico>(),
    r'servicosLink',
    id,
  );
}

extension ClienteQueryWhereSort on QueryBuilder<Cliente, Cliente, QWhere> {
  QueryBuilder<Cliente, Cliente, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ClienteQueryWhere on QueryBuilder<Cliente, Cliente, QWhereClause> {
  QueryBuilder<Cliente, Cliente, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Cliente, Cliente, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterWhereClause> idBetween(
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
}

extension ClienteQueryFilter
    on QueryBuilder<Cliente, Cliente, QFilterCondition> {
  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> bairroIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bairro'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> bairroIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bairro'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> bairroEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'bairro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> bairroGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bairro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> bairroLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bairro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> bairroBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bairro',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> bairroStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'bairro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> bairroEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'bairro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> bairroContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'bairro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> bairroMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'bairro',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> bairroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bairro', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> bairroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'bairro', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cepIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cep'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cepIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cep'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cepEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cep',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cepGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cep',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cepLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cep',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cepBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cep',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cepStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'cep',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cepEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'cep',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cepContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'cep',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cepMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'cep',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cepIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cep', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cepIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'cep', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cidadeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cidade'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cidadeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cidade'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cidadeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cidade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cidadeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cidade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cidadeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cidade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cidadeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cidade',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cidadeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'cidade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cidadeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'cidade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cidadeContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'cidade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cidadeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'cidade',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cidadeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cidade', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cidadeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'cidade', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cpfIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cpf'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cpfIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cpf'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cpfEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cpf',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cpfGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cpf',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cpfLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cpf',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cpfBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cpf',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cpfStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'cpf',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cpfEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'cpf',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cpfContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'cpf',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cpfMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'cpf',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cpfIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cpf', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> cpfIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'cpf', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> createdAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> dataCadastroEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dataCadastro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> dataCadastroGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dataCadastro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> dataCadastroLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dataCadastro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> dataCadastroBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dataCadastro',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> dataCadastroStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'dataCadastro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> dataCadastroEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'dataCadastro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> dataCadastroContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'dataCadastro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> dataCadastroMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'dataCadastro',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> dataCadastroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dataCadastro', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition>
  dataCadastroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'dataCadastro', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'email'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'email'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'email',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'email',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'email',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'email',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'email',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'email',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> emailContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'email',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> emailMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'email',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'email', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'email', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> estadoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'estado'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> estadoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'estado'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> estadoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> estadoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> estadoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> estadoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'estado',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> estadoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> estadoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> estadoContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> estadoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'estado',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> estadoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'estado', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> estadoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'estado', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> isDirtyEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isDirty', value: value),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> nomeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'nome'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> nomeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'nome'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> nomeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nome',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> nomeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nome',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> nomeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nome',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> nomeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nome',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> nomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'nome',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> nomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'nome',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> nomeContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'nome',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> nomeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'nome',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nome', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nome', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> numeroIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'numero'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> numeroIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'numero'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> numeroEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'numero',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> numeroGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'numero',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> numeroLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'numero',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> numeroBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'numero',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> numeroStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'numero',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> numeroEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'numero',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> numeroContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'numero',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> numeroMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'numero',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> numeroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'numero', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> numeroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'numero', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> ruaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rua'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> ruaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rua'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> ruaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'rua',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> ruaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rua',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> ruaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rua',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> ruaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rua',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> ruaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'rua',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> ruaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'rua',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> ruaContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'rua',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> ruaMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'rua',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> ruaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rua', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> ruaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'rua', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> telefoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'telefone'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> telefoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'telefone'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> telefoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'telefone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> telefoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'telefone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> telefoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'telefone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> telefoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'telefone',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> telefoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'telefone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> telefoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'telefone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> telefoneContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'telefone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> telefoneMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'telefone',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> telefoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'telefone', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> telefoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'telefone', value: ''),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> updatedAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> updatedAtBetween(
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
}

extension ClienteQueryObject
    on QueryBuilder<Cliente, Cliente, QFilterCondition> {}

extension ClienteQueryLinks
    on QueryBuilder<Cliente, Cliente, QFilterCondition> {
  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> servicosLink(
    FilterQuery<Servico> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'servicosLink');
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition>
  servicosLinkLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'servicosLink', length, true, length, true);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition> servicosLinkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'servicosLink', 0, true, 0, true);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition>
  servicosLinkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'servicosLink', 0, false, 999999, true);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition>
  servicosLinkLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'servicosLink', 0, true, length, include);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition>
  servicosLinkLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'servicosLink', length, include, 999999, true);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterFilterCondition>
  servicosLinkLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'servicosLink',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ClienteQuerySortBy on QueryBuilder<Cliente, Cliente, QSortBy> {
  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByBairro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bairro', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByBairroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bairro', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByCep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cep', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByCepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cep', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByCidade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cidade', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByCidadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cidade', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByCpf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cpf', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByCpfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cpf', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByDataCadastro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCadastro', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByDataCadastroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCadastro', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByIsDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByRua() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rua', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByRuaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rua', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByTelefone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByTelefoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ClienteQuerySortThenBy
    on QueryBuilder<Cliente, Cliente, QSortThenBy> {
  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByBairro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bairro', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByBairroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bairro', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByCep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cep', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByCepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cep', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByCidade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cidade', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByCidadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cidade', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByCpf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cpf', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByCpfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cpf', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByDataCadastro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCadastro', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByDataCadastroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCadastro', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByIsDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByRua() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rua', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByRuaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rua', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByTelefone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByTelefoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone', Sort.desc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Cliente, Cliente, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ClienteQueryWhereDistinct
    on QueryBuilder<Cliente, Cliente, QDistinct> {
  QueryBuilder<Cliente, Cliente, QDistinct> distinctByBairro({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bairro', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByCep({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cep', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByCidade({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cidade', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByCpf({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cpf', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByDataCadastro({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataCadastro', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByEmail({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByEstado({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estado', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDirty');
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByNome({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByNumero({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numero', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByRua({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rua', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByTelefone({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'telefone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cliente, Cliente, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension ClienteQueryProperty
    on QueryBuilder<Cliente, Cliente, QQueryProperty> {
  QueryBuilder<Cliente, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Cliente, String?, QQueryOperations> bairroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bairro');
    });
  }

  QueryBuilder<Cliente, String?, QQueryOperations> cepProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cep');
    });
  }

  QueryBuilder<Cliente, String?, QQueryOperations> cidadeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cidade');
    });
  }

  QueryBuilder<Cliente, String?, QQueryOperations> cpfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cpf');
    });
  }

  QueryBuilder<Cliente, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Cliente, String, QQueryOperations> dataCadastroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataCadastro');
    });
  }

  QueryBuilder<Cliente, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<Cliente, String?, QQueryOperations> estadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estado');
    });
  }

  QueryBuilder<Cliente, bool, QQueryOperations> isDirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDirty');
    });
  }

  QueryBuilder<Cliente, String?, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<Cliente, String?, QQueryOperations> numeroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numero');
    });
  }

  QueryBuilder<Cliente, String?, QQueryOperations> ruaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rua');
    });
  }

  QueryBuilder<Cliente, String?, QQueryOperations> telefoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'telefone');
    });
  }

  QueryBuilder<Cliente, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
