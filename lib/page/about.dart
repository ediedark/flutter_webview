import 'package:about/about.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isIos = theme.platform == TargetPlatform.iOS ||
        theme.platform == TargetPlatform.macOS;

    const Widget aboutPage = AboutPage(
      title: Text('About'),
      applicationVersion: 'Version {{ version }}, build #{{ buildNumber }}',
      applicationDescription: Text(
        '',
        textAlign: TextAlign.justify,
      ),
      applicationIcon: FlutterLogo(size: 100),
      applicationLegalese: '© Edie, {{ year }}',
      children: <Widget>[
        MarkdownPageListTile(
          filename: 'README.md',
          title: Text('View Readme'),
          icon: Icon(Icons.all_inclusive),
        ),
        MarkdownPageListTile(
          filename: 'CHANGELOG.md',
          title: Text('View Changelog'),
          icon: Icon(Icons.view_list),
        ),
        MarkdownPageListTile(
          filename: 'LICENSE.md',
          title: Text('View License'),
          icon: Icon(Icons.description),
        ),
        MarkdownPageListTile(
          filename: 'CONTRIBUTING.md',
          title: Text('Contributing'),
          icon: Icon(Icons.share),
        ),
        MarkdownPageListTile(
          filename: 'CODE_OF_CONDUCT.md',
          title: Text('Code of conduct'),
          icon: Icon(Icons.sentiment_satisfied),
        ),
        LicensesPageListTile(
          title: Text('Open source Licenses'),
          icon: Icon(Icons.favorite),
        ),
      ],
    );

    if (isIos) {
      return CupertinoApp(
        title: 'About',
        home: aboutPage,
        theme: CupertinoThemeData(
          brightness: theme.brightness,
        ),
      );
    }

    return MaterialApp(
      title: 'About',
      home: aboutPage,
      theme: ThemeData(),
      darkTheme: ThemeData(brightness: Brightness.dark),
    );
  }
}
