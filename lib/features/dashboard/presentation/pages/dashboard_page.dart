import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../providers/user_provider.dart';
import '../widgets/sidebar_navigation.dart';
import '../widgets/kpi_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/sales_chart_widget.dart';
import '../widgets/critical_alerts_widget.dart';
import '../widgets/activity_feed_widget.dart';
import '../widgets/dashboard_shimmer.dart';
import '../../../../widgets/biz_app_bar.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  bool _isSidebarCollapsed = false;
  bool _isLoading = false;
  String _selectedDateFilter = 'Last 7 Days';

  final List<String> _dateFilterOptions = [
    'Today (since midnight)',
    'Last 24 hrs',
    'This Week',
    'Last Week',
    'This Month',
    'Last Month',
    'This Quarter',
    'Last Quarter',
    'This Year',
    'Last Year',
    'Choose Dates',
  ];

  void _toggleSidebar() {
    setState(() {
      _isSidebarCollapsed = !_isSidebarCollapsed;
    });
  }

  Future<void> _onDateFilterChanged(String? newValue) async {
    if (newValue != null) {
      setState(() {
        _selectedDateFilter = newValue;
        _isLoading = true;
      });

      // Mock loading delay
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = ref.watch(userProvider);
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
              ),
            ),

          // Main Content
          Expanded(
            child: Column(
              children: [
                // Trial Status Banner
                Container(
                  width: double.infinity,
                  color: theme.brightness == Brightness.light
                      ? const Color(0xFFFFF3CD)
                      : const Color(0xFF5C5100),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.brightness == Brightness.light
                            ? const Color(0xFF856404)
                            : const Color(0xFFFFD54F),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Trial: 28 days remaining • 0/500 products • 0/500 transactions',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme.brightness == Brightness.light
                                ? const Color(0xFF856404)
                                : const Color(0xFFFFD54F),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: theme.brightness == Brightness.light
                              ? const Color(0xFF856404)
                              : const Color(0xFFFFD54F),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Upgrade Now'),
                      ),
                    ],
                  ),
                ),

                // Scrollable Dashboard Content
                Expanded(
                  child: _isLoading
                      ? const DashboardShimmer()
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Welcome & Search Section
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Good Morning, ${user?.firstName ?? 'User'}',
                                          style: GoogleFonts.inter(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.onSurface,
                                            letterSpacing: -0.5,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Here's what's happening in your pharmacy today.",
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (!isLargeScreen)
                                    const SizedBox(height: 16),
                                  if (isLargeScreen) const SizedBox(width: 32),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme.surface,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: theme.dividerColor,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value:
                                            _dateFilterOptions.contains(
                                              _selectedDateFilter,
                                            )
                                            ? _selectedDateFilter
                                            : null,
                                        hint: Text(_selectedDateFilter),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: colorScheme.onSurfaceVariant,
                                          size: 20,
                                        ),
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: colorScheme.onSurface,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        onChanged: _onDateFilterChanged,
                                        items: _dateFilterOptions
                                            .map<DropdownMenuItem<String>>((
                                              String value,
                                            ) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            })
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),

                              // Pharmacy KPI Grid
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  int crossAxisCount = 4;
                                  double childAspectRatio = 1.8;

                                  if (constraints.maxWidth < 600) {
                                    crossAxisCount = 2; // Mobile
                                    childAspectRatio = 1.5;
                                  } else if (constraints.maxWidth < 1100) {
                                    crossAxisCount = 3; // Tablet
                                    childAspectRatio = 1.6;
                                  }

                                  return GridView.count(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 24,
                                    mainAxisSpacing: 24,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    childAspectRatio: childAspectRatio,
                                    children: [
                                      KpiCard(
                                        index: 0,
                                        title: "Today's Sales",
                                        value: 'PKR 42,480',
                                        trend: '+8.2%',
                                        isTrendPositive: true,
                                        trendText: 'vs yesterday',
                                        icon: Icons.attach_money,
                                        iconColor: Colors.green,
                                      ),
                                      KpiCard(
                                        index: 1,
                                        title: 'Active Transactions',
                                        value: '14',
                                        trend: '2 counters open',
                                        isTrendPositive: true,
                                        icon: Icons.point_of_sale,
                                        iconColor: Colors.blue,
                                      ),
                                      KpiCard(
                                        index: 2,
                                        title: 'Low Stock Alerts',
                                        value: '8',
                                        trend: 'Needs attention',
                                        isTrendPositive: false,
                                        icon: Icons.inventory_2,
                                        iconColor: Colors.orange,
                                      ),
                                      KpiCard(
                                        index: 3,
                                        title: 'Expiring Soon',
                                        value: '12',
                                        trend: 'Next 30 days',
                                        isTrendPositive: false,
                                        icon: Icons.date_range,
                                        iconColor: Colors.red,
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 32),

                              // Quick Actions (Keep existing)
                              Text(
                                'Quick Actions',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                children: [
                                  QuickActionCard(
                                    title: 'Start POS Session',
                                    icon: Icons.point_of_sale,
                                    onTap: () {},
                                    isPrimary: true,
                                  ),
                                  QuickActionCard(
                                    title: 'Create Requisition',
                                    icon: Icons.request_quote,
                                    onTap: () {},
                                  ),
                                  QuickActionCard(
                                    title: 'Receive Goods',
                                    icon: Icons.inventory,
                                    onTap: () {},
                                  ),
                                  QuickActionCard(
                                    title: 'Process Payroll',
                                    icon: Icons.attach_money,
                                    onTap: () {},
                                  ),
                                  QuickActionCard(
                                    title: 'View Reports',
                                    icon: Icons.bar_chart,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),

                              // Charts and Activity (Keep existing)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        SalesChartWidget(),
                                        const SizedBox(height: 24),
                                        ActivityFeedWidget(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  const Expanded(
                                    flex: 1,
                                    child: CriticalAlertsWidget(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
