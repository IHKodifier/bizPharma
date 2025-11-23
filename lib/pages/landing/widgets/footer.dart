import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingFooter extends StatelessWidget {
  const LandingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Container(
      width: double.infinity,
      color: theme.colorScheme.surfaceContainerHighest,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: 40,
      ),
      child: Column(
        children: [
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _FooterColumn(
                    title: 'Product',
                    links: const ['Features', 'Solutions', 'Pricing', 'Demo'],
                  ),
                ),
                Expanded(
                  child: _FooterColumn(
                    title: 'Company',
                    links: const ['About', 'Blog', 'Careers', 'Contact'],
                  ),
                ),
                Expanded(
                  child: _FooterColumn(
                    title: 'Support',
                    links: const [
                      'Help Center',
                      'Documentation',
                      'API',
                      'Status',
                    ],
                  ),
                ),
                Expanded(
                  child: _FooterColumn(
                    title: 'Legal',
                    links: const ['Privacy', 'Terms', 'Security'],
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                _FooterColumn(
                  title: 'Product',
                  links: const ['Features', 'Solutions', 'Pricing', 'Demo'],
                ),
                const SizedBox(height: 24),
                _FooterColumn(
                  title: 'Company',
                  links: const ['About', 'Blog', 'Careers', 'Contact'],
                ),
                const SizedBox(height: 24),
                _FooterColumn(
                  title: 'Support',
                  links: const [
                    'Help Center',
                    'Documentation',
                    'API',
                    'Status',
                  ],
                ),
              ],
            ),
          const SizedBox(height: 40),
          Divider(color: theme.colorScheme.outline.withOpacity(0.2)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '© 2025 ikPharma. All rights reserved.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
              if (!isMobile)
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook, size: 20),
                      tooltip: 'Facebook',
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.public, size: 20),
                      tooltip: 'Twitter',
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.link, size: 20),
                      tooltip: 'LinkedIn',
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> links;

  const _FooterColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: () {},
              child: Text(
                link,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
