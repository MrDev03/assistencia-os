// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atendente_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAtendenteCollection on Isar {
  IsarCollection<Atendente> get atendentes => this.collection();
}

const AtendenteSchema = CollectionSchema(
  name: r'Atendente',
  id: -8201491901465436174,
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

  estimateSize: _atendenteEstimateSize,
  serialize: _atendenteSerialize,
  deserialize: _atendenteDeserialize,
  deserializeProp: _atendenteDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _atendenteGetId,
  getLinks: _atendenteGetLinks,
  attach: _atendenteAttach,
  version: '3.3.0',
);

int _atendenteEstimateSize(
  Atendente object,
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

void _atendenteSerialize(
  Atendente object,
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

Atendente _atendenteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Atendente();
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

P _atendenteDeserializeProp<P>(
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

Id _atendenteGetId(Atendente object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _atendenteGetLinks(Atendente object) {
  return [];
}

void _atendenteAttach(IsarCollection<dynamic> col, Id id, Atendente object) {
  object.id = id;
}

extension AtendenteQueryWhereSort
    on QueryBuilder<Atendente, Atendente, QWhere> {
  QueryBuilder<Atendente, Atendente, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AtendenteQueryWhere
    on QueryBuilder<Atendente, Atendente, QWhereClause> {
  QueryBuilder<Atendente, Atendente, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Atendente, Atendente, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterWhereClause> idBetween(
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

extension AtendenteQueryFilter
    on QueryBuilder<Atendente, Atendente, QFilterCondition> {
  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> comissaoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'comissao'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  comissaoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'comissao'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> comissaoEqualTo(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> comissaoGreaterThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> comissaoLessThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> comissaoBetween(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> createdAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  createdAtGreaterThan(DateTime? value, {bool include = false}) {
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  dateTimeCadastroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dateTimeCadastro', value: ''),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  dateTimeCadastroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'dateTimeCadastro', value: ''),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> isDirtyEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isDirty', value: value),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> metaMensalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'metaMensal'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  metaMensalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'metaMensal'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> metaMensalEqualTo(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  metaMensalGreaterThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> metaMensalLessThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> metaMensalBetween(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> nomeEqualTo(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> nomeGreaterThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> nomeLessThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> nomeBetween(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> nomeStartsWith(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> nomeEndsWith(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> nomeContains(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> nomeMatches(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nome', value: ''),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nome', value: ''),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> numeroIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'numero'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> numeroIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'numero'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> numeroEqualTo(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> numeroGreaterThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> numeroLessThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> numeroBetween(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> numeroStartsWith(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> numeroEndsWith(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> numeroContains(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> numeroMatches(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> numeroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'numero', value: ''),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> numeroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'numero', value: ''),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  observacoesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'observacoes'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  observacoesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'observacoes'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> observacoesEqualTo(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> observacoesLessThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> observacoesBetween(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  observacoesStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> observacoesEndsWith(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> observacoesContains(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> observacoesMatches(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  observacoesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'observacoes', value: ''),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  observacoesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'observacoes', value: ''),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> salarioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'salario'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> salarioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'salario'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> salarioEqualTo(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> salarioGreaterThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> salarioLessThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> salarioBetween(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  tempoExperienciaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tempoExperiencia'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  tempoExperienciaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tempoExperiencia'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  tempoExperienciaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tempoExperiencia', value: ''),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  tempoExperienciaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'tempoExperiencia', value: ''),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> updatedAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime? value, {bool include = false}) {
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<Atendente, Atendente, QAfterFilterCondition> updatedAtBetween(
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

extension AtendenteQueryObject
    on QueryBuilder<Atendente, Atendente, QFilterCondition> {}

extension AtendenteQueryLinks
    on QueryBuilder<Atendente, Atendente, QFilterCondition> {}

extension AtendenteQuerySortBy on QueryBuilder<Atendente, Atendente, QSortBy> {
  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByComissao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comissao', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByComissaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comissao', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByDateTimeCadastro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTimeCadastro', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy>
  sortByDateTimeCadastroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTimeCadastro', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByIsDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByMetaMensal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metaMensal', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByMetaMensalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metaMensal', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByObservacoes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByObservacoesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortBySalario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salario', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortBySalarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salario', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByTempoExperiencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempoExperiencia', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy>
  sortByTempoExperienciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempoExperiencia', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension AtendenteQuerySortThenBy
    on QueryBuilder<Atendente, Atendente, QSortThenBy> {
  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByComissao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comissao', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByComissaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comissao', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByDateTimeCadastro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTimeCadastro', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy>
  thenByDateTimeCadastroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTimeCadastro', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByIsDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByMetaMensal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metaMensal', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByMetaMensalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metaMensal', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByObservacoes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByObservacoesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenBySalario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salario', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenBySalarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salario', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByTempoExperiencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempoExperiencia', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy>
  thenByTempoExperienciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempoExperiencia', Sort.desc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Atendente, Atendente, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension AtendenteQueryWhereDistinct
    on QueryBuilder<Atendente, Atendente, QDistinct> {
  QueryBuilder<Atendente, Atendente, QDistinct> distinctByComissao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comissao');
    });
  }

  QueryBuilder<Atendente, Atendente, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Atendente, Atendente, QDistinct> distinctByDateTimeCadastro({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'dateTimeCadastro',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QDistinct> distinctByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDirty');
    });
  }

  QueryBuilder<Atendente, Atendente, QDistinct> distinctByMetaMensal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'metaMensal');
    });
  }

  QueryBuilder<Atendente, Atendente, QDistinct> distinctByNome({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Atendente, Atendente, QDistinct> distinctByNumero({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numero', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Atendente, Atendente, QDistinct> distinctByObservacoes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'observacoes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Atendente, Atendente, QDistinct> distinctBySalario() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'salario');
    });
  }

  QueryBuilder<Atendente, Atendente, QDistinct> distinctByTempoExperiencia({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'tempoExperiencia',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Atendente, Atendente, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension AtendenteQueryProperty
    on QueryBuilder<Atendente, Atendente, QQueryProperty> {
  QueryBuilder<Atendente, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Atendente, double?, QQueryOperations> comissaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comissao');
    });
  }

  QueryBuilder<Atendente, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Atendente, String, QQueryOperations> dateTimeCadastroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTimeCadastro');
    });
  }

  QueryBuilder<Atendente, bool, QQueryOperations> isDirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDirty');
    });
  }

  QueryBuilder<Atendente, double?, QQueryOperations> metaMensalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metaMensal');
    });
  }

  QueryBuilder<Atendente, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<Atendente, String?, QQueryOperations> numeroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numero');
    });
  }

  QueryBuilder<Atendente, String?, QQueryOperations> observacoesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'observacoes');
    });
  }

  QueryBuilder<Atendente, double?, QQueryOperations> salarioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'salario');
    });
  }

  QueryBuilder<Atendente, String?, QQueryOperations>
  tempoExperienciaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tempoExperiencia');
    });
  }

  QueryBuilder<Atendente, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
