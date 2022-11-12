import '../../domain/exercise_model.dart';
import '../../utils/db_util.dart';

class ExerciseService {
  Future<bool> saveExercise(ExerciseModel? model) async {
    var dbUtil = DBUtil.db;
    return await dbUtil.makeOperation(item: model);
  }
}
