// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'login_model.dart';

class LoginResponseModelMapper extends ClassMapperBase<LoginResponseModel> {
  LoginResponseModelMapper._();

  static LoginResponseModelMapper? _instance;
  static LoginResponseModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LoginResponseModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LoginResponseModel';

  static int _$id(LoginResponseModel v) => v.id;
  static const Field<LoginResponseModel, int> _f$id = Field('id', _$id);
  static String _$username(LoginResponseModel v) => v.username;
  static const Field<LoginResponseModel, String> _f$username = Field(
    'username',
    _$username,
  );
  static String _$email(LoginResponseModel v) => v.email;
  static const Field<LoginResponseModel, String> _f$email = Field(
    'email',
    _$email,
  );
  static String _$firstName(LoginResponseModel v) => v.firstName;
  static const Field<LoginResponseModel, String> _f$firstName = Field(
    'firstName',
    _$firstName,
  );
  static String _$lastName(LoginResponseModel v) => v.lastName;
  static const Field<LoginResponseModel, String> _f$lastName = Field(
    'lastName',
    _$lastName,
  );
  static String _$image(LoginResponseModel v) => v.image;
  static const Field<LoginResponseModel, String> _f$image = Field(
    'image',
    _$image,
  );
  static String _$accessToken(LoginResponseModel v) => v.accessToken;
  static const Field<LoginResponseModel, String> _f$accessToken = Field(
    'accessToken',
    _$accessToken,
  );
  static String _$gender(LoginResponseModel v) => v.gender;
  static const Field<LoginResponseModel, String> _f$gender = Field(
    'gender',
    _$gender,
  );
  static String _$refreshToken(LoginResponseModel v) => v.refreshToken;
  static const Field<LoginResponseModel, String> _f$refreshToken = Field(
    'refreshToken',
    _$refreshToken,
  );

  @override
  final MappableFields<LoginResponseModel> fields = const {
    #id: _f$id,
    #username: _f$username,
    #email: _f$email,
    #firstName: _f$firstName,
    #lastName: _f$lastName,
    #image: _f$image,
    #accessToken: _f$accessToken,
    #gender: _f$gender,
    #refreshToken: _f$refreshToken,
  };

  static LoginResponseModel _instantiate(DecodingData data) {
    return LoginResponseModel(
      id: data.dec(_f$id),
      username: data.dec(_f$username),
      email: data.dec(_f$email),
      firstName: data.dec(_f$firstName),
      lastName: data.dec(_f$lastName),
      image: data.dec(_f$image),
      accessToken: data.dec(_f$accessToken),
      gender: data.dec(_f$gender),
      refreshToken: data.dec(_f$refreshToken),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LoginResponseModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LoginResponseModel>(map);
  }

  static LoginResponseModel fromJson(String json) {
    return ensureInitialized().decodeJson<LoginResponseModel>(json);
  }
}

mixin LoginResponseModelMappable {}

