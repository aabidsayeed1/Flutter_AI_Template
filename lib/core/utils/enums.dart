/// Shared enums across the application
enum LoadingStatus { initial, loading, success, failure, empty }

enum SortOrder { ascending, descending }

enum FilterType { all, active, inactive, archived }

enum DateRangeType {
  today,
  yesterday,
  thisWeek,
  lastWeek,
  thisMonth,
  lastMonth,
  custom,
}
