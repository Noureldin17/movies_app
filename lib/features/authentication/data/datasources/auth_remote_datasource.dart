import 'dart:convert';
import 'package:movies_app/core/api/tmdb_api_constants.dart';
import 'package:movies_app/core/error/exceptions.dart';
import '../../domain/models/request_token_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<RequestTokenModel> getRequestToken();
  Future<RequestTokenModel> validateWithLogin(Map<String, dynamic> body);
  Future<String> createSession(Map<String, dynamic> body);
  Future<String> createGuestSession();
}

class AuthenticationRemoteImplWithHttp
    implements AuthenticationRemoteDataSource {
  final http.Client client;

  AuthenticationRemoteImplWithHttp(this.client);

  @override
  Future<RequestTokenModel> getRequestToken() async {
    final response = await client.get(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}authentication/token/new?api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": 'application/json'});
    print(response.body);
    if (response.statusCode == 200) {
      return RequestTokenModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RequestTokenModel> validateWithLogin(Map<String, dynamic> body) async {
    final response = await client.post(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}authentication/token/validate_with_login?api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": 'application/json'},
        body: json.encode(body));
    print(response.body);
    if (response.statusCode == 200) {
      return RequestTokenModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw InvalidCredentialsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> createSession(Map<String, dynamic> body) async {
    final response = await client.post(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}authentication/session/new?api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": 'application/json'},
        body: json.encode(body));

    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['success'] == true
          ? json.decode(response.body)['session_id']
          : null;
    } else if (response.statusCode == 401) {
      throw InvalidCredentialsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> createGuestSession() async {
    final response = await client.get(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}authentication/guest_session/new?api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": 'application/json'});

    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['success'] == true
          ? json.decode(response.body)['guest_session_id']
          : null;
    } else if (response.statusCode == 401) {
      throw InvalidCredentialsException();
    } else {
      throw ServerException();
    }
  }
}
