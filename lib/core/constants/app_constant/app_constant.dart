import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class AppConstants {
  // Database credentials
  static const String dbPassword = 'TI1ddDf9yRbffkKX';
  static const String supaBaseUrl = 'https://vmjdkyrwhejyzzqogrqg.supabase.co';
  static const String apiKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZtamRreXJ3aGVqeXp6cW9ncnFnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM4MzUwMjcsImV4cCI6MjA1OTQxMTAyN30.cJFBUoj9pIV21VOpWAlGAPLEVQixqI2oaE08FsOckoc';

  // Supabase client
  static final SupabaseClient supaBase = Supabase.instance.client;

  // current User
  static final User? currentUser = Supabase.instance.client.auth.currentUser;

  // Tables
  static const String userProfileTable = 'user_profile';
  static const String animalsTable = 'all_animals';
  static const String wishlistsTable = 'wishlists';
  static const String featuredListingsTable = 'featured_listings';
  static const String userFollowsTable = 'user_follows';
  static const String userTokensTable = 'user_tokens';
  static const String reportsListingTable = 'reports_listing';
  static const String userReportsTable = 'user_reports';

  // Buckets
  static const String profilePicturesBucket = 'users.profile.pictures';
  static const String userListingFiles = 'user.listing.files';
  static const String userListingPictures = 'listing.pictures';
  static const String userListingVideos = 'listing.videos';

  // Twilio recovery code (if needed)
  static const String twilioRecoveryCode = 'KMTJ8KR96N4AJ2HG1RMTG71P';

  // UUID Generation
  static String generateUuid() {
    var uuid = Uuid();
    return uuid.v8();
  }
}

String userName = '';
String userEmail = '';
String userId = '';

