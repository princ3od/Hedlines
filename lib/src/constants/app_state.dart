enum AppState {
  loading,
  loaded,
}

extension EnumComparisonOperators on AppState {
  bool operator <(AppState other) {
    return index < other.index;
  }

  bool operator <=(AppState other) {
    return index <= other.index;
  }

  bool operator >(AppState other) {
    return index > other.index;
  }

  bool operator >=(AppState other) {
    return index >= other.index;
  }
}
