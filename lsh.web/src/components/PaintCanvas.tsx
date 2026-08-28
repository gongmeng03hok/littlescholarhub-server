/**
 * PaintCanvas — colour the picture on screen, and stick stickers on it.
 *
 * The colouring worksheets used to offer a PDF and nothing else, so a child on a
 * tablet saw a cover image and a print button. Here the same line art that comes
 * out of the printer is tappable: pick a colour, tap a region, it fills. Pick a
 * sticker and the next tap drops it wherever you touched.
 *
 * Two press paths share one canvas, so they must not fight:
 *   • nothing armed → taps fall through to the shapes, which fill themselves;
 *   • a sticker armed → the wrapper claims the gesture *on capture*, so the tap
 *     places a sticker instead of repainting whatever was underneath it.
 * That is why placement lives on the wrapper View and not on the background rect.
 */
import { useRef, useState } from "react";
import {
  View, Text, TouchableOpacity, StyleSheet, type LayoutChangeEvent,
  type GestureResponderEvent, type ViewStyle,
} from "react-native";
import Svg, { Path, Circle, Ellipse, Line, Rect, G } from "react-native-svg";
import { colors } from "../constants/theme";
import { PAINT_SCENES, STICKERS, PAINT_COLORS, type PaintScene } from "../constants/paintArt";

const SKY = "sky";
const STICKER_BOX = 40;
const STICKER_ON_CANVAS = 46;

export function hasPaintScene(key?: string | null): boolean {
  return !!key && key in PAINT_SCENES;
}

interface Placed { id: string; sticker: string; x: number; y: number }

