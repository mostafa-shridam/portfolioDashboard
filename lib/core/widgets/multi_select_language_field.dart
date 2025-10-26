import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userportfolio/core/models/language_model.dart';
import 'package:userportfolio/core/theme/style.dart';

import '../local_service/save_user.dart';
import '../models/user_model.dart';
import 'custom_button.dart';

class MultiSelectLanguageField extends ConsumerStatefulWidget {
  final List<String> selectedLanguageCodes;
  final Function(List<String>) onChanged;
  final String labelText;
  final String hintText;
  final Widget? prefixIcon;
  final bool enabled;

  const MultiSelectLanguageField({
    super.key,
    required this.selectedLanguageCodes,
    required this.onChanged,
    this.labelText = 'Languages',
    this.hintText = 'Select languages',
    this.prefixIcon,
    this.enabled = true,
  });

  @override
  ConsumerState<MultiSelectLanguageField> createState() =>
      _MultiSelectLanguageFieldState();
}

class _MultiSelectLanguageFieldState
    extends ConsumerState<MultiSelectLanguageField> {
  final TextEditingController _searchController = TextEditingController();
  List<LanguageModel> _filteredLanguages = Languages.all;
  List<LanguageModel> _selectedLanguages = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguages();
    Future.microtask(() {
      final userData = ref.watch(saveUserProvider).getUserData() ?? UserModel();
      _selectedLanguages =
          userData.languages
              ?.map((code) => Languages.findByCode(code))
              .where((lang) => lang != null)
              .cast<LanguageModel>()
              .toList() ??
          [];
    });
  }

  @override
  void didUpdateWidget(MultiSelectLanguageField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedLanguageCodes != widget.selectedLanguageCodes) {
      _loadSelectedLanguages();
    }
  }

  void _loadSelectedLanguages() {
    _selectedLanguages = widget.selectedLanguageCodes
        .map((code) => Languages.findByCode(code))
        .where((lang) => lang != null)
        .cast<LanguageModel>()
        .toList();
  }

  void _filterLanguages(String query) {
    setState(() {
      _filteredLanguages = Languages.search(query);
    });
  }

  void _toggleLanguage(LanguageModel language, [StateSetter? setModalState]) {
    // Update the selected languages
    if (_selectedLanguages.contains(language)) {
      _selectedLanguages.remove(language);
    } else {
      _selectedLanguages.add(language);
    }

    // Update modal state if provided
    if (setModalState != null) {
      setModalState(() {});
    }

    // Update main widget state
    setState(() {});

    final codes = _selectedLanguages.map((lang) => lang.code).toList();
    widget.onChanged(codes);
  }

  void _showLanguageSelector() {
    // Reset search when opening
    _searchController.clear();
    _filteredLanguages = Languages.all;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildLanguageSelector(),
    );
  }

  Widget _buildLanguageSelector() {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Select Languages',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search languages...',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              _filterLanguages('');
                              setModalState(() {});
                            },
                            icon: Icon(Icons.clear),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                  ),
                  onChanged: (query) {
                    _filterLanguages(query);
                    setModalState(() {});
                  },
                ),
              ),

              // Selected Languages Count
              if (_selectedLanguages.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: primaryColor, size: 16),
                      SizedBox(width: 8),
                      Text(
                        '${_selectedLanguages.length} language${_selectedLanguages.length > 1 ? 's' : ''} selected',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 8),

              // Languages List
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredLanguages.length,
                  itemBuilder: (context, index) {
                    final language = _filteredLanguages[index];
                    final isSelected = _selectedLanguages.contains(language);

                    return ListTile(
                      leading: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? primaryColor : Colors.grey,
                            width: 2,
                          ),
                          color: isSelected ? primaryColor : Colors.transparent,
                        ),
                        child: isSelected
                            ? Icon(Icons.check, color: Colors.white, size: 16)
                            : null,
                      ),
                      title: Text(
                        language.name,
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(
                        '${language.nativeName} (${language.code})',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check_circle, color: primaryColor)
                          : null,
                      onTap: () => _toggleLanguage(language, setModalState),
                    );
                  },
                ),
              ),

              // Done Button
              CustomButton(
                onPressed: () => Navigator.pop(context),
                text: 'Done (${_selectedLanguages.length})',
              ),
              SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.labelText.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              widget.labelText,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),

        // Field
        InkWell(
          onTap: widget.enabled ? _showLanguageSelector : null,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
              color: widget.enabled
                  ? Theme.of(context).cardColor
                  : Theme.of(context).disabledColor.withValues(alpha: 0.1),
            ),
            child: Row(
              children: [
                if (widget.prefixIcon != null) ...[
                  widget.prefixIcon!,
                  SizedBox(width: 12),
                ],
                Expanded(
                  child: _selectedLanguages.isEmpty
                      ? Text(
                          widget.hintText,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Theme.of(context).hintColor),
                        )
                      : Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: _selectedLanguages
                              .map((lang) => _buildLanguageChip(lang))
                              .toList(),
                        ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_drop_down, color: primaryColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageChip(LanguageModel language) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            language.name,
            style: TextStyle(
              color: primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 4),
          InkWell(
            onTap: () => _toggleLanguage(language),
            borderRadius: BorderRadius.circular(12),
            child: Icon(Icons.close, size: 16, color: primaryColor),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
