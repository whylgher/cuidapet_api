import 'package:injectable/injectable.dart';

import './i_chat_repository.dart';

@LazySingleton(as: IChatRepository)
class IChatRepositoryImpl implements IChatRepository {}
