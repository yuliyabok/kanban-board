import 'refresh_session.dart';
import 'register_account.dart';
import 'restore_session.dart';
import 'sign_in.dart';
import 'sign_out.dart';

export 'refresh_session.dart' show RefreshSession;
export 'register_account.dart' show RegisterAccount;
export 'restore_session.dart' show RestoreSession;
export 'sign_in.dart' show SignIn;
export 'sign_out.dart' show SignOut;

typedef RegisterUseCase = RegisterAccount;
typedef LoginUseCase = SignIn;
typedef LogoutUseCase = SignOut;
typedef GetCurrentUserUseCase = RestoreSession;
typedef RefreshTokenUseCase = RefreshSession;
