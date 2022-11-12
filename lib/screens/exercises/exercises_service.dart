import 'package:fitness_app/domain/models/exercise_model.dart';
import '../../utils/db_util.dart';

class ExercisesService {
  Future<List<ExerciseModel>> getExercises() async {
    var dbUtil = DBUtil.db;
    return await dbUtil.getItems();
  }

  Future<bool> deleteExercise(ExerciseModel? model) async {
    var dbUtil = DBUtil.db;
    return await dbUtil.makeOperation(item: model, type: DBOperationType.DELETE);
  }
}
