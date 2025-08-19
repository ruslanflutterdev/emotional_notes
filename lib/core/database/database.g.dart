// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, description, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Note> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final int id;
  final String title;
  final String? description;
  final DateTime createdAt;
  const Note({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory Note.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Note copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
  }) => Note(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Note> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  NotesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime>? createdAt,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $EmotionsTable extends Emotions with TableInfo<$EmotionsTable, Emotion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmotionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
    'note_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES notes (id)',
    ),
  );
  static const VerificationMeta _emotionNameMeta = const VerificationMeta(
    'emotionName',
  );
  @override
  late final GeneratedColumn<String> emotionName = GeneratedColumn<String>(
    'emotion_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _percentageMeta = const VerificationMeta(
    'percentage',
  );
  @override
  late final GeneratedColumn<int> percentage = GeneratedColumn<int>(
    'percentage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, noteId, emotionName, percentage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emotions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Emotion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('note_id')) {
      context.handle(
        _noteIdMeta,
        noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('emotion_name')) {
      context.handle(
        _emotionNameMeta,
        emotionName.isAcceptableOrUnknown(
          data['emotion_name']!,
          _emotionNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emotionNameMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
        _percentageMeta,
        percentage.isAcceptableOrUnknown(data['percentage']!, _percentageMeta),
      );
    } else if (isInserting) {
      context.missing(_percentageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Emotion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Emotion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      noteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}note_id'],
      )!,
      emotionName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emotion_name'],
      )!,
      percentage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}percentage'],
      )!,
    );
  }

  @override
  $EmotionsTable createAlias(String alias) {
    return $EmotionsTable(attachedDatabase, alias);
  }
}

