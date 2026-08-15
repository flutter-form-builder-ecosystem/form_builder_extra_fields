// Generates PNG frames for README / pub.dev GIFs.
// Run only from tool/generate_screenshots.sh (not part of package tests).
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

const _logicalSize = Size(230, 409);
const _dpr = 3.0;
const _countries = [
  'Canada',
  'France',
  'Germany',
  'Japan',
  'Turkey',
  'Uganda',
  'United Kingdom',
  'United States',
];

final _shotKey = GlobalKey();

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('generate extra field screenshot frames', (tester) async {
    await _loadFonts();
    final out = Directory(Platform.environment['SHOT_DIR'] ?? '/tmp/extra-shots');
    if (out.existsSync()) {
      out.deleteSync(recursive: true);
    }
    out.createSync(recursive: true);

    tester.view.physicalSize = Size(
      _logicalSize.width * _dpr,
      _logicalSize.height * _dpr,
    );
    tester.view.devicePixelRatio = _dpr;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    var n = 0;
    Future<void> settle() async {
      await tester.pump();
      for (var i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
    }

    Future<void> shot(String name) async {
      await settle();
      final boundary =
          _shotKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: 1);
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        File('${out.path}/${name}_${n.toString().padLeft(2, '0')}.png')
            .writeAsBytesSync(bytes!.buffer.asUint8List());
      });
      n += 1;
    }

    await _pumpPhone(tester, const _CompleteDemo());
    await shot('complete');
    final scroller = find.byType(SingleChildScrollView).first;
    await tester.drag(scroller, const Offset(0, -180));
    await settle();
    await shot('complete');
    final addIcon = find.byIcon(Icons.arrow_right);
    if (addIcon.evaluate().isNotEmpty) {
      await tester.tap(addIcon);
      await settle();
    }
    await shot('complete');
    final rating = find.byType(FormBuilderRatingBar);
    if (rating.evaluate().isNotEmpty) {
      await tester.tap(rating.first);
      await settle();
    }
    await shot('complete');
    await tester.drag(scroller, const Offset(0, -220));
    await settle();
    await shot('complete');

    n = 0;
    await _pumpPhone(tester, const _ColorDemo());
    await shot('color');
    await tester.tap(find.byType(FormBuilderColorPickerField).first);
    await settle();
    await shot('color');

    n = 0;
    await _pumpPhone(tester, const _RatingDemo());
    await shot('rating');
    final stars = find.byType(FormBuilderRatingBar).first;
    await tester.tapAt(tester.getCenter(stars) + const Offset(20, 0));
    await settle();
    await shot('rating');
    await tester.tapAt(tester.getCenter(stars) + const Offset(50, 0));
    await settle();
    await shot('rating');

    n = 0;
    await _pumpPhone(tester, const _SearchDemo());
    await shot('search');
    await tester.tap(find.text('Canada'));
    await settle();
    await shot('search');
    final turkey = find.text('Turkey');
    if (turkey.evaluate().isNotEmpty) {
      await tester.tap(turkey.last);
      await settle();
      await shot('search');
    }
  });
}

Future<void> _loadFonts() async {
  final root = Platform.environment['FLUTTER_ROOT'] ?? '/sdks/flutter';
  final material = Directory('$root/bin/cache/artifacts/material_fonts');
  Future<void> load(String family, String path) async {
    final file = File(path);
    if (!file.existsSync()) {
      // ignore: avoid_print
      print('missing font $path');
      return;
    }
    final loader = FontLoader(family);
    loader.addFont(Future.value(ByteData.sublistView(file.readAsBytesSync())));
    await loader.load();
  }

  if (material.existsSync()) {
    for (final file in material.listSync().whereType<File>()) {
      final name = file.uri.pathSegments.last.toLowerCase();
      if (name.contains('roboto-regular')) {
        await load('Roboto', file.path);
      } else if (name.contains('roboto-medium')) {
        await load('Roboto-Medium', file.path);
      } else if (name.contains('materialicons-regular')) {
        await load('MaterialIcons', file.path);
      }
    }
  }
}

