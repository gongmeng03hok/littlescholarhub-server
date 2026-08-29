import axios from "axios";
import * as SecureStore from "expo-secure-store";
import { Platform } from "react-native";

const BASE_URL = process.env.EXPO_PUBLIC_API_URL || "https://www.littlescholarhub.com/api";
/** Exported for utils/track.ts, which posts telemetry outside axios. */
export const API_BASE = BASE_URL;
//const BASE_URL = process.env.EXPO_PUBLIC_API_URL || "http://127.0.0.1:5000/api";

export const TOKEN_KEY = "lsh_token";
// Stashes the admin's own token while impersonating another account, so
// "Return to admin" can restore it without a fresh login.
export const IMPERSONATOR_TOKEN_KEY = "lsh_impersonator_token";

// SecureStore not available on web — fall back to localStorage
export async function getToken(): Promise<string | null> {
  if (Platform.OS === "web") return localStorage.getItem(TOKEN_KEY);
  return SecureStore.getItemAsync(TOKEN_KEY);
}
export async function setToken(token: string) {
  if (Platform.OS === "web") { localStorage.setItem(TOKEN_KEY, token); return; }
  await SecureStore.setItemAsync(TOKEN_KEY, token);
}
export async function removeToken() {
  if (Platform.OS === "web") { localStorage.removeItem(TOKEN_KEY); return; }
  await SecureStore.deleteItemAsync(TOKEN_KEY);
}

export async function getImpersonatorToken(): Promise<string | null> {
  if (Platform.OS === "web") return localStorage.getItem(IMPERSONATOR_TOKEN_KEY);
  return SecureStore.getItemAsync(IMPERSONATOR_TOKEN_KEY);
}
export async function setImpersonatorToken(token: string) {
  if (Platform.OS === "web") { localStorage.setItem(IMPERSONATOR_TOKEN_KEY, token); return; }
  await SecureStore.setItemAsync(IMPERSONATOR_TOKEN_KEY, token);
}
export async function removeImpersonatorToken() {
  if (Platform.OS === "web") { localStorage.removeItem(IMPERSONATOR_TOKEN_KEY); return; }
  await SecureStore.deleteItemAsync(IMPERSONATOR_TOKEN_KEY);
}

const http = axios.create({ baseURL: BASE_URL });

// Attach token to every request
http.interceptors.request.use(async (config) => {
  const token = await getToken();
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});

// Unwrap data, surface errors
http.interceptors.response.use(
  (res) => res.data,
  (err) => {
    const msg = err?.response?.data?.error || err.message || "Network error";
    return Promise.reject(new Error(msg));
  }
);

export default http;
