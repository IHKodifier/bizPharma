import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserAvatar extends StatelessWidget {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? photoUrl;
  final String? role;
  final double size;
  final VoidCallback? onLogout;

  const UserAvatar({
    super.key,
    this.firstName,
    this.lastName,
    this.email,
    this.photoUrl,
    this.role,
    this.size = 40,
    this.onLogout,
  });

  String get _initials {
    final first = firstName?.isNotEmpty == true ? firstName![0] : '';
    final last = lastName?.isNotEmpty == true ? lastName![0] : '';
    return (first + last).toUpperCase();
  }

  String get _gravatarUrl {
    if (email == null) return '';
    final hash = md5
        .convert(utf8.encode(email!.trim().toLowerCase()))
        .toString();
    return 'https://www.gravatar.com/avatar/$hash?d=404';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget avatarContent;

    if (photoUrl != null && photoUrl!.isNotEmpty) {
      avatarContent = CircleAvatar(
        radius: size / 2,
        backgroundImage: NetworkImage(photoUrl!),
      );
    } else if (email != null && email!.isNotEmpty) {
      avatarContent = CircleAvatar(
        radius: size / 2,
        backgroundColor: Colors.orange.shade100,
        backgroundImage: NetworkImage(_gravatarUrl),
        onBackgroundImageError: (_, __) {
          // Fallback to initials handled by child if image fails
        },
        child: Text(
          _initials,
          style: GoogleFonts.inter(
            color: Colors.orange.shade800,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.4,
          ),
        ),
      );
    } else {
      avatarContent = CircleAvatar(
        radius: size / 2,
        backgroundColor: Colors.orange.shade100,
        child: Text(
          _initials,
          style: GoogleFonts.inter(
            color: Colors.orange.shade800,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.4,
          ),
        ),
      );
    }

    return PopupMenuButton<String>(
      offset: const Offset(0, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$firstName $lastName',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              if (role != null)
                Text(
                  role!,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, size: 20, color: colorScheme.error),
              const SizedBox(width: 8),
              Text(
                'Logout',
                style: GoogleFonts.inter(
                  color: colorScheme.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        print('UserAvatar: Menu selected: $value');
        if (value == 'logout') {
          if (onLogout != null) {
            print('UserAvatar: Calling onLogout callback');
            onLogout?.call();
          } else {
            print('UserAvatar: onLogout callback is null!');
          }
        }
      },
      child: avatarContent,
    );
  }
}
