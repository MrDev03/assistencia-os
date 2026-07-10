// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estoque_pecas_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEstoquePecasCollection on Isar {
  IsarCollection<EstoquePecas> get estoquePecas => this.collection();
}

const EstoquePecasSchema = CollectionSchema(
  name: r'EstoquePecas',
  id: 7352297644586450731,
  properties: {
    r'aro': PropertySchema(id: 0, name: r'aro', type: IsarType.bool),
    r'barCode': PropertySchema(id: 1, name: r'barCode', type: IsarType.string),
    r'cor': PropertySchema(id: 2, name: r'cor', type: IsarType.string),
    r'dataCadastro': PropertySchema(
      id: 3,
      name: r'dataCadastro',
      type: IsarType.dateTime,
    ),
    r'dataUltimaAtualizacao': PropertySchema(
      id: 4,
      name: r'dataUltimaAtualizacao',
      type: IsarType.dateTime,
    ),
    r'descricao': PropertySchema(
      id: 5,
      name: r'descricao',
      type: IsarType.string,
    ),
    r'fotosLocal': PropertySchema(
      id: 6,
      name: r'fotosLocal',
      type: IsarType.stringList,
    ),
    r'fotosUrl': PropertySchema(
      id: 7,
      name: r'fotosUrl',
      type: IsarType.stringList,
    ),
    r'marca': PropertySchema(id: 8, name: r'marca', type: IsarType.string),
    r'modelo': PropertySchema(id: 9, name: r'modelo', type: IsarType.string),
    r'modelosCompativeis': PropertySchema(
      id: 10,
      name: r'modelosCompativeis',
      type: IsarType.stringList,
    ),
    r'qualidadeTela': PropertySchema(
      id: 11,
      name: r'qualidadeTela',
      type: IsarType.string,
    ),
    r'quantidade': PropertySchema(
      id: 12,
      name: r'quantidade',
      type: IsarType.long,
    ),
    r'tipo': PropertySchema(id: 13, name: r'tipo', type: IsarType.string),
    r'usada': PropertySchema(id: 14, name: r'usada', type: IsarType.bool),
    r'valorCusto': PropertySchema(
      id: 15,
      name: r'valorCusto',
      type: IsarType.double,
    ),
    r'valorVenda': PropertySchema(
      id: 16,
      name: r'valorVenda',
      type: IsarType.double,
    ),
  },

  estimateSize: _estoquePecasEstimateSize,
  serialize: _estoquePecasSerialize,
  deserialize: _estoquePecasDeserialize,
  deserializeProp: _estoquePecasDeserializeProp,
  idName: r'id',
  indexes: {
    r'barCode': IndexSchema(
      id: 5426034840582382881,
      name: r'barCode',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'barCode',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _estoquePecasGetId,
  getLinks: _estoquePecasGetLinks,
  attach: _estoquePecasAttach,
  version: '3.3.0',
);

int _estoquePecasEstimateSize(
  EstoquePecas object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.barCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.cor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.descricao;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.fotosLocal.length * 3;
  {
    for (var i = 0; i < object.fotosLocal.length; i++) {
      final value = object.fotosLocal[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.fotosUrl.length * 3;
  {
    for (var i = 0; i < object.fotosUrl.length; i++) {
      final value = object.fotosUrl[i];
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
  bytesCount += 3 + object.modelosCompativeis.length * 3;
  {
    for (var i = 0; i < object.modelosCompativeis.length; i++) {
      final value = object.modelosCompativeis[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.qualidadeTela;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tipo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _estoquePecasSerialize(
  EstoquePecas object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.aro);
  writer.writeString(offsets[1], object.barCode);
  writer.writeString(offsets[2], object.cor);
  writer.writeDateTime(offsets[3], object.dataCadastro);
  writer.writeDateTime(offsets[4], object.dataUltimaAtualizacao);
  writer.writeString(offsets[5], object.descricao);
  writer.writeStringList(offsets[6], object.fotosLocal);
  writer.writeStringList(offsets[7], object.fotosUrl);
  writer.writeString(offsets[8], object.marca);
  writer.writeString(offsets[9], object.modelo);
  writer.writeStringList(offsets[10], object.modelosCompativeis);
  writer.writeString(offsets[11], object.qualidadeTela);
  writer.writeLong(offsets[12], object.quantidade);
  writer.writeString(offsets[13], object.tipo);
  writer.writeBool(offsets[14], object.usada);
  writer.writeDouble(offsets[15], object.valorCusto);
  writer.writeDouble(offsets[16], object.valorVenda);
}

EstoquePecas _estoquePecasDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EstoquePecas();
  object.aro = reader.readBool(offsets[0]);
  object.barCode = reader.readStringOrNull(offsets[1]);
  object.cor = reader.readStringOrNull(offsets[2]);
  object.dataCadastro = reader.readDateTime(offsets[3]);
  object.dataUltimaAtualizacao = reader.readDateTime(offsets[4]);
  object.descricao = reader.readStringOrNull(offsets[5]);
  object.fotosLocal = reader.readStringList(offsets[6]) ?? [];
  object.fotosUrl = reader.readStringList(offsets[7]) ?? [];
  object.id = id;
  object.marca = reader.readStringOrNull(offsets[8]);
  object.modelo = reader.readStringOrNull(offsets[9]);
  object.modelosCompativeis = reader.readStringList(offsets[10]) ?? [];
  object.qualidadeTela = reader.readStringOrNull(offsets[11]);
  object.quantidade = reader.readLong(offsets[12]);
  object.tipo = reader.readStringOrNull(offsets[13]);
  object.usada = reader.readBool(offsets[14]);
  object.valorCusto = reader.readDoubleOrNull(offsets[15]);
  object.valorVenda = reader.readDoubleOrNull(offsets[16]);
  return object;
}

P _estoquePecasDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringList(offset) ?? []) as P;
    case 7:
      return (reader.readStringList(offset) ?? []) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringList(offset) ?? []) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readDoubleOrNull(offset)) as P;
    case 16:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _estoquePecasGetId(EstoquePecas object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _estoquePecasGetLinks(EstoquePecas object) {
  return [];
}

void _estoquePecasAttach(
  IsarCollection<dynamic> col,
  Id id,
  EstoquePecas object,
) {
  object.id = id;
}

extension EstoquePecasQueryWhereSort
    on QueryBuilder<EstoquePecas, EstoquePecas, QWhere> {
  QueryBuilder<EstoquePecas, EstoquePecas, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EstoquePecasQueryWhere
    on QueryBuilder<EstoquePecas, EstoquePecas, QWhereClause> {
  QueryBuilder<EstoquePecas, EstoquePecas, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterWhereClause> idBetween(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterWhereClause> barCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'barCode', value: [null]),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterWhereClause>
  barCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'barCode',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterWhereClause> barCodeEqualTo(
    String? barCode,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'barCode', value: [barCode]),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterWhereClause> barCodeNotEqualTo(
    String? barCode,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'barCode',
                lower: [],
                upper: [barCode],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'barCode',
                lower: [barCode],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'barCode',
                lower: [barCode],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'barCode',
                lower: [],
                upper: [barCode],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension EstoquePecasQueryFilter
    on QueryBuilder<EstoquePecas, EstoquePecas, QFilterCondition> {
  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> aroEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'aro', value: value),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  barCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'barCode'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  barCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'barCode'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  barCodeEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'barCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  barCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'barCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  barCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'barCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  barCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'barCode',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  barCodeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'barCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  barCodeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'barCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  barCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'barCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  barCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'barCode',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  barCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'barCode', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  barCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'barCode', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> corIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cor'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  corIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cor'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> corEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  corGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> corLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> corBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> corStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'cor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> corEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'cor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> corContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'cor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> corMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'cor',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> corIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cor', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  corIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'cor', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  dataCadastroEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dataCadastro', value: value),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  dataCadastroGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dataCadastro',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  dataCadastroLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dataCadastro',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  dataCadastroBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dataCadastro',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  dataUltimaAtualizacaoEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dataUltimaAtualizacao',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  dataUltimaAtualizacaoGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dataUltimaAtualizacao',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  dataUltimaAtualizacaoLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dataUltimaAtualizacao',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  dataUltimaAtualizacaoBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dataUltimaAtualizacao',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  descricaoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'descricao'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  descricaoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'descricao'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  descricaoEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'descricao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  descricaoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'descricao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  descricaoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'descricao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  descricaoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'descricao',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  descricaoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'descricao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  descricaoEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'descricao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  descricaoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'descricao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  descricaoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'descricao',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  descricaoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'descricao', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  descricaoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'descricao', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fotosLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fotosLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fotosLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fotosLocal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fotosLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fotosLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fotosLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fotosLocal',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fotosLocal', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fotosLocal', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotosLocal', length, true, length, true);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotosLocal', 0, true, 0, true);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotosLocal', 0, false, 999999, true);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotosLocal', 0, true, length, include);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotosLocal', length, include, 999999, true);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosLocalLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fotosLocal',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fotosUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fotosUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fotosUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fotosUrl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fotosUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fotosUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fotosUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fotosUrl',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fotosUrl', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fotosUrl', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotosUrl', length, true, length, true);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotosUrl', 0, true, 0, true);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotosUrl', 0, false, 999999, true);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotosUrl', 0, true, length, include);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotosUrl', length, include, 999999, true);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  fotosUrlLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fotosUrl',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> idBetween(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  marcaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'marca'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  marcaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'marca'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> marcaEqualTo(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  marcaGreaterThan(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> marcaLessThan(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> marcaBetween(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  marcaStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> marcaEndsWith(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> marcaContains(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> marcaMatches(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  marcaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'marca', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  marcaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'marca', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modeloIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'modelo'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modeloIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'modelo'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> modeloEqualTo(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modeloGreaterThan(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modeloLessThan(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> modeloBetween(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modeloStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modeloEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modeloContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> modeloMatches(
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

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modeloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'modelo', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modeloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'modelo', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'modelosCompativeis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'modelosCompativeis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'modelosCompativeis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'modelosCompativeis',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'modelosCompativeis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'modelosCompativeis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'modelosCompativeis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisElementMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'modelosCompativeis',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'modelosCompativeis', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'modelosCompativeis', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'modelosCompativeis',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'modelosCompativeis', 0, true, 0, true);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'modelosCompativeis', 0, false, 999999, true);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'modelosCompativeis', 0, true, length, include);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'modelosCompativeis',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  modelosCompativeisLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'modelosCompativeis',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  qualidadeTelaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'qualidadeTela'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  qualidadeTelaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'qualidadeTela'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  qualidadeTelaEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'qualidadeTela',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  qualidadeTelaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'qualidadeTela',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  qualidadeTelaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'qualidadeTela',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  qualidadeTelaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'qualidadeTela',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  qualidadeTelaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'qualidadeTela',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  qualidadeTelaEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'qualidadeTela',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  qualidadeTelaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'qualidadeTela',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  qualidadeTelaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'qualidadeTela',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  qualidadeTelaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'qualidadeTela', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  qualidadeTelaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'qualidadeTela', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  quantidadeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'quantidade', value: value),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  quantidadeGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'quantidade',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  quantidadeLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'quantidade',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  quantidadeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'quantidade',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> tipoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tipo'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  tipoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tipo'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> tipoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tipo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  tipoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tipo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> tipoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tipo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> tipoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tipo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  tipoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'tipo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> tipoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'tipo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> tipoContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'tipo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> tipoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'tipo',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  tipoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tipo', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  tipoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'tipo', value: ''),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition> usadaEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'usada', value: value),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  valorCustoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valorCusto'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  valorCustoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'valorCusto'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  valorCustoEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valorCusto',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  valorCustoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valorCusto',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  valorCustoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valorCusto',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  valorCustoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valorCusto',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  valorVendaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valorVenda'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  valorVendaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'valorVenda'),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  valorVendaEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valorVenda',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  valorVendaGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valorVenda',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  valorVendaLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valorVenda',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterFilterCondition>
  valorVendaBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valorVenda',
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

extension EstoquePecasQueryObject
    on QueryBuilder<EstoquePecas, EstoquePecas, QFilterCondition> {}

extension EstoquePecasQueryLinks
    on QueryBuilder<EstoquePecas, EstoquePecas, QFilterCondition> {}

extension EstoquePecasQuerySortBy
    on QueryBuilder<EstoquePecas, EstoquePecas, QSortBy> {
  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByAro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aro', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByAroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aro', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByBarCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barCode', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByBarCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barCode', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByCor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cor', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByCorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cor', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByDataCadastro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCadastro', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  sortByDataCadastroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCadastro', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  sortByDataUltimaAtualizacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataUltimaAtualizacao', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  sortByDataUltimaAtualizacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataUltimaAtualizacao', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByDescricao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByDescricaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByMarca() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marca', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByMarcaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marca', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByModelo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelo', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByModeloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelo', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByQualidadeTela() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualidadeTela', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  sortByQualidadeTelaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualidadeTela', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByQuantidade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantidade', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  sortByQuantidadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantidade', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByUsada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usada', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByUsadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usada', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByValorCusto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorCusto', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  sortByValorCustoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorCusto', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> sortByValorVenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorVenda', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  sortByValorVendaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorVenda', Sort.desc);
    });
  }
}

extension EstoquePecasQuerySortThenBy
    on QueryBuilder<EstoquePecas, EstoquePecas, QSortThenBy> {
  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByAro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aro', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByAroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aro', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByBarCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barCode', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByBarCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barCode', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByCor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cor', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByCorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cor', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByDataCadastro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCadastro', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  thenByDataCadastroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCadastro', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  thenByDataUltimaAtualizacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataUltimaAtualizacao', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  thenByDataUltimaAtualizacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataUltimaAtualizacao', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByDescricao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByDescricaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByMarca() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marca', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByMarcaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marca', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByModelo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelo', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByModeloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelo', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByQualidadeTela() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualidadeTela', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  thenByQualidadeTelaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualidadeTela', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByQuantidade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantidade', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  thenByQuantidadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantidade', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByUsada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usada', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByUsadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usada', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByValorCusto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorCusto', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  thenByValorCustoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorCusto', Sort.desc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy> thenByValorVenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorVenda', Sort.asc);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QAfterSortBy>
  thenByValorVendaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorVenda', Sort.desc);
    });
  }
}

extension EstoquePecasQueryWhereDistinct
    on QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> {
  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByAro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aro');
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByBarCode({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'barCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByCor({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByDataCadastro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataCadastro');
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct>
  distinctByDataUltimaAtualizacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataUltimaAtualizacao');
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByDescricao({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descricao', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByFotosLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fotosLocal');
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByFotosUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fotosUrl');
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByMarca({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'marca', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByModelo({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct>
  distinctByModelosCompativeis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelosCompativeis');
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByQualidadeTela({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'qualidadeTela',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByQuantidade() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantidade');
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByTipo({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByUsada() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'usada');
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByValorCusto() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorCusto');
    });
  }

  QueryBuilder<EstoquePecas, EstoquePecas, QDistinct> distinctByValorVenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorVenda');
    });
  }
}

extension EstoquePecasQueryProperty
    on QueryBuilder<EstoquePecas, EstoquePecas, QQueryProperty> {
  QueryBuilder<EstoquePecas, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EstoquePecas, bool, QQueryOperations> aroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aro');
    });
  }

  QueryBuilder<EstoquePecas, String?, QQueryOperations> barCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'barCode');
    });
  }

  QueryBuilder<EstoquePecas, String?, QQueryOperations> corProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cor');
    });
  }

  QueryBuilder<EstoquePecas, DateTime, QQueryOperations>
  dataCadastroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataCadastro');
    });
  }

  QueryBuilder<EstoquePecas, DateTime, QQueryOperations>
  dataUltimaAtualizacaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataUltimaAtualizacao');
    });
  }

  QueryBuilder<EstoquePecas, String?, QQueryOperations> descricaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descricao');
    });
  }

  QueryBuilder<EstoquePecas, List<String>, QQueryOperations>
  fotosLocalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fotosLocal');
    });
  }

  QueryBuilder<EstoquePecas, List<String>, QQueryOperations>
  fotosUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fotosUrl');
    });
  }

  QueryBuilder<EstoquePecas, String?, QQueryOperations> marcaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'marca');
    });
  }

  QueryBuilder<EstoquePecas, String?, QQueryOperations> modeloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelo');
    });
  }

  QueryBuilder<EstoquePecas, List<String>, QQueryOperations>
  modelosCompativeisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelosCompativeis');
    });
  }

  QueryBuilder<EstoquePecas, String?, QQueryOperations>
  qualidadeTelaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qualidadeTela');
    });
  }

  QueryBuilder<EstoquePecas, int, QQueryOperations> quantidadeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantidade');
    });
  }

  QueryBuilder<EstoquePecas, String?, QQueryOperations> tipoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipo');
    });
  }

  QueryBuilder<EstoquePecas, bool, QQueryOperations> usadaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'usada');
    });
  }

  QueryBuilder<EstoquePecas, double?, QQueryOperations> valorCustoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorCusto');
    });
  }

  QueryBuilder<EstoquePecas, double?, QQueryOperations> valorVendaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorVenda');
    });
  }
}