Future<void> _pumpPhone(WidgetTester tester, Widget body) async {
  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
        fontFamily: 'Roboto',
      ),
      home: Material(
        child: Center(
          child: SizedBox(
            width: _logicalSize.width,
            height: _logicalSize.height,
            child: RepaintBoundary(
              key: _shotKey,
              child: MediaQuery(
                data: const MediaQueryData(
                  size: _logicalSize,
                  devicePixelRatio: _dpr,
                  padding: EdgeInsets.zero,
                ),
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      'Extra Fields',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    toolbarHeight: 40,
                    elevation: 0,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                    child: body,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
    await tester.pump(const Duration(milliseconds: 100));
    for (var i = 0; i < 15; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

class _CompleteDemo extends StatelessWidget {
  const _CompleteDemo();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FormBuilderSearchableDropdown<String>(
              name: 'country',
              items: _countries,
              initialValue: 'Canada',
              decoration: const InputDecoration(
                labelText: 'Searchable dropdown',
                isDense: true,
              ),
            ),
            const SizedBox(height: 8),
            FormBuilderSearchableMultiSelectDropdown<String>(
              name: 'langs',
              items: const ['Dart', 'Kotlin', 'Swift'],
              initialValue: const ['Dart'],
              decoration: const InputDecoration(
                labelText: 'Multiselect',
                isDense: true,
              ),
            ),
            FormBuilderColorPickerField(
              name: 'color',
              initialValue: Colors.blue,
              colorPickerType: ColorPickerType.materialPicker,
              decoration: const InputDecoration(
                labelText: 'Color picker',
                isDense: true,
              ),
            ),
            FormBuilderTouchSpin(
              name: 'spin',
              initialValue: 3,
              step: 1,
              iconSize: 28,
              addIcon: const Icon(Icons.arrow_right),
              subtractIcon: const Icon(Icons.arrow_left),
              decoration: const InputDecoration(
                labelText: 'TouchSpin',
                isDense: true,
              ),
            ),
            FormBuilderRatingBar(
              name: 'rate',
              initialValue: 2,
              itemSize: 26,
              decoration: const InputDecoration(
                labelText: 'Rating bar',
                isDense: true,
              ),
            ),
            FormBuilderSignaturePad(
              name: 'sign',
              height: 90,
              border: Border.all(color: Colors.green),
              decoration: const InputDecoration(labelText: 'Signature pad'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorDemo extends StatelessWidget {
  const _ColorDemo();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: ListView(
        children: [
          FormBuilderColorPickerField(
            name: 'material',
            initialValue: const Color(0xffffeb3b),
            colorPickerType: ColorPickerType.materialPicker,
            decoration: const InputDecoration(labelText: 'Material picker'),
          ),
          const SizedBox(height: 12),
          FormBuilderColorPickerField(
            name: 'block',
            initialValue: const Color(0xff2196f3),
            colorPickerType: ColorPickerType.blockPicker,
            decoration: const InputDecoration(labelText: 'Block picker'),
          ),
        ],
      ),
    );
  }
}

class _RatingDemo extends StatelessWidget {
  const _RatingDemo();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: ListView(
        children: [
          FormBuilderRatingBar(
            name: 'stars',
            initialValue: 2,
            itemSize: 32,
            decoration: const InputDecoration(
              labelText: 'Whole stars',
              helperText: 'Tap across five stars',
            ),
          ),
          const SizedBox(height: 16),
          FormBuilderRatingBar(
            name: 'half',
            initialValue: 2.5,
            allowHalfRating: true,
            itemSize: 32,
            decoration: const InputDecoration(labelText: 'Half stars'),
          ),
        ],
      ),
    );
  }
}

class _SearchDemo extends StatelessWidget {
  const _SearchDemo();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: ListView(
        children: [
          FormBuilderSearchableDropdown<String>(
            name: 'offline',
            items: _countries,
            initialValue: 'Canada',
            popupProps: const PopupProps.menu(showSearchBox: true),
            decoration: const InputDecoration(
              labelText: 'Offline search',
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