export function PaintCanvas({ sceneKey, style }: { sceneKey: string; style?: ViewStyle }) {
  const scene: PaintScene | undefined = PAINT_SCENES[sceneKey];

  const [color, setColor] = useState(PAINT_COLORS[0].hex);
  const [armed, setArmed] = useState<string | null>(null);
  const [fills, setFills] = useState<Record<string, string>>({});
  const [placed, setPlaced] = useState<Placed[]>([]);

  // Taps arrive in layout pixels; the art is authored in its own units.
  const scale = useRef(1);
  const onLayout = (e: LayoutChangeEvent) => {
    const w = e.nativeEvent.layout.width;
    if (w > 0 && scene) scale.current = scene.w / w;
  };

  if (!scene) return null;

  const paint = (id: string) => !armed && setFills((f) => ({ ...f, [id]: color }));

  const place = (e: GestureResponderEvent) => {
    if (!armed) return;
    const { locationX, locationY } = e.nativeEvent;
    setPlaced((p) => [...p, {
      // Date.now() would collide when a child taps twice in the same millisecond.
      id: `${armed}-${p.length}-${Math.round(locationX)}`,
      sticker: armed,
      x: locationX * scale.current,
      y: locationY * scale.current,
    }]);
    setArmed(null);
  };

  const startOver = () => { setFills({}); setPlaced([]); setArmed(null); };

  return (
    <View style={[s.wrap, style]}>
      <Text style={s.kicker}>Paint {scene.label}</Text>
      <Text style={s.hint}>
        {armed
          ? "Now tap the picture to stick it on"
          : "Tap a colour, then tap a part of the picture"}
      </Text>

      <View
        style={s.canvas}
        onLayout={onLayout}
        // Capture only while a sticker is armed, so ordinary taps still reach
        // the shapes underneath and colour them.
        onStartShouldSetResponderCapture={() => !!armed}
        onResponderRelease={place}
      >
        <Svg width="100%" height="100%" viewBox={`0 0 ${scene.w} ${scene.h}`}>
          <Rect
            x={0} y={0} width={scene.w} height={scene.h}
            fill={fills[SKY] ?? "#ffffff"}
            onPress={() => paint(SKY)}
          />

          {scene.parts.map((p) => {
            const fill = p.paint ? (fills[p.id] ?? "#ffffff") : "none";
            const press = p.paint ? () => paint(p.id) : undefined;
            const common = {
              fill,
              stroke: "#2b2420",
              strokeWidth: p.sw,
              strokeLinecap: "round" as const,
              strokeLinejoin: "round" as const,
              onPress: press,
            };
            if (p.t === "path")    return <Path key={p.id} d={p.d!} {...common} />;
            if (p.t === "circle")  return <Circle key={p.id} cx={p.cx} cy={p.cy} r={p.r} {...common} />;
            if (p.t === "ellipse") return <Ellipse key={p.id} cx={p.cx} cy={p.cy} rx={p.rx} ry={p.ry} {...common} />;
            return <Line key={p.id} x1={p.x1} y1={p.y1} x2={p.x2} y2={p.y2}
                         stroke="#2b2420" strokeWidth={p.sw} strokeLinecap="round" />;
          })}

          {placed.map((pl) => {
            const st = STICKERS.find((x) => x.id === pl.sticker);
            if (!st) return null;
            const k = STICKER_ON_CANVAS / STICKER_BOX;
            return (
              <G key={pl.id}
                 transform={`translate(${pl.x - STICKER_ON_CANVAS / 2}, ${pl.y - STICKER_ON_CANVAS / 2}) scale(${k})`}>
                {st.shapes.map((sh, i) => <Path key={i} d={sh.d} fill={sh.fill} />)}
              </G>
            );
          })}
        </Svg>
      </View>

      <Text style={s.label}>Colours</Text>
      <View style={s.row}>
        {PAINT_COLORS.map((c) => (
          <TouchableOpacity
            key={c.hex}
            onPress={() => { setColor(c.hex); setArmed(null); }}
            style={[s.swatch, { backgroundColor: c.hex }, color === c.hex && !armed && s.swatchOn]}
            accessibilityRole="button"
            accessibilityLabel={`Paint with ${c.name}`}
            accessibilityState={{ selected: color === c.hex }}
          />
        ))}
        <TouchableOpacity
          onPress={() => { setColor("#ffffff"); setArmed(null); }}
          style={[s.swatch, s.eraser, color === "#ffffff" && !armed && s.swatchOn]}
          accessibilityRole="button"
          accessibilityLabel="Rub a colour out"
        >
          <Text style={s.eraserText}>✕</Text>
        </TouchableOpacity>
      </View>

      <Text style={s.label}>Stickers</Text>
      <View style={s.row}>
        {STICKERS.map((st) => (
          <TouchableOpacity
            key={st.id}
            onPress={() => setArmed((a) => (a === st.id ? null : st.id))}
            style={[s.stickerBtn, armed === st.id && s.stickerOn]}
            accessibilityRole="button"
            accessibilityLabel={`${st.label} sticker`}
            accessibilityState={{ selected: armed === st.id }}
          >
            <Svg width={34} height={34} viewBox={`0 0 ${STICKER_BOX} ${STICKER_BOX}`}>
              {st.shapes.map((sh, i) => <Path key={i} d={sh.d} fill={sh.fill} />)}
            </Svg>
          </TouchableOpacity>
        ))}
      </View>

      <View style={s.actions}>
        {placed.length > 0 && (
          <TouchableOpacity onPress={() => setPlaced([])} style={s.action}
            accessibilityRole="button">
            <Text style={s.actionText}>Take the stickers off</Text>
          </TouchableOpacity>
        )}
        <TouchableOpacity onPress={startOver} style={s.action} accessibilityRole="button">
          <Text style={s.actionText}>Start over</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const s = StyleSheet.create({
  wrap:   { backgroundColor: "#ffffff", borderRadius: 18, padding: 16 },
  kicker: { fontSize: 11, fontWeight: "900", letterSpacing: 0.8, textTransform: "uppercase",
            color: colors.brand, marginBottom: 4 },
  hint:   { fontSize: 14, fontWeight: "700", color: colors.textMuted, marginBottom: 12 },

  // 320x225 art, so 64:45 shows it whole at any width.
  canvas: { width: "100%", aspectRatio: 64 / 45, borderRadius: 14, overflow: "hidden",
            borderWidth: 2, borderColor: "#efe7d8", backgroundColor: "#ffffff" },

  label:  { fontSize: 11, fontWeight: "900", letterSpacing: 0.8, textTransform: "uppercase",
            color: colors.textMuted, marginTop: 16, marginBottom: 8 },
  row:    { flexDirection: "row", flexWrap: "wrap", gap: 10 },

  // 44pt targets: small fingers, and it keeps the row tappable on a phone.
  swatch:  { width: 44, height: 44, borderRadius: 22, borderWidth: 3, borderColor: "transparent" },
  swatchOn:{ borderColor: colors.text },
  eraser:  { backgroundColor: "#ffffff", borderColor: "#d9d2c4",
             alignItems: "center", justifyContent: "center" },
  eraserText: { fontSize: 18, fontWeight: "900", color: colors.textMuted },

  stickerBtn: { width: 46, height: 46, borderRadius: 14, borderWidth: 3, borderColor: "#efe7d8",
                alignItems: "center", justifyContent: "center", backgroundColor: "#fbf7ef" },
  stickerOn:  { borderColor: colors.brand, backgroundColor: "#fff0f7" },

  actions:    { flexDirection: "row", flexWrap: "wrap", gap: 10, marginTop: 18 },
  action:     { paddingVertical: 10, paddingHorizontal: 16, borderRadius: 12,
                backgroundColor: "#f4f1ea" },
  actionText: { fontSize: 13, fontWeight: "800", color: colors.textMuted },
});
