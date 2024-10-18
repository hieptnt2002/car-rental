import 'dart:async';

import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/core/utils/snack_bar.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:car_rental/features/presentation/screen/search/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final String? keyword;
  const SearchScreen({super.key, this.keyword});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    if (widget.keyword != null) _searchController.text = widget.keyword!;
    _focusNode.requestFocus();
    _searchController.addListener(_onSearchInputChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    _debounceTimer?.cancel();
  }

  void _onSearchInputChanged() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final keyword = _searchController.text.trim();
      if (keyword.isNotEmpty) {
        ref.read(searchProvider.notifier).getSuggestedSearches(keyword);
      } else {
        ref.read(searchProvider.notifier).clearSuggestions();
      }
    });
  }

  void _navigateToSearchResults(String? keyword) {
    if (keyword != null && keyword.trim().isNotEmpty) {
      ref.read(searchProvider.notifier).addSearchToHistory(keyword);
      Navigator.pushNamed(
        context,
        Routes.searchResults,
        arguments: {'keyword': keyword},
      );
    } else {
      USnackBar.showErrorSnackBar(
        context.l10n.pleaseEnterKeywordSearch,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchBar(),
        leading: const BackButton(
          color: AppColors.black,
        ),
        titleSpacing: 0,
        backgroundColor: AppColors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_searchController.text.trim().isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: CustomScrollView(
          slivers: [
            _buildRecentSearches(),
            if (ref.watch(searchProvider).recentSearches.isNotEmpty)
              _buildClearRecentSearchesButton(),
          ],
        ),
      );
    } else {
      return _buildSuggestedSeaches();
    }
  }

  Widget _buildClearRecentSearchesButton() {
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
          onTap: () {
            ref.read(searchProvider.notifier).clearRecentSearches();
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      width: double.maxFinite,
      height: 40,
      child: Row(
        children: [
          _buildSearchField(),
          _buildSearchButton(),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Expanded(
      child: TextFormField(
        style: AppTextStyle.textColorBodySmall,
        decoration: InputDecoration(
          hintText: context.l10n.hintSearch,
          hintStyle: AppTextStyle.grayBodySmall,
          enabledBorder: _buildTextFieldBorder(),
          focusedBorder: _buildTextFieldBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: InkWell(
            onTap: _searchController.clear,
            child: const Icon(Icons.close, size: 14, color: AppColors.gray500),
          ),
          suffixIconConstraints: const BoxConstraints.expand(width: 30),
        ),
        cursorColor: AppColors.textColor,
        controller: _searchController,
        onFieldSubmitted: _navigateToSearchResults,
        focusNode: _focusNode,
      ),
    );
  }

  OutlineInputBorder _buildTextFieldBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      ),
      borderSide: BorderSide(color: AppColors.secondary),
    );
  }

  Widget _buildSearchButton() {
    return SizedBox(
      width: 40,
      child: IconButton(
        onPressed: () {
          _navigateToSearchResults(_searchController.text);
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

  Widget _buildSuggestedSeaches() {
    final suggestedSearches = ref.watch(searchProvider).suggestedSearches;
    return ListView.separated(
      itemCount: suggestedSearches.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestedSearches[index],
            style: AppTextStyle.textColorBodySmall,
          ),
          onTap: () {
            _navigateToSearchResults(suggestedSearches[index]);
          },
        );
      },
      separatorBuilder: (_, __) =>
          const Divider(thickness: 1, height: 0, color: AppColors.gray300),
    );
  }

  Widget _buildRecentSearches() {
    final recentSearches = ref.watch(searchProvider).recentSearches;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              recentSearches.reversed.map(_buildRecentSearchChip).toList(),
        ),
      ),
    );
  }

  Widget _buildRecentSearchChip(String value) {
    return GestureDetector(
      onTap: () {
        _searchController.text = value;
      },
      child: Container(
        constraints: const BoxConstraints(minWidth: 72),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: AppColors.gray500),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          value,
          style: AppTextStyle.textColorBodySmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
