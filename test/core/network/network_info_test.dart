import 'package:connectivity/connectivity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exam_recipes_api/app/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<Connectivity>(),
])
void main() {
  late NetworkInfoI networkInfo;
  late Connectivity connectivity;

  setUp(() {
    connectivity = MockConnectivity();
    networkInfo = NetworkInfo(connectivity: connectivity);
  });

  group('isConnected ', () {
    test(
      'should call Connectivity.checkConnectivity and return true if result is wifi / mobile, else return false',
      () async {
        // arrange
        when(connectivity.checkConnectivity())
            .thenAnswer((_) => Future.value(ConnectivityResult.wifi));

        // act
        final result = await networkInfo.isConnected();

        // assert
        verify(connectivity.checkConnectivity());
        expect(result, true);
      },
    );
  });
}
