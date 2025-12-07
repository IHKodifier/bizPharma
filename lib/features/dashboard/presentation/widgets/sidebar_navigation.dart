import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../providers/auth_provider.dart';

class SidebarNavigation extends ConsumerStatefulWidget {
  final bool isCollapsed;
  final VoidCallback onToggleCollapse;

  const SidebarNavigation({
    super.key,
    required this.isCollapsed,
    required this.onToggleCollapse,
  });

  @override
  ConsumerState<SidebarNavigation> createState() => _SidebarNavigationState();
}

class _SidebarNavigationState extends ConsumerState<SidebarNavigation> {
  String? _expandedModule;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isCollapsed = widget.isCollapsed;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isCollapsed ? 72 : 280,
      color: colorScheme.surface,
      child: Column(
        children: [
          const SizedBox(height: 12),

          // Navigation Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildNavItem(
                  context,
                  Icons.dashboard,
                  'Dashboard',
                  isSelected: true,
                ),
                const SizedBox(height: 4),
                _buildExpandableModule(
                  context,
                  Icons.point_of_sale,
                  'Point of Sale',
                  'pos',
                  [
                    _ModuleItem('New Sale', Icons.add_shopping_cart),
                    _ModuleItem('Returns', Icons.keyboard_return),
                    _ModuleItem('Customers', Icons.people),
                  ],
                ),
                _buildExpandableModule(
                  context,
                  Icons.inventory_2,
                  'Inventory',
                  'inventory',
                  [
                    _ModuleItem('Stock Levels', Icons.storage),
                    _ModuleItem('Transfers', Icons.sync_alt),
                    _ModuleItem('Cycle Counts', Icons.fact_check),
                    _ModuleItem('Expiry Tracking', Icons.schedule),
                  ],
                ),
                _buildExpandableModule(
                  context,
                  Icons.shopping_cart,
                  'Procurement',
                  'procurement',
                  [
                    _ModuleItem('Requisitions', Icons.request_quote),
                    _ModuleItem('Purchase Orders', Icons.receipt_long),
                    _ModuleItem('Suppliers', Icons.business),
                    _ModuleItem('Receiving', Icons.inventory),
                  ],
                ),
                _buildExpandableModule(
                  context,
                  Icons.warehouse,
                  'Warehouse',
                  'warehouse',
                  [
                    _ModuleItem('Bin Management', Icons.grid_view),
                    _ModuleItem('Putaway', Icons.move_down),
                    _ModuleItem('Picking', Icons.shopping_basket),
                  ],
                ),
                _buildExpandableModule(
                  context,
                  Icons.account_balance,
                  'Financial',
                  'financial',
                  [
                    _ModuleItem('Accounting', Icons.calculate),
                    _ModuleItem('AP/AR', Icons.payments),
                    _ModuleItem('Tax Reports', Icons.description),
                  ],
                ),
                _buildExpandableModule(
                  context,
                  Icons.people,
                  'Human Resources',
                  'hr',
                  [
                    _ModuleItem('Attendance', Icons.access_time),
                    _ModuleItem('Payroll', Icons.attach_money),
                    _ModuleItem('Performance', Icons.trending_up),
                  ],
                ),
                _buildNavItem(context, Icons.message, 'Messaging', badge: '3'),
                _buildNavItem(context, Icons.bar_chart, 'Reports & Analytics'),
                _buildNavItem(context, Icons.settings, 'Settings'),
              ],
            ),
          ),

          // Bottom Section
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildNavItem(
                  context,
                  Icons.help_outline,
                  'Help Center',
                  isCompact: true,
                ),
                _buildNavItem(
                  context,
                  Icons.logout,
                  'Logout',
                  isCompact: true,
                  onTap: () async {
                    print('Logging out from Sidebar...');
                    await ref.read(authServiceProvider).signOut();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String title, {
    bool isSelected = false,
    String? badge,
    bool isCompact = false,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = theme.colorScheme.primary;
    final isCollapsed = widget.isCollapsed;

    final iconWidget = Icon(
      icon,
      color: isSelected ? primaryColor : colorScheme.onSurfaceVariant,
      size: isCompact ? 20 : 22,
    );

    if (isCollapsed) {
      return Tooltip(
        message: title,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? primaryColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: iconWidget,
            onPressed: onTap ?? () {},
            padding: const EdgeInsets.all(12),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        hoverColor: colorScheme.onSurface.withOpacity(0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: iconWidget,
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: isCompact ? 13 : 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? primaryColor : colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onError,
                  ),
                ),
              )
            : null,
        onTap: onTap ?? () {},
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: isCompact ? 0 : 4,
        ),
        dense: isCompact,
      ),
    );
  }

  Widget _buildExpandableModule(
    BuildContext context,
    IconData icon,
    String title,
    String moduleId,
    List<_ModuleItem> subItems,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isExpanded = _expandedModule == moduleId;
    final isCollapsed = widget.isCollapsed;

    // In collapsed mode, show as a simple icon button with tooltip
    if (isCollapsed) {
      return Tooltip(
        message: title,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: IconButton(
            icon: Icon(icon, color: colorScheme.onSurfaceVariant, size: 22),
            onPressed: () {},
            padding: const EdgeInsets.all(12),
          ),
        ),
      );
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            hoverColor: colorScheme.onSurface.withOpacity(0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            leading: Icon(icon, color: colorScheme.onSurfaceVariant, size: 22),
            title: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: colorScheme.onSurfaceVariant,
              size: 20,
            ),
            onTap: () {
              setState(() {
                _expandedModule = isExpanded ? null : moduleId;
              });
            },
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
          ),
        ),
        if (isExpanded)
          Container(
            margin: const EdgeInsets.only(left: 20, bottom: 8),
            child: Column(
              children: subItems.map((item) {
                return ListTile(
                  hoverColor: colorScheme.onSurface.withOpacity(0.08),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading: Icon(
                    item.icon,
                    color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                    size: 18,
                  ),
                  title: Text(
                    item.title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 0,
                  ),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

class _ModuleItem {
  final String title;
  final IconData icon;

  _ModuleItem(this.title, this.icon);
}
