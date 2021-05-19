import 'dart:developer';

import 'package:data_picker/src/models/callback.dart';
import 'package:data_picker/src/models/config.dart';
import 'package:data_picker/src/models/list.item.dart';
import 'package:data_picker/src/models/theme.dart';
import 'package:data_picker/src/widgets/data.list.view.dart';
import 'package:flutter/material.dart';

class DataPicker {
  final List<dynamic>? data;
  final Config? config;
  final PickerTheme? theme;
  final PickerCallback callback;

  List<ListItem>? _items;
  Map<String, dynamic> _selectedItems = {};

  DataPicker({
    this.theme = const PickerTheme(),
    required this.data,
    required this.config,
    required this.callback,
  }) {
    _parseData();
  }

  _parseData() {
    //* parse and validate config

    //* initialize selected items
    for (String _default in (config?.defaults ?? [])) {
      _selectedItems[_default] = null;
    }

    //* transform data based on config

    _items = (data ?? []).map(
      (dynamic item) {
        String _label, _leading, _key;
        List<String> _searchFields = [];
        bool _selected = false;

        _label = item[config?.label] ?? 'N/A';
        _leading = item[config?.leading] ?? 'N/A';
        _key = item[config?.key] ?? 'N/A';

        _searchFields = (config?.searchFields ?? [])
            .map(
              (String field) => item[field] as String,
            )
            .toList();

        if (_selectedItems.containsKey(_key)) {
          _selected = true;
          _selectedItems[_key] = item;
        }

        ListItem _item = ListItem(
          key: _key,
          value: item,
          label: _label,
          leading: _leading,
          selected: _selected,
          searchFields: _searchFields,
        );

        return _item;
      },
    ).toList();
  }

  /// Displays the data picker
  void showPicker(BuildContext context) {
    // final ScrollController scrollCtrl = ScrollController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => FractionallySizedBox(
        heightFactor: .8,
        child: DataListView(
          theme: theme!,
          config: config!,
          items: _items ?? [],
          selectedItems: _selectedItems,
          onSelect: (ListItem _item) {
            log(_item.toString(), name: 'DataPicker: Item Selected');
            callback.onSelect(_item.value);
          },
        ),
      ),
    ).whenComplete(
      () {
        if (callback.onClosed != null) callback.onClosed!();
      },
    );
  }
}