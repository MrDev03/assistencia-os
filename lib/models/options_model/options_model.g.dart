// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCargoSettingsCollection on Isar {
  IsarCollection<CargoSettings> get cargoSettings => this.collection();
}

const CargoSettingsSchema = CollectionSchema(
  name: r'CargoSettings',
  id: -365006894477035168,
  properties: {
    r'cargo': PropertySchema(id: 0, name: r'cargo', type: IsarType.string),
  },

  estimateSize: _cargoSettingsEstimateSize,
  serialize: _cargoSettingsSerialize,
  deserialize: _cargoSettingsDeserialize,
  deserializeProp: _cargoSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _cargoSettingsGetId,
  getLinks: _cargoSettingsGetLinks,
  attach: _cargoSettingsAttach,
  version: '3.3.0',
);

int _cargoSettingsEstimateSize(
  CargoSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.cargo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cargoSettingsSerialize(
  CargoSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cargo);
}

CargoSettings _cargoSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CargoSettings();
  object.cargo = reader.readStringOrNull(offsets[0]);
  object.id = id;
  return object;
}

P _cargoSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cargoSettingsGetId(CargoSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cargoSettingsGetLinks(CargoSettings object) {
  return [];
}

void _cargoSettingsAttach(
  IsarCollection<dynamic> col,
  Id id,
  CargoSettings object,
) {
  object.id = id;
}

extension CargoSettingsQueryWhereSort
    on QueryBuilder<CargoSettings, CargoSettings, QWhere> {
  QueryBuilder<CargoSettings, CargoSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CargoSettingsQueryWhere
    on QueryBuilder<CargoSettings, CargoSettings, QWhereClause> {
  QueryBuilder<CargoSettings, CargoSettings, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CargoSettings, CargoSettings, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterWhereClause> idBetween(
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

extension CargoSettingsQueryFilter
    on QueryBuilder<CargoSettings, CargoSettings, QFilterCondition> {
  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  cargoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cargo'),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  cargoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cargo'),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  cargoEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cargo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  cargoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cargo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  cargoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cargo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  cargoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cargo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  cargoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'cargo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  cargoEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'cargo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  cargoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'cargo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  cargoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'cargo',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  cargoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cargo', value: ''),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  cargoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'cargo', value: ''),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
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

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CargoSettings, CargoSettings, QAfterFilterCondition> idBetween(
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
}

extension CargoSettingsQueryObject
    on QueryBuilder<CargoSettings, CargoSettings, QFilterCondition> {}

extension CargoSettingsQueryLinks
    on QueryBuilder<CargoSettings, CargoSettings, QFilterCondition> {}

extension CargoSettingsQuerySortBy
    on QueryBuilder<CargoSettings, CargoSettings, QSortBy> {
  QueryBuilder<CargoSettings, CargoSettings, QAfterSortBy> sortByCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cargo', Sort.asc);
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterSortBy> sortByCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cargo', Sort.desc);
    });
  }
}

extension CargoSettingsQuerySortThenBy
    on QueryBuilder<CargoSettings, CargoSettings, QSortThenBy> {
  QueryBuilder<CargoSettings, CargoSettings, QAfterSortBy> thenByCargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cargo', Sort.asc);
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterSortBy> thenByCargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cargo', Sort.desc);
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CargoSettings, CargoSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension CargoSettingsQueryWhereDistinct
    on QueryBuilder<CargoSettings, CargoSettings, QDistinct> {
  QueryBuilder<CargoSettings, CargoSettings, QDistinct> distinctByCargo({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cargo', caseSensitive: caseSensitive);
    });
  }
}

extension CargoSettingsQueryProperty
    on QueryBuilder<CargoSettings, CargoSettings, QQueryProperty> {
  QueryBuilder<CargoSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CargoSettings, String?, QQueryOperations> cargoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cargo');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSubscriptionSettingsCollection on Isar {
  IsarCollection<SubscriptionSettings> get subscriptionSettings =>
      this.collection();
}

