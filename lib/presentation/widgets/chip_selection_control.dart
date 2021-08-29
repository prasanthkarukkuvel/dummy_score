import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ChipInputModel {
  Key? key;
  final String id;
  final String label;

  ChipInputModel({required this.id, required this.label}) {
    key = Key(id);
  }
}

class ChipSelectionState {
  bool clearMode = false;

  ChipSelectionState({required this.clearMode});
}

class ChipSelectionControl extends StatelessWidget {
  final void Function(ChipInputModel chip) onRemoved;
  final void Function(String value) onAdd;
  final void Function() popLast;
  final ChipSelectionState selectionState;
  final FocusNode? externalFocusNode;
  final List<ChipInputModel>? chips;

  ChipSelectionControl(
      {Key? key,
      required this.chips,
      required this.onRemoved,
      required this.onAdd,
      required this.selectionState,
      required this.popLast,
      required this.externalFocusNode})
      : super(key: key);

  final valueController = TextEditingController();
  final valueFocusNode = FocusNode();
  final keyListnerFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final List<Widget> chipsChildren = chips
            ?.map((chip) => Container(
                  color: Colors.transparent,
                  child: InputChip(
                    key: chip.key,
                    label: Text(
                      chip.label,
                      style: theme.textTheme.headline6,
                    ),
                    onDeleted: () {
                      onRemoved(chip);
                    },
                  ),
                ))
            .toList() ??
        [];

    chipsChildren.add(Container(
        color: Colors.transparent,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          child: IntrinsicWidth(
            child: RawKeyboardListener(
              focusNode: keyListnerFocusNode,
              onKey: (event) {
                if (event.runtimeType == RawKeyUpEvent &&
                    event.logicalKey == LogicalKeyboardKey.backspace) {
                  if (selectionState.clearMode) {
                    popLast();
                  }
                }
              },
              child: TextFormField(
                controller: valueController,
                focusNode: valueFocusNode,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(border: InputBorder.none),
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  selectionState.clearMode = value.isEmpty;
                },
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    valueController.clear();
                    onAdd(value);
                  }
                },
              ),
            ),
          ),
        )));

    if ((externalFocusNode?.hasFocus ?? false) || (chips?.isEmpty ?? false)) {
      valueFocusNode.requestFocus();
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        valueFocusNode.requestFocus();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: InputDecorator(
          decoration: const InputDecoration(border: InputBorder.none),
          isFocused: valueFocusNode.hasFocus,
          isEmpty: valueController.text.isEmpty && (chips?.isEmpty ?? true),
          child: Wrap(
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 8.0,
            runSpacing: 8.0,
            children: chipsChildren,
          ),
        ),
      ),
    );
  }
}

class ReactiveChipSelectionControl
    extends ReactiveFormField<List<ChipInputModel>, List<ChipInputModel>> {
  ReactiveChipSelectionControl(
      {Key? key,
      required String formControlName,
      required FocusNode? externalFocusNode})
      : super(
            key: key,
            formControlName: formControlName,
            builder: (ReactiveFormFieldState<List<ChipInputModel>,
                    List<ChipInputModel>>
                field) {
              return ChipSelectionControl(
                externalFocusNode: externalFocusNode,
                chips: field.value,
                selectionState: ChipSelectionState(clearMode: true),
                onAdd: (value) {
                  List<ChipInputModel> fieldValue =
                      List.from(field.value ?? []);

                  if (value.isNotEmpty &&
                      fieldValue
                          .where((element) => element.id == value)
                          .isEmpty) {
                    externalFocusNode?.requestFocus();
                    fieldValue.add(ChipInputModel(id: value, label: value));

                    field.didChange(fieldValue);
                  } else if (value.isEmpty) {}
                },
                onRemoved: (chip) => {
                  field.didChange((field.value ?? [])
                      .where((element) => element.id != chip.id)
                      .toList())
                },
                popLast: () {
                  List<ChipInputModel> fieldValue =
                      List.from(field.value ?? []);

                  if (fieldValue.isNotEmpty) {
                    fieldValue.removeLast();
                    field.didChange(fieldValue);
                  }
                },
              );
            });

  @override
  ReactiveFormFieldState<List<ChipInputModel>, List<ChipInputModel>>
      createState() =>
          ReactiveFormFieldState<List<ChipInputModel>, List<ChipInputModel>>();
}
