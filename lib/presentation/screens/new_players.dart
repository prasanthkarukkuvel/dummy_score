import 'dart:developer';

import 'package:dummy_score/presentation/layouts/comfort_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NewPlayersScreenArgs {
  final String? gameMode;

  NewPlayersScreenArgs({required this.gameMode});

  static NewPlayersScreenArgs fromArguments(Object? args) {
    var screenArgs = args as NewPlayersScreenArgs?;

    return NewPlayersScreenArgs(gameMode: screenArgs?.gameMode);
  }
}

class NewPlayerInputModel {
  final Key key;
  final String id;
  final String label;

  TextEditingController controller = TextEditingController();

  NewPlayerInputModel(
      {required this.id, required this.label, required this.key});
}

class NewPlayers extends StatefulWidget {
  final NewPlayersScreenArgs screenArgs;

  const NewPlayers({Key? key, required this.screenArgs}) : super(key: key);

  @override
  _NewPlayersState createState() => _NewPlayersState();
}

class _NewPlayersState extends State<NewPlayers> {
  int playerCount = 0;
  List<NewPlayerInputModel> players = [];

  final _formKey = GlobalKey<FormBuilderState>(debugLabel: "new-player-form");

  NewPlayerInputModel createPlayerModel(String id, int playerNo) =>
      NewPlayerInputModel(key: Key(id), id: id, label: "Player $playerNo");

  @override
  void initState() {
    super.initState();

    players = [createPlayerModel("p1", 1), createPlayerModel("p2", 2)];
    playerCount = 2;
  }

  void addNewPlayer() {
    setState(() {
      var count = ++playerCount;
      players = List.from(players)..add(createPlayerModel("p$count", count));
    });
  }

  Widget createFormBuilder() {
    return FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            FormBuilderField(
                builder: (field) => Wrap(
                      runSpacing: 16,
                      children: [
                        for (var player in players)
                          FormBuilderTextField(
                            key: player.key,
                            controller: player.controller,
                            name: player.id,
                            decoration: InputDecoration(
                                suffixIcon: player.controller.text.length >= 2
                                    ? const Icon(Icons.check)
                                    : null,
                                border: const OutlineInputBorder(),
                                labelText: player.label),
                            validator: (value) {
                              if (value != null &&
                                  value.isNotEmpty &&
                                  value.length < 2) {
                                return "Name should have minimum 2 characters";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              var formValue = _formKey
                                      .currentState?.fields["players"]?.value ??
                                  {};

                              formValue[player.id] = value;
                              field.didChange(formValue);
                            },
                          )
                      ],
                    ),
                name: "players"),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 48, 0, 72),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: () => addNewPlayer(),
                      label: const Text("ADD PLAYER")),
                  ElevatedButton.icon(
                      icon: const Text("START GAME"),
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ??
                            false) {}
                      },
                      label: const Icon(MdiIcons.chevronDoubleRight))
                ],
              ),
            )
          ],
        ));
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
}
