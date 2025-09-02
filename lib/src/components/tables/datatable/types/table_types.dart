import 'package:syncfusion_flutter_datagrid/datagrid.dart';

typedef DataObject = List<List<Map<String, dynamic>>>;
typedef TableSelectionChangedCallback =
    void Function(List<DataGridRow> addedRows, List<DataGridRow> removedRows);
typedef ToMap = DataObject Function();
