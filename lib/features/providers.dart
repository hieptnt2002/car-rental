import 'package:car_rental/features/data/datasources/local/auth_local_data_source.dart';
import 'package:car_rental/features/data/datasources/remote/auth_api.dart';
import 'package:car_rental/features/data/datasources/remote/booking_api.dart';
import 'package:car_rental/features/data/datasources/remote/carousel_image_api.dart';
import 'package:car_rental/features/data/datasources/remote/brand_api.dart';
import 'package:car_rental/features/data/datasources/remote/car_api.dart';
import 'package:car_rental/features/data/datasources/remote/delivery_address_api.dart';
import 'package:car_rental/features/data/datasources/remote/favorite_api.dart';
import 'package:car_rental/features/data/repositories/auth_repository_impl.dart';
import 'package:car_rental/features/data/repositories/booking_repository_impl.dart';
import 'package:car_rental/features/data/repositories/carousel_image_repository_impl.dart';
import 'package:car_rental/features/data/repositories/brand_repository_impl.dart';
import 'package:car_rental/features/data/repositories/car_repository_impl.dart';
import 'package:car_rental/features/data/repositories/delivery_address_repository_impl.dart';
import 'package:car_rental/features/domain/entities/favorite_car_repository_impl.dart';
import 'package:car_rental/features/domain/repositories/auth_repository.dart';
import 'package:car_rental/features/domain/repositories/booking_repository.dart';
import 'package:car_rental/features/domain/repositories/brand_repository.dart';
import 'package:car_rental/features/domain/repositories/car_repository.dart';
import 'package:car_rental/features/domain/repositories/delivery_address_repository.dart';
import 'package:car_rental/features/domain/repositories/favorite_car_repository.dart';
import 'package:car_rental/features/domain/usecases/auth/login.dart';
import 'package:car_rental/features/domain/usecases/auth/register.dart';
import 'package:car_rental/features/domain/usecases/booking/add_booking.dart';
import 'package:car_rental/features/domain/usecases/booking/get_bookings_by_status.dart';
import 'package:car_rental/features/domain/usecases/brand/get_brands.dart';
import 'package:car_rental/features/domain/usecases/car/get_cars.dart';
import 'package:car_rental/features/domain/usecases/carousel_image/get_carousel_images.dart';
import 'package:car_rental/features/domain/usecases/delivery_address.dart/fetch_delivery_address_default.dart';
import 'package:car_rental/features/domain/usecases/delivery_address.dart/fetch_delivery_addresses.dart';
import 'package:car_rental/features/domain/usecases/favorite_car/add_favorite_car.dart';
import 'package:car_rental/features/domain/usecases/favorite_car/get_favorite_cars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --------- data ---------
final favoriteApiProvider = Provider<FavoriteApi>(
  (ref) {
    return FavoriteApiImpl();
  },
);
final authLocalProvider = Provider<AuthLocalDataSource>(
  (ref) => AuthLocalDataSourceImpl(),
);

final authApiProvider = Provider<AuthApi>((ref) => AuthApiImpl());

final carApiProvider = Provider<CarApi>((ref) => CarApiImpl());

final brandApiProvider = Provider<BrandApi>((ref) => BrandApiImpl());

final carouselImageApi =
    Provider<CarouselImageApi>((ref) => CarouselImageApiImpl());

final deliveryAddressApiProvider = Provider<DeliveryAddressApi>(
  (ref) => DeliveryAddressApiImpl(),
);

final bookingApiProvider = Provider<BookingApi>((ref) => BookingApiImpl());

// --------- domain ---------
// -- favorite --
final favoriteRepositoryProvider = Provider<FavoriteCarRepository>(
  (ref) => FavoriteCarRepositoryImpl(
    favoriteApi: ref.watch(favoriteApiProvider),
  ),
);

final getFavoriteCarsProviderProvider = Provider<GetFavoriteCars>(
  (ref) => GetFavoriteCars(
    favoriteCarRepository: ref.watch(favoriteRepositoryProvider),
  ),
);

final addFavoriteCarProviderProvider = Provider<AddFavoriteCar>(
  (ref) => AddFavoriteCar(
    favoriteCarRepository: ref.watch(favoriteRepositoryProvider),
  ),
);
// -- auth --
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    authApi: ref.watch(authApiProvider),
    authLocalDataSource: ref.watch(authLocalProvider),
  ),
);

final loginProvider = Provider(
  (ref) => LoginUseCase(authRepository: ref.watch(authRepositoryProvider)),
);
final registerProvider = Provider(
  (ref) => RegisterUseCase(authRepository: ref.watch(authRepositoryProvider)),
);

// -- car --
final carRepositoryProvider = Provider<CarRepository>(
  (ref) => CarRepositoryImpl(carApi: ref.watch(carApiProvider)),
);

final getCarsProvider = Provider(
  (ref) => GetCars(carRepository: ref.watch(carRepositoryProvider)),
);

// -- brand --
final brandRepositoryProvider = Provider<BrandRepository>(
  (ref) => BrandRepositoryImpl(brandApi: ref.watch(brandApiProvider)),
);

final getBrandsProvider = Provider(
  (ref) => GetBrands(brandRepository: ref.watch(brandRepositoryProvider)),
);

// -- carousel image --
final carouselImageRepositoryProvider = Provider(
  (ref) => CarouselImageRepositoryImpl(
    carouselImageApi: ref.watch(carouselImageApi),
  ),
);

final getCarouselImagesProvider = Provider(
  (ref) => GetCarouselImages(
    carouselImageRepository: ref.watch(carouselImageRepositoryProvider),
  ),
);

final deliverAddressRepositoryProvider = Provider<DeliveryAddressRepository>(
  (ref) => DeliveryAddressRepositoryImpl(
    addressApi: ref.watch(deliveryAddressApiProvider),
  ),
);
final fetchDeliveryAddressesProvider = Provider(
  (ref) => FetchDeliveryAddressesUseCase(
    addressRepository: ref.watch(deliverAddressRepositoryProvider),
  ),
);

final fetchDeliveryAddressDefaultProvider = Provider(
  (ref) => FetchDeliveryAddressDefault(
    addressRepository: ref.watch(deliverAddressRepositoryProvider),
  ),
);

//-- booking --
final bookingRepositoryProvider = Provider<BookingRepository>(
  (ref) => BookingRepositoryImpl(
    bookingApi: ref.watch(bookingApiProvider),
  ),
);

final addBookingProvider = Provider(
  (ref) => AddBookingUseCase(
    bookingRepository: ref.watch(bookingRepositoryProvider),
  ),
);

final getBookingsByStatusProvider = Provider(
  (ref) => GetBookingsByStatus(
    bookingRepository: ref.watch(bookingRepositoryProvider),
  ),
);
