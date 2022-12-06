import 'package:injectable/injectable.dart';

import './i_chat_service.dart';

@LazySingleton(as: IChatService)
class IChatServiceImpl implements IChatService {}
