// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tecnicos_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTecnicosCollection on Isar {
  IsarCollection<Tecnicos> get tecnicos => this.collection();
}

const TecnicosSchema = CollectionSchema(
  name: r'Tecnicos',
  id: 1929938441364867987,
  properties: {
    r'comissao': PropertySchema(
      id: 0,
      name: r'comissao',
      type: IsarType.double,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dateTimeCadastro': PropertySchema(
      id: 2,
      name: r'dateTimeCadastro',
      type: IsarType.string,
    ),
    r'isDirty': PropertySchema(id: 3, name: r'isDirty', type: IsarType.bool),
    r'metaMensal': PropertySchema(
      id: 4,
      name: r'metaMensal',
      type: IsarType.double,
    ),
    r'nome': PropertySchema(id: 5, name: r'nome', type: IsarType.string),
    r'numero': PropertySchema(id: 6, name: r'numero', type: IsarType.string),
    r'observacoes': PropertySchema(
      id: 7,
      name: r'observacoes',
      type: IsarType.string,
    ),
    r'salario': PropertySchema(id: 8, name: r'salario', type: IsarType.double),
    r'tempoExperiencia': PropertySchema(
      id: 9,
      name: r'tempoExperiencia',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 10,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _tecnicosEstimateSize,
  serialize: _tecnicosSerialize,
  deserialize: _tecnicosDeserialize,
  deserializeProp: _tecnicosDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _tecnicosGetId,
  getLinks: _tecnicosGetLinks,
  attach: _tecnicosAttach,
  version: '3.3.0',
);

int _tecnicosEstimateSize(
  Tecnicos object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dateTimeCadastro.length * 3;
  bytesCount += 3 + object.nome.length * 3;
  {
    final value = object.numero;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.observacoes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tempoExperiencia;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _tecnicosSerialize(
  Tecnicos object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.comissao);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.dateTimeCadastro);
  writer.writeBool(offsets[3], object.isDirty);
  writer.writeDouble(offsets[4], object.metaMensal);
  writer.writeString(offsets[5], object.nome);
  writer.writeString(offsets[6], object.numero);
  writer.writeString(offsets[7], object.observacoes);
  writer.writeDouble(offsets[8], object.salario);
  writer.writeString(offsets[9], object.tempoExperiencia);
  writer.writeDateTime(offsets[10], object.updatedAt);
}

Tecnicos _tecnicosDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Tecnicos();
  object.comissao = reader.readDoubleOrNull(offsets[0]);
  object.createdAt = reader.readDateTimeOrNull(offsets[1]);
  object.dateTimeCadastro = reader.readString(offsets[2]);
  object.id = id;
  object.isDirty = reader.readBool(offsets[3]);
  object.metaMensal = reader.readDoubleOrNull(offsets[4]);
  object.nome = reader.readString(offsets[5]);
  object.numero = reader.readStringOrNull(offsets[6]);
  object.observacoes = reader.readStringOrNull(offsets[7]);
  object.salario = reader.readDoubleOrNull(offsets[8]);
  object.tempoExperiencia = reader.readStringOrNull(offsets[9]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[10]);
  return object;
}

P _tecnicosDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tecnicosGetId(Tecnicos object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tecnicosGetLinks(Tecnicos object) {
  return [];
}

void _tecnicosAttach(IsarCollection<dynamic> col, Id id, Tecnicos object) {
  object.id = id;
}

extension TecnicosQueryWhereSort on QueryBuilder<Tecnicos, Tecnicos, QWhere> {
  QueryBuilder<Tecnicos, Tecnicos, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TecnicosQueryWhere on QueryBuilder<Tecnicos, Tecnicos, QWhereClause> {
  QueryBuilder<Tecnicos, Tecnicos, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterWhereClause> idBetween(
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

extension TecnicosQueryFilter
    on QueryBuilder<Tecnicos, Tecnicos, QFilterCondition> {
  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> comissaoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'comissao'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> comissaoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'comissao'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> comissaoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'comissao',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> comissaoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'comissao',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> comissaoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'comissao',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> comissaoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'comissao',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> createdAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  dateTimeCadastroEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dateTimeCadastro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  dateTimeCadastroGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dateTimeCadastro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  dateTimeCadastroLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dateTimeCadastro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  dateTimeCadastroBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dateTimeCadastro',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  dateTimeCadastroStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'dateTimeCadastro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  dateTimeCadastroEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'dateTimeCadastro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  dateTimeCadastroContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'dateTimeCadastro',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  dateTimeCadastroMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'dateTimeCadastro',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  dateTimeCadastroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dateTimeCadastro', value: ''),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  dateTimeCadastroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'dateTimeCadastro', value: ''),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> isDirtyEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isDirty', value: value),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> metaMensalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'metaMensal'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  metaMensalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'metaMensal'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> metaMensalEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'metaMensal',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> metaMensalGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'metaMensal',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> metaMensalLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'metaMensal',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> metaMensalBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'metaMensal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> nomeEqualTo(
    String value, {
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> nomeGreaterThan(
    String value, {
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> nomeLessThan(
    String value, {
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> nomeBetween(
    String lower,
    String upper, {
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> nomeStartsWith(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> nomeEndsWith(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> nomeContains(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> nomeMatches(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nome', value: ''),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nome', value: ''),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> numeroIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'numero'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> numeroIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'numero'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> numeroEqualTo(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> numeroGreaterThan(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> numeroLessThan(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> numeroBetween(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> numeroStartsWith(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> numeroEndsWith(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> numeroContains(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> numeroMatches(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> numeroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'numero', value: ''),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> numeroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'numero', value: ''),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> observacoesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'observacoes'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  observacoesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'observacoes'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> observacoesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'observacoes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  observacoesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'observacoes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> observacoesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'observacoes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> observacoesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'observacoes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> observacoesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'observacoes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> observacoesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'observacoes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> observacoesContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'observacoes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> observacoesMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'observacoes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> observacoesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'observacoes', value: ''),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  observacoesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'observacoes', value: ''),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> salarioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'salario'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> salarioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'salario'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> salarioEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'salario',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> salarioGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'salario',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> salarioLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'salario',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> salarioBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'salario',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  tempoExperienciaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tempoExperiencia'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  tempoExperienciaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tempoExperiencia'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  tempoExperienciaEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tempoExperiencia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  tempoExperienciaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tempoExperiencia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  tempoExperienciaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tempoExperiencia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  tempoExperienciaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tempoExperiencia',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  tempoExperienciaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'tempoExperiencia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  tempoExperienciaEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'tempoExperiencia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  tempoExperienciaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'tempoExperiencia',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  tempoExperienciaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'tempoExperiencia',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  tempoExperienciaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tempoExperiencia', value: ''),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition>
  tempoExperienciaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'tempoExperiencia', value: ''),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> updatedAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<Tecnicos, Tecnicos, QAfterFilterCondition> updatedAtBetween(
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

extension TecnicosQueryObject
    on QueryBuilder<Tecnicos, Tecnicos, QFilterCondition> {}

extension TecnicosQueryLinks
    on QueryBuilder<Tecnicos, Tecnicos, QFilterCondition> {}

extension TecnicosQuerySortBy on QueryBuilder<Tecnicos, Tecnicos, QSortBy> {
  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByComissao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comissao', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByComissaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comissao', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByDateTimeCadastro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTimeCadastro', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByDateTimeCadastroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTimeCadastro', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByIsDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByMetaMensal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metaMensal', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByMetaMensalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metaMensal', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByObservacoes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByObservacoesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortBySalario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salario', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortBySalarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salario', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByTempoExperiencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempoExperiencia', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByTempoExperienciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempoExperiencia', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension TecnicosQuerySortThenBy
    on QueryBuilder<Tecnicos, Tecnicos, QSortThenBy> {
  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByComissao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comissao', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByComissaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comissao', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByDateTimeCadastro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTimeCadastro', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByDateTimeCadastroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTimeCadastro', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByIsDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByMetaMensal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metaMensal', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByMetaMensalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metaMensal', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByObservacoes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByObservacoesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenBySalario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salario', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenBySalarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salario', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByTempoExperiencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempoExperiencia', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByTempoExperienciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempoExperiencia', Sort.desc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension TecnicosQueryWhereDistinct
    on QueryBuilder<Tecnicos, Tecnicos, QDistinct> {
  QueryBuilder<Tecnicos, Tecnicos, QDistinct> distinctByComissao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comissao');
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QDistinct> distinctByDateTimeCadastro({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'dateTimeCadastro',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QDistinct> distinctByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDirty');
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QDistinct> distinctByMetaMensal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'metaMensal');
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QDistinct> distinctByNome({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QDistinct> distinctByNumero({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numero', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QDistinct> distinctByObservacoes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'observacoes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QDistinct> distinctBySalario() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'salario');
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QDistinct> distinctByTempoExperiencia({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'tempoExperiencia',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Tecnicos, Tecnicos, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension TecnicosQueryProperty
    on QueryBuilder<Tecnicos, Tecnicos, QQueryProperty> {
  QueryBuilder<Tecnicos, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Tecnicos, double?, QQueryOperations> comissaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comissao');
    });
  }

  QueryBuilder<Tecnicos, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Tecnicos, String, QQueryOperations> dateTimeCadastroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTimeCadastro');
    });
  }

  QueryBuilder<Tecnicos, bool, QQueryOperations> isDirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDirty');
    });
  }

  QueryBuilder<Tecnicos, double?, QQueryOperations> metaMensalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metaMensal');
    });
  }

  QueryBuilder<Tecnicos, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<Tecnicos, String?, QQueryOperations> numeroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numero');
    });
  }

  QueryBuilder<Tecnicos, String?, QQueryOperations> observacoesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'observacoes');
    });
  }

  QueryBuilder<Tecnicos, double?, QQueryOperations> salarioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'salario');
    });
  }

  QueryBuilder<Tecnicos, String?, QQueryOperations> tempoExperienciaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tempoExperiencia');
    });
  }

  QueryBuilder<Tecnicos, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
