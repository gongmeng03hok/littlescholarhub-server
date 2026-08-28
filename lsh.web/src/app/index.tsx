import Landing from "./(auth)/landing";

/**
 * Root route ("/") IS the public home page — it always renders the landing page,
 * for every visitor (signed in or not). Signing in / navigation into the app
 * happens via the landing page's own buttons.
 */
export default function Index() {
  return <Landing />;
}
