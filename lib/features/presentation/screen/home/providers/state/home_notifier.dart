import 'package:car_rental/shared/presentations/base_notifier.dart';
import 'package:car_rental/shared/presentations/data_state.dart';
import 'package:car_rental/features/domain/usecases/brand/get_brands.dart';
import 'package:car_rental/features/domain/usecases/car/get_cars.dart';
import 'package:car_rental/features/domain/usecases/carousel_image/get_carousel_images.dart';
import 'package:car_rental/features/presentation/screen/home/providers/state/home_state.dart';
import 'package:car_rental/features/providers.dart';

class HomeNotifier extends BaseNotifier<DataState<HomeState>> {
  late final GetCars _getCarsUseCase;
  late final GetBrands _getBrandsUseCase;
  late final GetCarouselImages _getCarouselImages;
  @override
  DataState<HomeState> build() {
    _getCarsUseCase = ref.watch(getCarsProvider);
    _getBrandsUseCase = ref.watch(getBrandsProvider);
    _getCarouselImages = ref.watch(getCarouselImagesProvider);
    _fetchData();
    return const DataState.initial();
  }

  Future<void> _fetchData() async {
    await executeMultipleTasks(
      requests: [
        _getCarsUseCase.execute(GetCarParam()),
        _getBrandsUseCase.execute(),
        _getCarouselImages.execute(),
      ],
      onLoading: (isLoading) {
        state = const DataState.loading();
      },
      onSuccess: (result) {
        state = DataState.data(
          HomeState(
            cars: result[0],
            brands: result[1],
            carouselImages: result[2],
          ),
        );
      },
    );
  }
}
