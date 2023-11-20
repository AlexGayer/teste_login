// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InfoStore on _InfoStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_InfoStore.loading'))
      .value;

  late final _$_loadingAtom =
      Atom(name: '_InfoStore._loading', context: context);

  @override
  bool get _loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  late final _$infoListAtom =
      Atom(name: '_InfoStore.infoList', context: context);

  @override
  ObservableList<String> get infoList {
    _$infoListAtom.reportRead();
    return super.infoList;
  }

  @override
  set infoList(ObservableList<String> value) {
    _$infoListAtom.reportWrite(value, super.infoList, () {
      super.infoList = value;
    });
  }

  @override
  String toString() {
    return '''
infoList: ${infoList},
loading: ${loading}
    ''';
  }
}
