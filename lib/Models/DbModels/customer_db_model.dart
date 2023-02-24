import 'package:wiliams/DataBase/Model.dart';

class CustomerDbModel extends BaseModel {
  @override
  Map<String, DbDataTypes> fields() {
    return {
      'content': DbDataTypes.Text,
    };
  }

  @override
  String primaryKey() {
    return 'id';
  }
}