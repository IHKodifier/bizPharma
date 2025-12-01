import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../providers/user_provider.dart';
import '../widgets/sidebar_navigation.dart';
import '../widgets/kpi_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/sales_chart_widget.dart';
import '../widgets/critical_alerts_widget.dart';
import '../widgets/activity_feed_widget.dart';
import '../widgets/dashboard_shimmer.dart';
import '../../../../widgets/ik_app_bar.dart';

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
      appBar: IkAppBar(
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
            child: _isLoading
                ? const DashboardShimmer()
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Good Morning, ${user?.firstName ?? 'User'}',
                                    style: GoogleFonts.inter(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                      letterSpacing: -0.5,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Here's what's happening in your pharmacy today.",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: theme.dividerColor),
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

                        // KPI Grid
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: GridView.count(
                            key: ValueKey(_isSidebarCollapsed),
                            crossAxisCount: _isSidebarCollapsed ? 4 : 3,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 1.6,
                            children: [
                              KpiCard(
                                title: "Today's Revenue",
                                value: '\$12,482',
                                trend: '+5.2%',
                                isTrendPositive: true,
                                trendText: 'vs yesterday',
                              ),
                              KpiCard(
                                title: 'Active Transactions',
                                value: '8',
                                trend: '3 POS sessions',
                                isTrendPositive: true,
                                icon: Icons.point_of_sale,
                                iconColor: Colors.blue,
                              ),
                              KpiCard(
                                title: 'Pending Approvals',
                                value: '12',
                                trend: '5 urgent',
                                isTrendPositive: false,
                                icon: Icons.approval,
                                iconColor: Colors.orange,
                              ),
                              if (_isSidebarCollapsed)
                                KpiCard(
                                  title: 'System Health',
                                  value: '99.8%',
                                  trend: 'Operational',
                                  isTrendPositive: true,
                                  icon: Icons.cloud_done,
                                  iconColor: Colors.green,
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Quick Actions
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

                        // Charts and Activity
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
    );
  }
}
