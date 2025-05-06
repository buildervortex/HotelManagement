import "package:flutter_dotenv/flutter_dotenv.dart";
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
  Supabase.initialize(
    url: dotenv.env["SUPABASE_URL"]!,
    anonKey: dotenv.env["SUPABASE_API_TOKEN"]!,
  );

  log.d("Supabase initialized successfully!");
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
