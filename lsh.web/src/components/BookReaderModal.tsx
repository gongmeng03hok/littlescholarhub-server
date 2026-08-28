/**
 * Full-screen book reader for our own uploaded/generated PDF stories:
 * embeds the PDF directly (the browser's native PDF viewer gives page
 * navigation/zoom), with a read-aloud bar underneath using the story's
 * generated narration audio.
 */
import { useEffect, useRef, useState } from "react";
import { Modal, View, Text, TouchableOpacity, StyleSheet, Platform } from "react-native";
import { Audio } from "expo-av";
import { colors } from "../constants/theme";

interface Props {
  visible: boolean;
  pdfUrl?: string | null;       // our own uploaded PDF (blob-backed)
  audioUrl?: string | null;     // read-aloud narration
  title?: string;
  onClose: () => void;
}

export function BookReaderModal({ visible, pdfUrl, audioUrl, title, onClose }: Props) {
  const soundRef = useRef<Audio.Sound | null>(null);
  const [audioState, setAudioState] = useState<"idle" | "loading" | "playing" | "paused">("idle");

  useEffect(() => {
    if (!visible) {
      soundRef.current?.unloadAsync();
      soundRef.current = null;
      setAudioState("idle");
    }
  }, [visible]);

  const toggleReadAloud = async () => {
    if (!audioUrl) return;
    if (soundRef.current) {
      const status = await soundRef.current.getStatusAsync();
      if (status.isLoaded && status.isPlaying) {
        await soundRef.current.pauseAsync();
        setAudioState("paused");
      } else {
        await soundRef.current.playAsync();
        setAudioState("playing");
      }
      return;
    }
    try {
      setAudioState("loading");
      const { sound } = await Audio.Sound.createAsync(
        { uri: audioUrl },
        { shouldPlay: true },
        (status) => { if (status.isLoaded && status.didJustFinish) setAudioState("paused"); }
      );
      soundRef.current = sound;
      setAudioState("playing");
    } catch {
      setAudioState("idle");
    }
  };

  const embedSrc = pdfUrl || null;
  const isOpen = visible && !!embedSrc;

  return (
    <Modal visible={isOpen} animationType="slide" onRequestClose={onClose}>
      <View style={s.root}>
        <View style={s.header}>
          <Text style={s.title} numberOfLines={1}>{title ?? "Story"}</Text>
          {!!audioUrl && (
            <TouchableOpacity onPress={toggleReadAloud} style={s.readAloudBtn}>
              <Text style={s.readAloudText}>
                {audioState === "loading" ? "⏳" : audioState === "playing" ? "⏸ Pause read-aloud" : "🔊 Read aloud"}
              </Text>
            </TouchableOpacity>
          )}
          <TouchableOpacity onPress={onClose} style={s.closeBtn}>
            <Text style={s.closeText}>✕ Close</Text>
          </TouchableOpacity>
        </View>
        {Platform.OS === "web" && embedSrc ? (
          // @ts-ignore — plain DOM iframe, web-only
          <iframe
            src={embedSrc}
            style={{ flex: 1, width: "100%", height: "100%", border: "none" }}
            allowFullScreen
          />
        ) : (
          <View style={s.fallback}>
            <Text style={s.fallbackText}>This story opens best on the web app for now.</Text>
          </View>
        )}
      </View>
    </Modal>
  );
}

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#1a1a1a" },
  header: { flexDirection: "row", alignItems: "center", justifyContent: "space-between", gap: 10,
            paddingTop: Platform.OS === "ios" ? 56 : 16, paddingBottom: 12, paddingHorizontal: 16,
            backgroundColor: "#111" },
  title:  { flex: 1, color: "white", fontWeight: "800", fontSize: 15 },
  readAloudBtn: { backgroundColor: colors.brand, borderRadius: 8, paddingHorizontal: 12, paddingVertical: 8 },
  readAloudText: { color: "white", fontWeight: "700", fontSize: 13 },
  closeBtn:  { backgroundColor: "rgba(255,255,255,0.15)", borderRadius: 8, paddingHorizontal: 12, paddingVertical: 8 },
  closeText: { color: "white", fontWeight: "700", fontSize: 13 },
  fallback: { flex: 1, alignItems: "center", justifyContent: "center", padding: 32 },
  fallbackText: { color: "white", fontSize: 15, textAlign: "center" },
});
