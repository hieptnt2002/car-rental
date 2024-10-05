import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/features/domain/entities/delivery_address.dart';
import 'package:car_rental/features/presentation/extension/dimension.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/screen/booking/add_booking/providers/state/booking_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryAddressListTile extends ConsumerStatefulWidget {
  final DeliveryAddress? deliveryAddress;
  const DeliveryAddressListTile({super.key, this.deliveryAddress});

  @override
  ConsumerState<DeliveryAddressListTile> createState() =>
      _DeliveryAddressListTileState();
}

class _DeliveryAddressListTileState
    extends ConsumerState<DeliveryAddressListTile> {
  late final DeliveryAddress? _addressSelected = widget.deliveryAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: context.percentHeight(60)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.savedAddress,
                  style: AppTextStyle.w700TextColorLabelLarge,
                ),
                TextButton.icon(
                  onPressed: () async {},
                  icon: const Icon(
                    Icons.add_home_work_rounded,
                    color: AppColors.secondary,
                  ),
                  label: Text(
                    context.l10n.addNew,
                    style: AppTextStyle.secondaryBodySmall,
                  ),
                ),
              ],
            ),
          ),
          ref.watch(deliverAddressesProvider).when(
                data: _buildDeliveryAddressListOption,
                error: (error, stackTrace) => const Center(
                  child: Text(
                    'Error',
                    style: AppTextStyle.redLabelSmall,
                  ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    strokeAlign: 16,
                  ),
                ),
              ),
        ],
      ),
    );
  }

  ListView _buildDeliveryAddressListOption(
    List<DeliveryAddress> deliveryAddresses,
  ) {
    return ListView.separated(
      itemCount: deliveryAddresses.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(left: 56),
        child: Divider(thickness: 1, color: AppColors.gray400),
      ),
      itemBuilder: (context, index) {
        return _DeliveryAddressOptionTile(
          value: deliveryAddresses[index],
          groupValue: _addressSelected,
        );
      },
    );
  }
}

class _DeliveryAddressOptionTile extends StatelessWidget {
  final DeliveryAddress value;
  final DeliveryAddress? groupValue;

  const _DeliveryAddressOptionTile({
    Key? key,
    required this.value,
    required this.groupValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, value);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 16, top: 16, bottom: 16),
        child: Row(
          children: [
            Radio.adaptive(
              value: value,
              groupValue: groupValue,
              onChanged: (value) {
                Navigator.pop(context, value!);
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: value.recipientName,
                          style: AppTextStyle.textColorLabelSmall,
                        ),
                        TextSpan(
                          text: ' | (+84) ${value.phone.substring(1)}',
                          style: AppTextStyle.grayBodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value.address,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: AppTextStyle.grayBodyXSmall,
                  ),
                  const SizedBox(height: 4),
                  if (value.defaultFlag)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.red500),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        context.l10n.defaultAddress,
                        style: AppTextStyle.redBodyXSmall,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
