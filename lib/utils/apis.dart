//Login Mutation
const String loginMutation = '''
  mutation Login(\$username: String!,\$password: String!){
                Login(username:\$username, password: \$password){
                accessToken, refreshToken
                }
            }
''';

//Register mutation
const String registerMutation = '''
              mutation createUser(\$username: String!,\$password: String!){
                createUser(username: \$username, password: \$password){
                 id
                }
            }
''';

const String getResultsAGMMutation = '''
              mutation getResultsAGM(\$token: String!) {
                getResultsAGM(token: \$token) {
                  ageTotal
                  genderTotal
                  maleCount
                  femaleCount
                  stores {
                    name
                    maleCount
                    femaleCount
                    ageTotal
                    genderTotal
                      }
                    }
                  }

''';
