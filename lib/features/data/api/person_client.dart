import 'package:flutterexamapp/core/constants/constants.dart';
import 'package:flutterexamapp/features/domain/entity/person_result_header/person_result_header_entity.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;

part 'person_client.g.dart';

@RestApi(baseUrl: Constants.BASE_API_URL)
abstract class PersonClient {
  factory PersonClient(Dio dio, {String baseUrl}) = _PersonClient;

  @GET('/v2/users')
  Future<HttpResponse<PersonResultHeaderEntity>> getPersonList(
    @Query("_quantity") int resultCounts,
  );
}
