import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import 'user_avatar.dart';

class BizAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String? title;
  final bool isSidebarCollapsed;
  final VoidCallback? onToggleSidebar;

  const BizAppBar({
    super.key,
    this.title,
    this.isSidebarCollapsed = false,
    this.onToggleSidebar,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final user = ref.watch(userProvider);

    return AppBar(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      leading: MediaQuery.of(context).size.width > 900
          ? IconButton(
              icon: Icon(
                isSidebarCollapsed ? Icons.menu : Icons.menu_open,
                color: colorScheme.onSurfaceVariant,
              ),
              onPressed: onToggleSidebar,
              tooltip: isSidebarCollapsed
                  ? 'Expand Sidebar'
                  : 'Collapse Sidebar',
            )
          : null,
      title: Row(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.local_pharmacy,
              color: theme.colorScheme.onPrimary,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'bizPharma',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),

          // Spacer to push Search Bar to the middle of available space
          const Spacer(),

          // Search Bar (Flexible Width)
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.dividerColor),
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Search...',
                  hintStyle: GoogleFonts.inter(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                    height: 1.0, // Ensure consistent line height
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  // Zero padding ensures the text centers vertically within the 40px height
                  contentPadding: EdgeInsets.zero,
                ),
                style: GoogleFonts.inter(
                  fontSize: 13,
                  height: 1.0,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),

          // Spacer to balance the layout
          const Spacer(),

          // Actions
          IconButton(
            onPressed: () => ref.read(themeProvider.notifier).toggle(),
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: colorScheme.onSurfaceVariant,
            ),
            tooltip: isDark ? 'Light Mode' : 'Dark Mode',
          ),
          const SizedBox(width: 8),
          // Messaging Icon with Badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.message_outlined,
                  color: colorScheme.onSurfaceVariant,
                ),
                tooltip: 'Messages',
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.surface, width: 1.5),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '3',
                    style: GoogleFonts.inter(
                      color: theme.colorScheme.onError,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.help_outline, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(width: 16),
          UserAvatar(
            firstName: user?.firstName,
            lastName: user?.lastName,
            email: user?.email,
            role: user?.role.stringValue,
            onLogout: () async {
              print('Logging out from Avatar...');
              await ref.read(authServiceProvider).signOut();
            },
          ),
        ],
      ),
    );
  }
}
