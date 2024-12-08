import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vanilla/src/app.dart';
import 'package:vanilla/src/repo/local/shared_prefs_todo_repo.dart';
import 'package:vanilla/src/ui/widget/todo_list_view.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  var repo = SharedPrefsTodoRepo(key: 'flutter-arch-study-integration-tests');

  group('App initialisation tests', () {
    setUp(() async {
      repo.saveTodos([]);
    });

    tearDown(() async {
      await repo.clear();
    });

    testWidgets('Initial screen snapshot', (tester) async {
      runApp(App(todoRepo: repo));

      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
      await binding.takeScreenshot('initial-screen');
    }, skip: true);

    testWidgets('Opens empty todo list by default', (tester) async {
      await tester.pumpWidget(App(todoRepo: repo));
      await tester.pumpAndSettle();

      expect(find.text('Todo list'), findsOne);
      expect(find.byType(Scrollable), findsOne);
    });

    testWidgets('Todo list navbar restoration', (tester) async {
      runApp(App(todoRepo: repo));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key(TodoListTab.stats.navDestinationKey)));
      await tester.pumpAndSettle();

      expect(find.text('Completed todos'), findsOne);
      await tester.restartAndRestore();
      await tester.pumpAndSettle();

      expect(find.text('Completed todos'), findsOne);
    });
  });
}
