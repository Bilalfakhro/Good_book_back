import 'package:flutter/cupertino.dart';
import '../styles.dart';
import 'settings_item.dart';

// The widgets in this file present a group of Cupertino-style settings items to
// the user. In the future, the Cupertino package in the Flutter SDK will
// include dedicated widgets for this purpose, but for now they're done here.
//
// See https://github.com/flutter/flutter/projects/29 for more info.

class SettingsGroupHeader extends StatelessWidget {
  const SettingsGroupHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 6.0,
      ),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: CupertinoColors.inactiveGray,
          fontSize: 13.5,
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}

class SettingsGroupFooter extends StatelessWidget {
  const SettingsGroupFooter(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 7.5,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Styles.settingsGroupSubtitle,
          fontSize: 13.0,
          letterSpacing: -0.08,
        ),
      ),
    );
  }
}

class SettingsGroup extends StatelessWidget {
  SettingsGroup({
    @required this.items,
    this.header,
    this.footer,
  })  : assert(items != null),
        assert(items.length > 0);

  final List<SettingsItem> items;
  final Widget header;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    final dividedItems = <Widget>[items[0]];

    for (int i = 1; i < items.length; i++) {
      dividedItems.add(Container(
        color: Styles.settingsLineation,
        height: 0.3,
      ));
      dividedItems.add(items[i]);
    }

    final List<Widget> columnChildren = [];

    if (header != null) {
      columnChildren.add(header);
    }

    columnChildren.add(
      Container(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border(
            top: const BorderSide(
              color: Styles.settingsLineation,
              width: 0.0,
            ),
            bottom: const BorderSide(
              color: Styles.settingsLineation,
              width: 0.0,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: dividedItems,
        ),
      ),
    );

    if (footer != null) {
      columnChildren.add(footer);
    }

    return Padding(
      padding: EdgeInsets.only(
        top: header == null ? 35.0 : 22.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnChildren,
      ),
    );
  }
}
