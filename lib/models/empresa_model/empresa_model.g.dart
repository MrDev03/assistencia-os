// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empresa_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEmpresaCollection on Isar {
  IsarCollection<Empresa> get empresas => this.collection();
}

const EmpresaSchema = CollectionSchema(
  name: r'Empresa',
  id: 6619396595510192979,
  properties: {
    r'assinatura': PropertySchema(
      id: 0,
      name: r'assinatura',
      type: IsarType.longList,
    ),
    r'assinaturaUrl': PropertySchema(
      id: 1,
      name: r'assinaturaUrl',
      type: IsarType.string,
    ),
    r'cnpj': PropertySchema(id: 2, name: r'cnpj', type: IsarType.string),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'email': PropertySchema(id: 4, name: r'email', type: IsarType.string),
    r'endereco': PropertySchema(
      id: 5,
      name: r'endereco',
      type: IsarType.string,
    ),
    r'horaAbertura': PropertySchema(
      id: 6,
      name: r'horaAbertura',
      type: IsarType.long,
    ),
    r'horaFechamento': PropertySchema(
      id: 7,
      name: r'horaFechamento',
      type: IsarType.long,
    ),
    r'isDirty': PropertySchema(id: 8, name: r'isDirty', type: IsarType.bool),
    r'logoBytes': PropertySchema(
      id: 9,
      name: r'logoBytes',
      type: IsarType.longList,
    ),
    r'logoUrl': PropertySchema(id: 10, name: r'logoUrl', type: IsarType.string),
    r'nome': PropertySchema(id: 11, name: r'nome', type: IsarType.string),
    r'politicaGarantia': PropertySchema(
      id: 12,
      name: r'politicaGarantia',
      type: IsarType.string,
    ),
    r'politicaPrivacidade': PropertySchema(
      id: 13,
      name: r'politicaPrivacidade',
      type: IsarType.string,
    ),
    r'slogan': PropertySchema(id: 14, name: r'slogan', type: IsarType.string),
    r'telefone1': PropertySchema(
      id: 15,
      name: r'telefone1',
      type: IsarType.string,
    ),
    r'telefone2': PropertySchema(
      id: 16,
      name: r'telefone2',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 17,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _empresaEstimateSize,
  serialize: _empresaSerialize,
  deserialize: _empresaDeserialize,
  deserializeProp: _empresaDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _empresaGetId,
  getLinks: _empresaGetLinks,
  attach: _empresaAttach,
  version: '3.3.0',
);

int _empresaEstimateSize(
  Empresa object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.assinatura;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.assinaturaUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.cnpj;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.endereco;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.logoBytes;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.logoUrl;
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
    final value = object.politicaGarantia;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.politicaPrivacidade;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.slogan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.telefone1;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.telefone2;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _empresaSerialize(
  Empresa object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.assinatura);
  writer.writeString(offsets[1], object.assinaturaUrl);
  writer.writeString(offsets[2], object.cnpj);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.email);
  writer.writeString(offsets[5], object.endereco);
  writer.writeLong(offsets[6], object.horaAbertura);
  writer.writeLong(offsets[7], object.horaFechamento);
  writer.writeBool(offsets[8], object.isDirty);
  writer.writeLongList(offsets[9], object.logoBytes);
  writer.writeString(offsets[10], object.logoUrl);
  writer.writeString(offsets[11], object.nome);
  writer.writeString(offsets[12], object.politicaGarantia);
  writer.writeString(offsets[13], object.politicaPrivacidade);
  writer.writeString(offsets[14], object.slogan);
  writer.writeString(offsets[15], object.telefone1);
  writer.writeString(offsets[16], object.telefone2);
  writer.writeDateTime(offsets[17], object.updatedAt);
}

Empresa _empresaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Empresa();
  object.assinatura = reader.readLongList(offsets[0]);
  object.assinaturaUrl = reader.readStringOrNull(offsets[1]);
  object.cnpj = reader.readStringOrNull(offsets[2]);
  object.createdAt = reader.readDateTimeOrNull(offsets[3]);
  object.email = reader.readStringOrNull(offsets[4]);
  object.endereco = reader.readStringOrNull(offsets[5]);
  object.horaAbertura = reader.readLongOrNull(offsets[6]);
  object.horaFechamento = reader.readLongOrNull(offsets[7]);
  object.id = id;
  object.isDirty = reader.readBool(offsets[8]);
  object.logoBytes = reader.readLongList(offsets[9]);
  object.logoUrl = reader.readStringOrNull(offsets[10]);
  object.nome = reader.readStringOrNull(offsets[11]);
  object.politicaGarantia = reader.readStringOrNull(offsets[12]);
  object.politicaPrivacidade = reader.readStringOrNull(offsets[13]);
  object.slogan = reader.readStringOrNull(offsets[14]);
  object.telefone1 = reader.readStringOrNull(offsets[15]);
  object.telefone2 = reader.readStringOrNull(offsets[16]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[17]);
  return object;
}