const SubscriptionSettingsSchema = CollectionSchema(
  name: r'SubscriptionSettings',
  id: -2820207284198269104,
  properties: {
    r'isPremium': PropertySchema(
      id: 0,
      name: r'isPremium',
      type: IsarType.bool,
    ),
  },

  estimateSize: _subscriptionSettingsEstimateSize,
  serialize: _subscriptionSettingsSerialize,
  deserialize: _subscriptionSettingsDeserialize,
  deserializeProp: _subscriptionSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _subscriptionSettingsGetId,
  getLinks: _subscriptionSettingsGetLinks,
  attach: _subscriptionSettingsAttach,
  version: '3.3.0',
);

int _subscriptionSettingsEstimateSize(
  SubscriptionSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _subscriptionSettingsSerialize(
  SubscriptionSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isPremium);
}

SubscriptionSettings _subscriptionSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SubscriptionSettings();
  object.id = id;
  object.isPremium = reader.readBool(offsets[0]);
  return object;
}

P _subscriptionSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _subscriptionSettingsGetId(SubscriptionSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _subscriptionSettingsGetLinks(
  SubscriptionSettings object,
) {
  return [];
}

void _subscriptionSettingsAttach(
  IsarCollection<dynamic> col,
  Id id,
  SubscriptionSettings object,
) {
  object.id = id;
}

extension SubscriptionSettingsQueryWhereSort
    on QueryBuilder<SubscriptionSettings, SubscriptionSettings, QWhere> {
  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SubscriptionSettingsQueryWhere
    on QueryBuilder<SubscriptionSettings, SubscriptionSettings, QWhereClause> {
  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QAfterWhereClause>
  idNotEqualTo(Id id) {
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

  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QAfterWhereClause>
  idBetween(
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

extension SubscriptionSettingsQueryFilter
    on
        QueryBuilder<
          SubscriptionSettings,
          SubscriptionSettings,
          QFilterCondition
        > {
  QueryBuilder<
    SubscriptionSettings,
    SubscriptionSettings,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    SubscriptionSettings,
    SubscriptionSettings,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
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

  QueryBuilder<
    SubscriptionSettings,
    SubscriptionSettings,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
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

  QueryBuilder<
    SubscriptionSettings,
    SubscriptionSettings,
    QAfterFilterCondition
  >
  idBetween(
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

  QueryBuilder<
    SubscriptionSettings,
    SubscriptionSettings,
    QAfterFilterCondition
  >
  isPremiumEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isPremium', value: value),
      );
    });
  }
}

extension SubscriptionSettingsQueryObject
    on
        QueryBuilder<
          SubscriptionSettings,
          SubscriptionSettings,
          QFilterCondition
        > {}

extension SubscriptionSettingsQueryLinks
    on
        QueryBuilder<
          SubscriptionSettings,
          SubscriptionSettings,
          QFilterCondition
        > {}

extension SubscriptionSettingsQuerySortBy
    on QueryBuilder<SubscriptionSettings, SubscriptionSettings, QSortBy> {
  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QAfterSortBy>
  sortByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QAfterSortBy>
  sortByIsPremiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.desc);
    });
  }
}

extension SubscriptionSettingsQuerySortThenBy
    on QueryBuilder<SubscriptionSettings, SubscriptionSettings, QSortThenBy> {
  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QAfterSortBy>
  thenByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QAfterSortBy>
  thenByIsPremiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPremium', Sort.desc);
    });
  }
}

extension SubscriptionSettingsQueryWhereDistinct
    on QueryBuilder<SubscriptionSettings, SubscriptionSettings, QDistinct> {
  QueryBuilder<SubscriptionSettings, SubscriptionSettings, QDistinct>
  distinctByIsPremium() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPremium');
    });
  }
}

extension SubscriptionSettingsQueryProperty
    on
        QueryBuilder<
          SubscriptionSettings,
          SubscriptionSettings,
          QQueryProperty
        > {
  QueryBuilder<SubscriptionSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SubscriptionSettings, bool, QQueryOperations>
  isPremiumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPremium');
    });
  }
}
