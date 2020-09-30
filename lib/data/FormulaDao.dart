import 'package:cannabis_calculator/data/app_database.dart';
import 'package:cannabis_calculator/screens/Formula.dart';
import 'package:sembast/sembast.dart';

class FormulaDao {
  static const String FORMULA_STORE_NAME = 'formulas';

  final _formulaStore = intMapStoreFactory.store(FORMULA_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Formula formula) async {
    print("Added formula to db");
    await _formulaStore.add(await _db, formula.toMap()).catchError((err) => print(err));
  }

  Future update(Formula formula) async {
    final finder = Finder(filter: Filter.byKey(formula.id));
    await _formulaStore.update(
        await _db,
        formula.toMap(),
        finder:finder
    );
  }

  Future delete(Formula formula) async {
    final finder = Finder(filter: Filter.byKey(formula.id));
    await _formulaStore.delete(
        await _db,
        finder: finder
    );
  }

  Future<List<Formula>> getAll() async {
    final finder = Finder(sortOrders: [SortOrder("finalDryWeight")]);
    final recordSnapshots = await _formulaStore.find(await _db, finder: finder);
    List<Formula> formulas = recordSnapshots.map((snapshot) {
      final formula = Formula.fromMap(snapshot.value);
      formula.id = snapshot.key;
      return formula;
    }).toList();
    return formulas;
  }

  Future<List<Formula>> getAllFavorites() async {
    final finder = Finder(filter: Filter.equals("isFavorite", true));
    final recordSnapshots = await _formulaStore.find(await _db, finder: finder);
    List<Formula> formulas = recordSnapshots.map((snapshot) {
      final formula = Formula.fromMap(snapshot.value);
      formula.id = snapshot.key;
      return formula;
    }).toList();
    return formulas;
  }


  Future deleteAll() async {
    final finder = Finder(filter: Filter.equals("isFavorite", false));
    final recordSnapshots = await _formulaStore.find(await _db, finder: finder);
    List<Formula> formulas = recordSnapshots.map((snapshot) {
      final formula = Formula.fromMap(snapshot.value);
      formula.id = snapshot.key;
      return formula;
    }).toList();

    for(var formu in formulas) {
      delete(formu);
    }
  }

}