P _empresaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readLongList(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _empresaGetId(Empresa object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _empresaGetLinks(Empresa object) {
  return [];
}

void _empresaAttach(IsarCollection<dynamic> col, Id id, Empresa object) {
  object.id = id;
}

extension EmpresaQueryWhereSort on QueryBuilder<Empresa, Empresa, QWhere> {
  QueryBuilder<Empresa, Empresa, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EmpresaQueryWhere on QueryBuilder<Empresa, Empresa, QWhereClause> {
  QueryBuilder<Empresa, Empresa, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Empresa, Empresa, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterWhereClause> idBetween(
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

extension EmpresaQueryFilter
    on QueryBuilder<Empresa, Empresa, QFilterCondition> {
  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'assinatura'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'assinatura'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  assinaturaElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'assinatura', value: value),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  assinaturaElementGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'assinatura',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  assinaturaElementLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'assinatura',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  assinaturaElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'assinatura',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'assinatura', length, true, length, true);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'assinatura', 0, true, 0, true);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'assinatura', 0, false, 999999, true);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  assinaturaLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'assinatura', 0, true, length, include);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  assinaturaLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'assinatura', length, include, 999999, true);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assinatura',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'assinaturaUrl'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  assinaturaUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'assinaturaUrl'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'assinaturaUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  assinaturaUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'assinaturaUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'assinaturaUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'assinaturaUrl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'assinaturaUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'assinaturaUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaUrlContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'assinaturaUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaUrlMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'assinaturaUrl',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> assinaturaUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'assinaturaUrl', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  assinaturaUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'assinaturaUrl', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> cnpjIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cnpj'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> cnpjIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cnpj'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> cnpjEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cnpj',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> cnpjGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cnpj',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> cnpjLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cnpj',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> cnpjBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cnpj',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> cnpjStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'cnpj',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> cnpjEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'cnpj',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> cnpjContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'cnpj',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> cnpjMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'cnpj',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> cnpjIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cnpj', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> cnpjIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'cnpj', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> createdAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'email'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'email'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> emailEqualTo(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> emailGreaterThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> emailLessThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> emailBetween(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> emailStartsWith(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> emailEndsWith(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> emailContains(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> emailMatches(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'email', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'email', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> enderecoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'endereco'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> enderecoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'endereco'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> enderecoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'endereco',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> enderecoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endereco',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> enderecoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endereco',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> enderecoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endereco',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> enderecoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'endereco',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> enderecoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'endereco',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> enderecoContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'endereco',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> enderecoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'endereco',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> enderecoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endereco', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> enderecoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'endereco', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> horaAberturaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'horaAbertura'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  horaAberturaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'horaAbertura'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> horaAberturaEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'horaAbertura', value: value),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> horaAberturaGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'horaAbertura',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> horaAberturaLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'horaAbertura',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> horaAberturaBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'horaAbertura',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> horaFechamentoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'horaFechamento'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  horaFechamentoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'horaFechamento'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> horaFechamentoEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'horaFechamento', value: value),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  horaFechamentoGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'horaFechamento',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> horaFechamentoLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'horaFechamento',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> horaFechamentoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'horaFechamento',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> isDirtyEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isDirty', value: value),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoBytesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'logoBytes'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoBytesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'logoBytes'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoBytesElementEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'logoBytes', value: value),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  logoBytesElementGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'logoBytes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  logoBytesElementLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'logoBytes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoBytesElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'logoBytes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoBytesLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'logoBytes', length, true, length, true);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoBytesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'logoBytes', 0, true, 0, true);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoBytesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'logoBytes', 0, false, 999999, true);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoBytesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'logoBytes', 0, true, length, include);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  logoBytesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'logoBytes', length, include, 999999, true);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoBytesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'logoBytes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'logoUrl'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'logoUrl'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'logoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'logoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'logoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'logoUrl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'logoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'logoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoUrlContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'logoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoUrlMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'logoUrl',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'logoUrl', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> logoUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'logoUrl', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> nomeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'nome'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> nomeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'nome'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> nomeEqualTo(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> nomeGreaterThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> nomeLessThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> nomeBetween(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> nomeStartsWith(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> nomeEndsWith(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> nomeContains(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> nomeMatches(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nome', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nome', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaGarantiaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'politicaGarantia'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaGarantiaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'politicaGarantia'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> politicaGarantiaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'politicaGarantia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaGarantiaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'politicaGarantia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaGarantiaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'politicaGarantia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> politicaGarantiaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'politicaGarantia',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaGarantiaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'politicaGarantia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaGarantiaEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'politicaGarantia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaGarantiaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'politicaGarantia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> politicaGarantiaMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'politicaGarantia',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaGarantiaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'politicaGarantia', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaGarantiaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'politicaGarantia', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaPrivacidadeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'politicaPrivacidade'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaPrivacidadeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'politicaPrivacidade'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaPrivacidadeEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'politicaPrivacidade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaPrivacidadeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'politicaPrivacidade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaPrivacidadeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'politicaPrivacidade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaPrivacidadeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'politicaPrivacidade',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaPrivacidadeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'politicaPrivacidade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaPrivacidadeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'politicaPrivacidade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaPrivacidadeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'politicaPrivacidade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaPrivacidadeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'politicaPrivacidade',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaPrivacidadeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'politicaPrivacidade', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
  politicaPrivacidadeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'politicaPrivacidade',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> sloganIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'slogan'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> sloganIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'slogan'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> sloganEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'slogan',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> sloganGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'slogan',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> sloganLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'slogan',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> sloganBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'slogan',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> sloganStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'slogan',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> sloganEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'slogan',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> sloganContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'slogan',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> sloganMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'slogan',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> sloganIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'slogan', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> sloganIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'slogan', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'telefone1'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'telefone1'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone1EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'telefone1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone1GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'telefone1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone1LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'telefone1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone1Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'telefone1',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'telefone1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'telefone1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone1Contains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'telefone1',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone1Matches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'telefone1',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'telefone1', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'telefone1', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'telefone2'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'telefone2'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone2EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'telefone2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone2GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'telefone2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone2LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'telefone2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone2Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'telefone2',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'telefone2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'telefone2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone2Contains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'telefone2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone2Matches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'telefone2',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'telefone2', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> telefone2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'telefone2', value: ''),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> updatedAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> updatedAtBetween(
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

