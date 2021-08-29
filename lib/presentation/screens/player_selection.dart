import 'package:dummy_score/presentation/layouts/comfort_layout.dart';
import 'package:dummy_score/presentation/widgets/chip_selection_control.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PlayerSelection extends StatefulWidget {
  const PlayerSelection({Key? key}) : super(key: key);

  @override
  PlayerSelectionState createState() => PlayerSelectionState();
}

Map<String, dynamic>? _hasPlayers(AbstractControl<dynamic> control) {
  if (control.isNotNull && control.value is List) {
    var value = control.value as List<dynamic>;

    if (value.length > 1) {
      return null;
    }
  }
  return {'_hasPlayers': true};
}

class PlayerSelectionState extends State<PlayerSelection> {
  FocusNode? externalFocusNode;

  /// Validates that control's value must be `true`

  final form = FormGroup({
    'players':
        FormControl<List<ChipInputModel>>(value: [], validators: [_hasPlayers]),
  });

  Widget createTitle(String label, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Text(label, style: Theme.of(context).textTheme.subtitle1),
    );
  }

  Widget createFormBuilder() {
    return Center(
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: 0,
                width: 0,
                child: TextField(
                  focusNode: externalFocusNode,
                )),
            // this is another widget that visualize the value of counter
            ReactiveValueListenableBuilder<List<ChipInputModel>>(
              formControlName: 'players',
              builder: (context, counterValue, child) {
                if (counterValue.value?.isNotEmpty ?? false) {
                  int count = counterValue.value?.length ?? 0;

                  if (count == 1) {
                    return createTitle("Add one more player to start", context);
                  } else if (count > 1) {
                    return createTitle("$count Player Game, have fun", context);
                  }
                }

                return createTitle("Add Players to the Game", context);
              },
            ),
            // this is our new reactive widget ;)
            ReactiveChipSelectionControl(
              formControlName: 'players',
              externalFocusNode: externalFocusNode,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 72, 0, 24),
              child: ReactiveFormConsumer(
                builder: (context, form, _child) {
                  return ElevatedButton.icon(
                      onPressed: form.valid
                          ? () {
                              //
                            }
                          : null,
                      icon: const Text("START GAME"),
                      label: const Icon(
                        MdiIcons.chevronDoubleRight,
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ComfortLayout(title: 'Players', children: <Widget>[
      Padding(
          padding: const EdgeInsets.fromLTRB(8, 72, 8, 8),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: createFormBuilder(),
            ),
          )),
    ]);
  }

  @override
  void initState() {
    externalFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    externalFocusNode?.dispose();
    super.dispose();
  }
}
