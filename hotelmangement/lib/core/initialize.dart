import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:hotelmangement/di/dicontainer.dart";
import "package:logger/web.dart";
import "package:supabase_flutter/supabase_flutter.dart";

Future<void> initializeProject() async {
  final Logger log = Logger();
  // load the environment variables
  try {
    await dotenv.load(fileName: "assets/.env");
    log.d("The environment variables are successfully loaded");
  } catch (e, stacktrace) {
    log.d("An expection occoured when loading the environment variables!",
        error: e, stackTrace: stacktrace);
  }

  final isReady = isConfigReady(dotenv);

  if (isReady != null) {
    log.d("The environment variable named ${isReady} is not found");
  }

  // initialize the superbase
  await Supabase.initialize(
    url: dotenv.env["SUPABASE_URL"]!,
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB2dWlzdnRveWpxYXZjYXBhbGdzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MjU2NTEwNywiZXhwIjoyMDU4MTQxMTA3fQ.wWRGbw_cscKq2aHpc7Pf9I3ONyukrB_PYFyVzDpy_j0",
    debug: true
  );

  log.d("Supabase initialized successfully!");

  // initialize the di container
  setUpLocator();
}

String? isConfigReady(DotEnv dotenv) {
  final List<String> configList = [
    "SUPABASE_URL",
    "SUPABASE_API_TOKEN",
  ];

  for (var item in configList) {
    if (!dotenv.env.containsKey(item)) {
      return item;
    }
  }

  return null;
}