extension EmpresaQueryObject
    on QueryBuilder<Empresa, Empresa, QFilterCondition> {}

extension EmpresaQueryLinks
    on QueryBuilder<Empresa, Empresa, QFilterCondition> {}

extension EmpresaQuerySortBy on QueryBuilder<Empresa, Empresa, QSortBy> {
  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByAssinaturaUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assinaturaUrl', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByAssinaturaUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assinaturaUrl', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByCnpj() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cnpj', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByCnpjDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cnpj', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByEndereco() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endereco', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByEnderecoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endereco', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByHoraAbertura() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaAbertura', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByHoraAberturaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaAbertura', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByHoraFechamento() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaFechamento', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByHoraFechamentoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaFechamento', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByIsDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByLogoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByLogoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByPoliticaGarantia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'politicaGarantia', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByPoliticaGarantiaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'politicaGarantia', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByPoliticaPrivacidade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'politicaPrivacidade', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByPoliticaPrivacidadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'politicaPrivacidade', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortBySlogan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slogan', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortBySloganDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slogan', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByTelefone1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone1', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByTelefone1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone1', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByTelefone2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone2', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByTelefone2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone2', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension EmpresaQuerySortThenBy
    on QueryBuilder<Empresa, Empresa, QSortThenBy> {
  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByAssinaturaUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assinaturaUrl', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByAssinaturaUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assinaturaUrl', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByCnpj() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cnpj', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByCnpjDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cnpj', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByEndereco() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endereco', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByEnderecoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endereco', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByHoraAbertura() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaAbertura', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByHoraAberturaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaAbertura', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByHoraFechamento() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaFechamento', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByHoraFechamentoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaFechamento', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByIsDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByLogoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByLogoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByPoliticaGarantia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'politicaGarantia', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByPoliticaGarantiaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'politicaGarantia', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByPoliticaPrivacidade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'politicaPrivacidade', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByPoliticaPrivacidadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'politicaPrivacidade', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenBySlogan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slogan', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenBySloganDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slogan', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByTelefone1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone1', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByTelefone1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone1', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByTelefone2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone2', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByTelefone2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone2', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension EmpresaQueryWhereDistinct
    on QueryBuilder<Empresa, Empresa, QDistinct> {
  QueryBuilder<Empresa, Empresa, QDistinct> distinctByAssinatura() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assinatura');
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByAssinaturaUrl({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'assinaturaUrl',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByCnpj({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cnpj', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByEmail({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByEndereco({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endereco', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByHoraAbertura() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'horaAbertura');
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByHoraFechamento() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'horaFechamento');
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDirty');
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByLogoBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logoBytes');
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByLogoUrl({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logoUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByNome({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByPoliticaGarantia({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'politicaGarantia',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByPoliticaPrivacidade({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'politicaPrivacidade',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctBySlogan({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'slogan', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByTelefone1({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'telefone1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByTelefone2({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'telefone2', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension EmpresaQueryProperty
    on QueryBuilder<Empresa, Empresa, QQueryProperty> {
  QueryBuilder<Empresa, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Empresa, List<int>?, QQueryOperations> assinaturaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assinatura');
    });
  }

  QueryBuilder<Empresa, String?, QQueryOperations> assinaturaUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assinaturaUrl');
    });
  }

  QueryBuilder<Empresa, String?, QQueryOperations> cnpjProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cnpj');
    });
  }

  QueryBuilder<Empresa, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Empresa, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<Empresa, String?, QQueryOperations> enderecoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endereco');
    });
  }

  QueryBuilder<Empresa, int?, QQueryOperations> horaAberturaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'horaAbertura');
    });
  }

  QueryBuilder<Empresa, int?, QQueryOperations> horaFechamentoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'horaFechamento');
    });
  }

  QueryBuilder<Empresa, bool, QQueryOperations> isDirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDirty');
    });
  }

  QueryBuilder<Empresa, List<int>?, QQueryOperations> logoBytesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logoBytes');
    });
  }

  QueryBuilder<Empresa, String?, QQueryOperations> logoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logoUrl');
    });
  }

  QueryBuilder<Empresa, String?, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<Empresa, String?, QQueryOperations> politicaGarantiaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'politicaGarantia');
    });
  }

  QueryBuilder<Empresa, String?, QQueryOperations>
  politicaPrivacidadeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'politicaPrivacidade');
    });
  }

  QueryBuilder<Empresa, String?, QQueryOperations> sloganProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'slogan');
    });
  }

  QueryBuilder<Empresa, String?, QQueryOperations> telefone1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'telefone1');
    });
  }

  QueryBuilder<Empresa, String?, QQueryOperations> telefone2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'telefone2');
    });
  }

  QueryBuilder<Empresa, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
