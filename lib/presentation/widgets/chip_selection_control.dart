import 'dart:async';
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
  final ChipSelectionState selectionState;
  final FocusNode? externalFocusNode;
  final List<ChipInputModel>? chips;
  final ChipSelectionController controller;

  ChipSelectionControl(
      {Key? key,
      required this.chips,
      required this.controller,
      required this.selectionState,
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
                      if (valueFocusNode.hasFocus) {
                        externalFocusNode?.requestFocus();
                      }
                      controller.remove(chip);
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
                  if (selectionState.clearMode && controller.isNotEmpty) {
                    externalFocusNode?.requestFocus();
                    controller.pop();
                  }
                }
              },
              child: TextFormField(
                controller: valueController,
                focusNode: valueFocusNode,
                autocorrect: false,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(border: InputBorder.none),
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  selectionState.clearMode = value.isEmpty;
                },
                onFieldSubmitted: (value) {
                  externalFocusNode?.requestFocus();
                  valueController.clear();
                  selectionState.clearMode = true;

                  final trimmedValue = value.trim();

                  Timer.run(() {
                    if (controller.canAdd(trimmedValue)) {
                      controller.add(trimmedValue);
                    } else {
                      valueFocusNode.requestFocus();
                    }
                  });
                },
              ),
            ),
          ),
        )));

    if ((externalFocusNode?.hasFocus ?? false) || (chips?.isEmpty ?? false)) {
      valueFocusNode.requestFocus();
      valueController.clear();
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
            crossAxisAlignment: WrapCrossAlignment.start,
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

class ChipSelectionController {
  final ReactiveFormFieldState<List<ChipInputModel>, List<ChipInputModel>>
      field;
  ChipSelectionController({required this.field});

  void add(String value) {
    List<ChipInputModel> fieldValue = List.from(field.value ?? []);

    if (value.isNotEmpty &&
        fieldValue.where((element) => element.id == value).isEmpty) {
      fieldValue.add(ChipInputModel(id: value, label: value));

      field.didChange(fieldValue);
    }
  }

  void remove(chip) {
    field.didChange(
        (field.value ?? []).where((element) => element.id != chip.id).toList());
  }

  void pop() {
    List<ChipInputModel> fieldValue = List.from(field.value ?? []);

    if (fieldValue.isNotEmpty) {
      fieldValue.removeLast();
      field.didChange(fieldValue);
    }
  }

  bool get isNotEmpty {
    return List.from(field.value ?? []).isNotEmpty;
  }

  bool canAdd(String value) {
    return value.isNotEmpty &&
        List.from(field.value ?? [])
            .where((element) => element.id == value)
            .isEmpty;
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
                  controller: ChipSelectionController(field: field));
            });

  @override
  ReactiveFormFieldState<List<ChipInputModel>, List<ChipInputModel>>
      createState() =>
          ReactiveFormFieldState<List<ChipInputModel>, List<ChipInputModel>>();
}
