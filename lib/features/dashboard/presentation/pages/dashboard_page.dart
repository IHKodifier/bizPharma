import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/user_provider.dart';
import '../../../../widgets/biz_app_bar.dart';
import '../widgets/sidebar_navigation.dart';
import '../widgets/dashboard_content.dart';
import '../../../inventory/presentation/pages/inventory_page.dart';
import '../../../settings/locations/presentation/pages/locations_page.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  bool _isSidebarCollapsed = false;
  String _currentRoute = 'dashboard';

  void _toggleSidebar() {
    setState(() {
      _isSidebarCollapsed = !_isSidebarCollapsed;
    });
  }

  void _onItemSelected(String route) {
    setState(() {
      _currentRoute = route;
    });
  }

  Widget _buildMainContent() {
    switch (_currentRoute) {
      case 'inventory':
        // Wrap InventoryPage in Expanded + Scroll as it doesn't handle it internally yet
        return const Expanded(
          child: SingleChildScrollView(child: InventoryPage()),
        );
      case 'locations':
        return const Expanded(child: LocationsPage());
      case 'dashboard':
      default:
        // DashboardContent already returns an Expanded widget
        return const DashboardContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLargeScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? const Color(0xFFF9FAFB)
          : colorScheme.surface,
      appBar: BizAppBar(
        isSidebarCollapsed: _isSidebarCollapsed,
        onToggleSidebar: _toggleSidebar,
      ),
      body: Row(
        children: [
          // Sidebar
          if (isLargeScreen)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _isSidebarCollapsed ? 80 : 280,
              child: SidebarNavigation(
                isCollapsed: _isSidebarCollapsed,
                onToggleCollapse: _toggleSidebar,
                onItemSelected: _onItemSelected,
              ),
            ),

          // Main Content
          _buildMainContent(),
        ],
      ),
    );
  }
}
