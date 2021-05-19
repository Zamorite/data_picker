class PickerCallback {
  final Function? onClosed;
  final Function(dynamic) onSelect;

  PickerCallback({
    this.onClosed,
    required this.onSelect,
  });
}
