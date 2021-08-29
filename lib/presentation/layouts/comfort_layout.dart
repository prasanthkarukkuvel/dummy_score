import 'dart:async';

import 'package:dummy_score/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ComfortLayoutProvider extends InheritedWidget {
  // ignore: overridden_fields, annotate_overrides
  final Widget child;
  final BuildContext context;

  const ComfortLayoutProvider(
      {required Key key, required this.child, required this.context})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(ComfortLayoutProvider oldWidget) {
    return true;
  }

  static ComfortLayoutProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ComfortLayoutProvider>()
          as ComfortLayoutProvider;

  VoidCallback showLoader() {
    final dialogContextCompleter = Completer<BuildContext>();

    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (pageContext, animation, secondaryAnimation) {
          if (!dialogContextCompleter.isCompleted) {
            dialogContextCompleter.complete(pageContext);
          }

          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(20),
              color: Colors.transparent,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });

    return () async {
      var dialogContext = await dialogContextCompleter.future;

      Navigator.pop(dialogContext);
    };
  }
}

class ComfortLayout extends StatelessWidget {
  final List<Widget> children;
  final String title;

  const ComfortLayout({Key? key, required this.children, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ComfortLayoutProvider(
            context: context,
            key: const Key("ComfortLayout"),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverAppBar(
                  floating: true,
                  backgroundColor: AppTheme.backgroundColor,
                  expandedHeight: 160,
                  elevation: 4.0,
                  flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        title,
                        style: AppTheme.lightHeading5(context),
                      ),
                      centerTitle: true),
                ),
                SliverList(delegate: SliverChildListDelegate(children))
              ],
            )));
  }
}
