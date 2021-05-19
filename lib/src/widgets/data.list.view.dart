import 'package:data_picker/data_picker.dart';
import 'package:data_picker/src/models/list.item.dart';
import 'package:data_picker/src/models/theme.dart';
import 'package:flutter/material.dart';

class DataListView extends StatefulWidget {
  final List<ListItem> items;
  final Config config;
  final PickerTheme theme;
  final Function(ListItem) onSelect;
  final Map<String, dynamic> selectedItems;

  const DataListView({
    Key? key,
    required this.items,
    required this.theme,
    required this.config,
    required this.onSelect,
    required this.selectedItems,
  }) : super(key: key);

  @override
  _DataListViewState createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> implements ChangeNotifier {
  ValueNotifier<List<ListItem>> filteredItems = ValueNotifier([]);
  late Map<String, dynamic> selectedItems;

  @override
  void initState() {
    _filter();
    selectedItems = widget.selectedItems;

    super.initState();
  }

  _filter({String query = ''}) {
    query = query.toLowerCase();

    filteredItems.value = widget.items.where(
      (ListItem item) {
        bool retain = (item.label ?? '').toLowerCase().startsWith(query);

        if (!retain) {
          for (String field in (item.searchFields ?? [])) {
            retain = field.toLowerCase().startsWith(query);
            if (retain) break;
          }
        }

        return retain;
      },
    ).toList();
    filteredItems.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    PickerTheme theme = widget.theme;

    double horizontalPadding = theme.horizontalPadding ?? (mq.size.width * .07);
    double marginTop = theme.marginTop ?? horizontalPadding;

    double leadingWidth = theme.leadingWidth ?? (mq.size.width * .15);
    double itemHeight = theme.itemHeight ?? leadingWidth;

    TextStyle labelStyle = theme.labelStyle, leadingStyle = theme.leadingStyle;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: theme.sheetDecoration,
        child: SafeArea(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: TextField(
                  decoration: theme.fieldDecoration,
                  onChanged: (value) => _filter(query: value),
                ),
                margin: EdgeInsets.symmetric(
                  vertical: marginTop,
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<List<ListItem>>(
                  valueListenable: filteredItems,
                  builder: (
                    BuildContext context,
                    List<ListItem> _items,
                    Widget? child,
                  ) {
                    return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        ListItem item = _items[index];

                        return InkWell(
                          onTap: () {
                            widget.onSelect(item);
                            Navigator.of(context).maybePop();
                          },
                          child: Container(
                            height: itemHeight,
                            child: Row(
                              children: [
                                Offstage(
                                  offstage: !theme.showLeading,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                    ),
                                    height: leadingWidth,
                                    width: leadingWidth,
                                    child: Center(
                                      child: Text(
                                        item.leading ?? 'N/A',
                                        style: leadingStyle,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsetsDirectional.only(
                                        start: horizontalPadding),
                                    child: Text(
                                      item.label ?? 'N/A',
                                      style: labelStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: _items.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void addListener(VoidCallback listener) => null;

  @override
  bool get hasListeners => false;

  @override
  void notifyListeners() => null;

  @override
  void removeListener(VoidCallback listener) => null;
}
