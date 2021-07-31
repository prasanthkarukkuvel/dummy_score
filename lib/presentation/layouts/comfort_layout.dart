import 'package:dummy_score/presentation/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComfortLayout extends StatelessWidget {
  final List<Widget> children;
  final String title;

  const ComfortLayout({Key? key, required this.children, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
    ));
  }
}