class Emotion extends DataClass implements Insertable<Emotion> {
  final int id;
  final int noteId;
  final String emotionName;
  final int percentage;
  const Emotion({
    required this.id,
    required this.noteId,
    required this.emotionName,
    required this.percentage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['note_id'] = Variable<int>(noteId);
    map['emotion_name'] = Variable<String>(emotionName);
    map['percentage'] = Variable<int>(percentage);
    return map;
  }

  EmotionsCompanion toCompanion(bool nullToAbsent) {
    return EmotionsCompanion(
      id: Value(id),
      noteId: Value(noteId),
      emotionName: Value(emotionName),
      percentage: Value(percentage),
    );
  }

  factory Emotion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Emotion(
      id: serializer.fromJson<int>(json['id']),
      noteId: serializer.fromJson<int>(json['noteId']),
      emotionName: serializer.fromJson<String>(json['emotionName']),
      percentage: serializer.fromJson<int>(json['percentage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'noteId': serializer.toJson<int>(noteId),
      'emotionName': serializer.toJson<String>(emotionName),
      'percentage': serializer.toJson<int>(percentage),
    };
  }

  Emotion copyWith({
    int? id,
    int? noteId,
    String? emotionName,
    int? percentage,
  }) => Emotion(
    id: id ?? this.id,
    noteId: noteId ?? this.noteId,
    emotionName: emotionName ?? this.emotionName,
    percentage: percentage ?? this.percentage,
  );
  Emotion copyWithCompanion(EmotionsCompanion data) {
    return Emotion(
      id: data.id.present ? data.id.value : this.id,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      emotionName: data.emotionName.present
          ? data.emotionName.value
          : this.emotionName,
      percentage: data.percentage.present
          ? data.percentage.value
          : this.percentage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Emotion(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('emotionName: $emotionName, ')
          ..write('percentage: $percentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, noteId, emotionName, percentage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Emotion &&
          other.id == this.id &&
          other.noteId == this.noteId &&
          other.emotionName == this.emotionName &&
          other.percentage == this.percentage);
}

class EmotionsCompanion extends UpdateCompanion<Emotion> {
  final Value<int> id;
  final Value<int> noteId;
  final Value<String> emotionName;
  final Value<int> percentage;
  const EmotionsCompanion({
    this.id = const Value.absent(),
    this.noteId = const Value.absent(),
    this.emotionName = const Value.absent(),
    this.percentage = const Value.absent(),
  });
  EmotionsCompanion.insert({
    this.id = const Value.absent(),
    required int noteId,
    required String emotionName,
    required int percentage,
  }) : noteId = Value(noteId),
       emotionName = Value(emotionName),
       percentage = Value(percentage);
  static Insertable<Emotion> custom({
    Expression<int>? id,
    Expression<int>? noteId,
    Expression<String>? emotionName,
    Expression<int>? percentage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteId != null) 'note_id': noteId,
      if (emotionName != null) 'emotion_name': emotionName,
      if (percentage != null) 'percentage': percentage,
    });
  }

  EmotionsCompanion copyWith({
    Value<int>? id,
    Value<int>? noteId,
    Value<String>? emotionName,
    Value<int>? percentage,
  }) {
    return EmotionsCompanion(
      id: id ?? this.id,
      noteId: noteId ?? this.noteId,
      emotionName: emotionName ?? this.emotionName,
      percentage: percentage ?? this.percentage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (emotionName.present) {
      map['emotion_name'] = Variable<String>(emotionName.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<int>(percentage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmotionsCompanion(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('emotionName: $emotionName, ')
          ..write('percentage: $percentage')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $EmotionsTable emotions = $EmotionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notes, emotions];
}

typedef $$NotesTableCreateCompanionBuilder =
    NotesCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      Value<DateTime> createdAt,
    });
typedef $$NotesTableUpdateCompanionBuilder =
    NotesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<DateTime> createdAt,
    });

final class $$NotesTableReferences
    extends BaseReferences<_$AppDatabase, $NotesTable, Note> {
  $$NotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EmotionsTable, List<Emotion>> _emotionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.emotions,
    aliasName: $_aliasNameGenerator(db.notes.id, db.emotions.noteId),
  );

  $$EmotionsTableProcessedTableManager get emotionsRefs {
    final manager = $$EmotionsTableTableManager(
      $_db,
      $_db.emotions,
    ).filter((f) => f.noteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_emotionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> emotionsRefs(
    Expression<bool> Function($$EmotionsTableFilterComposer f) f,
  ) {
    final $$EmotionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.emotions,
      getReferencedColumn: (t) => t.noteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmotionsTableFilterComposer(
            $db: $db,
            $table: $db.emotions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> emotionsRefs<T extends Object>(
    Expression<T> Function($$EmotionsTableAnnotationComposer a) f,
  ) {
    final $$EmotionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.emotions,
      getReferencedColumn: (t) => t.noteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmotionsTableAnnotationComposer(
            $db: $db,
            $table: $db.emotions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTable,
          Note,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (Note, $$NotesTableReferences),
          Note,
          PrefetchHooks Function({bool emotionsRefs})
        > {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => NotesCompanion(
                id: id,
                title: title,
                description: description,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => NotesCompanion.insert(
                id: id,
                title: title,
                description: description,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$NotesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({emotionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (emotionsRefs) db.emotions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (emotionsRefs)
                    await $_getPrefetchedData<Note, $NotesTable, Emotion>(
                      currentTable: table,
                      referencedTable: $$NotesTableReferences
                          ._emotionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$NotesTableReferences(db, table, p0).emotionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.noteId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTable,
      Note,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (Note, $$NotesTableReferences),
      Note,
      PrefetchHooks Function({bool emotionsRefs})
    >;
typedef $$EmotionsTableCreateCompanionBuilder =
    EmotionsCompanion Function({
      Value<int> id,
      required int noteId,
      required String emotionName,
      required int percentage,
    });
typedef $$EmotionsTableUpdateCompanionBuilder =
    EmotionsCompanion Function({
      Value<int> id,
      Value<int> noteId,
      Value<String> emotionName,
      Value<int> percentage,
    });

final class $$EmotionsTableReferences
    extends BaseReferences<_$AppDatabase, $EmotionsTable, Emotion> {
  $$EmotionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $NotesTable _noteIdTable(_$AppDatabase db) => db.notes.createAlias(
    $_aliasNameGenerator(db.emotions.noteId, db.notes.id),
  );

  $$NotesTableProcessedTableManager get noteId {
    final $_column = $_itemColumn<int>('note_id')!;

    final manager = $$NotesTableTableManager(
      $_db,
      $_db.notes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_noteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EmotionsTableFilterComposer
    extends Composer<_$AppDatabase, $EmotionsTable> {
  $$EmotionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emotionName => $composableBuilder(
    column: $table.emotionName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnFilters(column),
  );

  $$NotesTableFilterComposer get noteId {
    final $$NotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noteId,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableFilterComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmotionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EmotionsTable> {
  $$EmotionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emotionName => $composableBuilder(
    column: $table.emotionName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnOrderings(column),
  );

  $$NotesTableOrderingComposer get noteId {
    final $$NotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noteId,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableOrderingComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmotionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmotionsTable> {
  $$EmotionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get emotionName => $composableBuilder(
    column: $table.emotionName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => column,
  );

  $$NotesTableAnnotationComposer get noteId {
    final $$NotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noteId,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableAnnotationComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmotionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmotionsTable,
          Emotion,
          $$EmotionsTableFilterComposer,
          $$EmotionsTableOrderingComposer,
          $$EmotionsTableAnnotationComposer,
          $$EmotionsTableCreateCompanionBuilder,
          $$EmotionsTableUpdateCompanionBuilder,
          (Emotion, $$EmotionsTableReferences),
          Emotion,
          PrefetchHooks Function({bool noteId})
        > {
  $$EmotionsTableTableManager(_$AppDatabase db, $EmotionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmotionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmotionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmotionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> noteId = const Value.absent(),
                Value<String> emotionName = const Value.absent(),
                Value<int> percentage = const Value.absent(),
              }) => EmotionsCompanion(
                id: id,
                noteId: noteId,
                emotionName: emotionName,
                percentage: percentage,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int noteId,
                required String emotionName,
                required int percentage,
              }) => EmotionsCompanion.insert(
                id: id,
                noteId: noteId,
                emotionName: emotionName,
                percentage: percentage,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EmotionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({noteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (noteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.noteId,
                                referencedTable: $$EmotionsTableReferences
                                    ._noteIdTable(db),
                                referencedColumn: $$EmotionsTableReferences
                                    ._noteIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EmotionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmotionsTable,
      Emotion,
      $$EmotionsTableFilterComposer,
      $$EmotionsTableOrderingComposer,
      $$EmotionsTableAnnotationComposer,
      $$EmotionsTableCreateCompanionBuilder,
      $$EmotionsTableUpdateCompanionBuilder,
      (Emotion, $$EmotionsTableReferences),
      Emotion,
      PrefetchHooks Function({bool noteId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$EmotionsTableTableManager get emotions =>
      $$EmotionsTableTableManager(_db, _db.emotions);
}
