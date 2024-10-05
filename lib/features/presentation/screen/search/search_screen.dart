import 'dart:async';

import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/core/utils/snack_bar.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _allSuggestions =
      List.generate(100, (index) => 'Lamboghini $index');
  List<String> _suggestions = ['Lamboghini', 'Ferrari', 'Volvo', 'Maybach'];
  final _focusNode = FocusNode();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
    _debounceTimer?.cancel();
  }

  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          final keyword = _controller.text;
          if (keyword.trim().isEmpty) {
            _suggestions = ['Lamboghini', 'Ferrari', 'Volvo', 'Maybach'];
          } else {
            //call api
            _suggestions = _allSuggestions
                .where(
                  (suggestion) => suggestion.toLowerCase().contains(
                        keyword.toLowerCase(),
                      ),
                )
                .toList();
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearch(),
        leading: const BackButton(
          color: AppColors.black,
        ),
        titleSpacing: 0,
        backgroundColor: AppColors.white,
      ),
      body: CustomScrollView(
        slivers: [
          _buildSuggestSearch(),
          if (_controller.text.trim().isEmpty && _suggestions.isNotEmpty)
            _buildRemoveSearchHistory(),
        ],
      ),
    );
  }

  Widget _buildRemoveSearchHistory() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: 16),
        alignment: Alignment.center,
        child: GestureDetector(
          child: Text(
            context.l10n.clearSearchHistory,
            style: AppTextStyle.gray500LabelSmall,
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return SizedBox(
      width: double.maxFinite,
      height: 40,
      child: Row(
        children: [
          _buildTextFieldSearch(),
          _buildButtonSearch(),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildTextFieldSearch() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          hintText: context.l10n.hintSearch,
          hintStyle: AppTextStyle.grayBodySmall,
          enabledBorder: _buildBorderTextField(),
          focusedBorder: _buildBorderTextField(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: InkWell(
            onTap: _controller.clear,
            child: const Icon(Icons.close, size: 14, color: AppColors.gray500),
          ),
          suffixIconConstraints: const BoxConstraints.expand(width: 30),
        ),
        cursorColor: AppColors.textColor,
        controller: _controller,
        onFieldSubmitted: _pushToSearchResultScreen,
        focusNode: _focusNode,
      ),
    );
  }

  OutlineInputBorder _buildBorderTextField() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      ),
      borderSide: BorderSide(color: AppColors.secondary),
    );
  }

  Widget _buildButtonSearch() {
    return SizedBox(
      width: 40,
      child: IconButton(
        onPressed: () {
          _pushToSearchResultScreen(_controller.text);
        },
        style: IconButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
        ),
        icon: const Icon(Icons.search_sharp),
      ),
    );
  }

  Widget _buildSuggestSearch() {
    return SliverList.separated(
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_suggestions[index]),
          onTap: () {
            _pushToSearchResultScreen(_suggestions[index]);
          },
        );
      },
      separatorBuilder: (_, __) =>
          const Divider(thickness: 1, height: 0, color: AppColors.gray300),
    );
  }

  void _pushToSearchResultScreen(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      Navigator.pushNamed(
        context,
        Routes.searchResults,
        arguments: {'keyword': value},
      );
    } else {
      USnackBar.showErrorSnackBar(
        context.l10n.pleaseEnterKeywordSearch,
      );
    }
  }
}
