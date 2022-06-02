import 'package:graphql_flutter/graphql_flutter.dart';

import '../../config.dart';

class GraphQLSetup {
  static final HttpLink link = HttpLink(
    uri: kBaseUrl,
  );

  static final GraphQLClient client = GraphQLClient(
    cache: InMemoryCache(),
    link: link,
  );
}
