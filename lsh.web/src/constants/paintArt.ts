/**
 * Line art for the colouring activities, and the stickers that go on top.
 *
 * The outlines are ported straight out of the printed sheets
 * (`worksheet_pdf_generator.py`) by `extract_lineart.py`, so what a child
 * paints on screen is the same picture they get out of the printer. Do not
 * hand-edit the PAINT_SCENES geometry - re-run the extractor.
 */

export interface PaintPart {
  /** stable within a scene, so a fill survives a re-render */
  id: string;
  d?: string;
  cx?: number; cy?: number; r?: number; rx?: number; ry?: number;
  x1?: number; y1?: number; x2?: number; y2?: number;
  t: "path" | "circle" | "ellipse" | "line";
  /** false = ink the child draws over, never filled and never tappable */
  paint: boolean;
  sw: number;
}

export interface PaintScene {
  /** goes straight into "Paint <label>!" */
  label: string;
  w: number;
  h: number;
  parts: PaintPart[];
}

export interface Sticker {
  id: string;
  label: string;
  /** drawn in a 40x40 box */
  shapes: { d: string; fill: string }[];
}

/** keyed by the worksheet's pdf_generator_key */
export const PAINT_SCENES: Record<string, PaintScene> = {
  draw_unicorn: {
    label: "the unicorn",
    w: 320, h: 225,
    parts: [
      { id: "p0", t: "path", d: "M127.5 47.5 C167.5 45.0 192.5 67.5 197.5 97.5 C202.5 127.5 185.0 152.5 152.5 157.5 C127.5 161.0 110.0 147.5 105.0 125.0 C100.0 97.5 107.5 65.0 127.5 47.5 Z", paint: true, sw: 3.2 },
      { id: "p1", t: "path", d: "M146.0 46.0 L159.0 -6.0 L170.0 52.0 Z", paint: true, sw: 3 },
      { id: "l2", t: "line", x1: 151.1, y1: 34.5, x2: 165.9, y2: 39.0, paint: false, sw: 2 },
      { id: "l3", t: "line", x1: 153.0, y1: 22.5, x2: 164.0, y2: 27.0, paint: false, sw: 2 },
      { id: "l4", t: "line", x1: 154.9, y1: 10.5, x2: 162.1, y2: 15.0, paint: false, sw: 2 },
      { id: "p5", t: "path", d: "M125.0 50.0 L109.0 16.0 L136.0 44.0 Z", paint: true, sw: 2.8 },
      { id: "p6", t: "path", d: "M126.0 49.0 C92.5 45.0 65.0 72.5 67.5 107.5 C70.0 137.5 92.5 160.0 115.0 167.5 C97.5 140.0 95.0 110.0 106.0 82.5", paint: false, sw: 3 },
      { id: "c7", t: "circle", cx: 147.5, cy: 87.5, r: 6.5, paint: false, sw: 2.6 },
      { id: "e8", t: "ellipse", cx: 181.0, cy: 136.0, rx: 5.5, ry: 4.0, paint: false, sw: 2.2 },
      { id: "p9", t: "path", d: "M165.0 146.0 C174.0 151.0 183.0 149.0 187.0 143.0", paint: false, sw: 2.4 },
      { id: "p10", t: "path", d: "M242.5 63.5 L245.3 56.4 L253.0 55.9 L247.1 51.0 L249.0 43.6 L242.5 47.7 L236.0 43.6 L237.9 51.0 L232.0 55.9 L239.7 56.4 Z", paint: true, sw: 2.4 },
      { id: "p11", t: "path", d: "M267.5 90.0 L269.4 85.2 L274.6 84.8 L270.6 81.5 L271.9 76.4 L267.5 79.2 L263.1 76.4 L264.4 81.5 L260.4 84.8 L265.6 85.2 Z", paint: true, sw: 2.4 },
      { id: "p12", t: "path", d: "M252.5 124.5 L255.0 118.4 L261.5 117.9 L256.5 113.7 L258.1 107.3 L252.5 110.8 L246.9 107.3 L248.5 113.7 L243.5 117.9 L250.0 118.4 Z", paint: true, sw: 2.4 },
    ],
  },
  draw_trex: {
    label: "the T-Rex",
    w: 320, h: 225,
    parts: [
      { id: "p0", t: "path", d: "M102.5 160.0 C87.5 120.0 102.5 77.5 137.5 62.5 C152.5 32.5 197.5 27.5 217.5 52.5 C235.0 72.5 230.0 92.5 207.5 97.5 C180.0 101.0 160.0 107.5 150.0 125.0 C142.5 144.0 127.5 159.0 102.5 160.0 Z", paint: true, sw: 3.2 },
      { id: "p1", t: "path", d: "M106.0 147.5 C65.0 140.0 37.5 122.5 27.5 95.0 C47.5 110.0 77.5 122.5 102.5 120.0", paint: false, sw: 3.2 },
      { id: "p2", t: "path", d: "M117.5 154.0 L117.5 186.0 L143.5 186.0", paint: false, sw: 3 },
      { id: "l3", t: "line", x1: 112.5, y1: 186.0, x2: 143.5, y2: 186.0, paint: false, sw: 3 },
      { id: "p4", t: "path", d: "M147.5 154.0 L147.5 186.0 L173.5 186.0", paint: false, sw: 3 },
      { id: "l5", t: "line", x1: 142.5, y1: 186.0, x2: 173.5, y2: 186.0, paint: false, sw: 3 },
      { id: "p6", t: "path", d: "M152.5 109.0 L167.5 122.5 L161.0 131.0", paint: false, sw: 2.6 },
      { id: "c7", t: "circle", cx: 201.0, cy: 61.0, r: 6.5, paint: false, sw: 2.6 },
      { id: "c8", t: "circle", cx: 222.0, cy: 82.0, r: 3.5, paint: false, sw: 2.2 },
      { id: "p9", t: "path", d: "M202.5 91.0 C212.5 95.0 221.0 93.0 226.0 88.0", paint: false, sw: 2.4 },
      { id: "p10", t: "path", d: "M115.0 82.5 L121.5 67.5 L128.0 82.5", paint: true, sw: 2.4 },
      { id: "p11", t: "path", d: "M130.0 77.5 L136.5 62.5 L143.0 77.5", paint: true, sw: 2.4 },
      { id: "p12", t: "path", d: "M145.0 72.5 L151.5 57.5 L158.0 72.5", paint: true, sw: 2.4 },
      { id: "p13", t: "path", d: "M160.0 67.5 L166.5 52.5 L173.0 67.5", paint: true, sw: 2.4 },
      { id: "p14", t: "path", d: "M175.0 62.5 L181.5 47.5 L188.0 62.5", paint: true, sw: 2.4 },
    ],
  },
  draw_flower: {
    label: "the flower",
    w: 320, h: 225,
    parts: [
      { id: "e0", t: "ellipse", cx: 191.5, cy: 72.5, rx: 26.0, ry: 19.0, paint: true, sw: 3 },
      { id: "e1", t: "ellipse", cx: 172.0, cy: 38.7, rx: 26.0, ry: 19.0, paint: true, sw: 3 },
      { id: "e2", t: "ellipse", cx: 133.0, cy: 38.7, rx: 26.0, ry: 19.0, paint: true, sw: 3 },
      { id: "e3", t: "ellipse", cx: 113.5, cy: 72.5, rx: 26.0, ry: 19.0, paint: true, sw: 3 },
      { id: "e4", t: "ellipse", cx: 133.0, cy: 106.3, rx: 26.0, ry: 19.0, paint: true, sw: 3 },
      { id: "e5", t: "ellipse", cx: 172.0, cy: 106.3, rx: 26.0, ry: 19.0, paint: true, sw: 3 },
      { id: "c6", t: "circle", cx: 152.5, cy: 72.5, r: 23.0, paint: true, sw: 3.2 },
      { id: "c7", t: "circle", cx: 152.5, cy: 72.5, r: 10.0, paint: true, sw: 2.2 },
      { id: "p8", t: "path", d: "M152.5 95.5 C157.5 120.0 147.5 155.0 152.5 182.5", paint: false, sw: 3.2 },
      { id: "p9", t: "path", d: "M152.5 115.0 C115.0 105.0 110.0 135.0 152.5 132.5 Z", paint: true, sw: 3 },
      { id: "p10", t: "path", d: "M152.5 127.5 C190.0 117.5 195.0 147.5 152.5 145.0 Z", paint: true, sw: 3 },
      { id: "l11", t: "line", x1: 27.5, y1: 182.5, x2: 292.5, y2: 182.5, paint: false, sw: 3 },
      { id: "c12", t: "circle", cx: 262.5, cy: 35.0, r: 21.0, paint: true, sw: 3 },
      { id: "l13", t: "line", x1: 290.5, y1: 35.0, x2: 301.5, y2: 35.0, paint: false, sw: 2.4 },
      { id: "l14", t: "line", x1: 282.3, y1: 15.2, x2: 290.1, y2: 7.4, paint: false, sw: 2.4 },
      { id: "l15", t: "line", x1: 262.5, y1: 7.0, x2: 262.5, y2: -4.0, paint: false, sw: 2.4 },
      { id: "l16", t: "line", x1: 242.7, y1: 15.2, x2: 234.9, y2: 7.4, paint: false, sw: 2.4 },
      { id: "l17", t: "line", x1: 234.5, y1: 35.0, x2: 223.5, y2: 35.0, paint: false, sw: 2.4 },
      { id: "l18", t: "line", x1: 242.7, y1: 54.8, x2: 234.9, y2: 62.6, paint: false, sw: 2.4 },
      { id: "l19", t: "line", x1: 262.5, y1: 63.0, x2: 262.5, y2: 74.0, paint: false, sw: 2.4 },
      { id: "l20", t: "line", x1: 282.3, y1: 54.8, x2: 290.1, y2: 62.6, paint: false, sw: 2.4 },
    ],
  },
  draw_shark: {
    label: "the shark",
    w: 320, h: 225,
    parts: [
      { id: "p0", t: "path", d: "M57.5 107.5 C97.5 67.5 167.5 60.0 217.5 82.5 C230.0 87.5 242.5 90.0 252.5 89.0 L252.5 89.0 C242.5 107.5 242.5 122.5 252.5 140.0 C230.0 145.0 205.0 144.0 185.0 139.0 C135.0 145.0 85.0 132.5 57.5 107.5 Z", paint: true, sw: 3.2 },
      { id: "p1", t: "path", d: "M251.0 89.0 L286.0 54.0 L280.0 115.0 L286.0 170.0 L251.0 140.0", paint: true, sw: 3.2 },
      { id: "p2", t: "path", d: "M142.5 65.0 L160.0 22.5 L186.0 70.0", paint: true, sw: 3 },
      { id: "p3", t: "path", d: "M127.5 136.0 L117.5 172.5 L160.0 142.0", paint: true, sw: 3 },
      { id: "p4", t: "path", d: "M67.5 119.0 C92.5 132.0 117.5 131.0 135.0 124.0", paint: false, sw: 2.6 },
      { id: "c5", t: "circle", cx: 102.5, cy: 91.0, r: 7.5, paint: false, sw: 2.6 },
      { id: "p6", t: "path", d: "M152.5 89.0 C148.5 100.0 148.5 110.0 152.5 119.0", paint: false, sw: 2.2 },
      { id: "p7", t: "path", d: "M163.5 89.0 C159.5 100.0 159.5 110.0 163.5 119.0", paint: false, sw: 2.2 },
      { id: "p8", t: "path", d: "M174.5 89.0 C170.5 100.0 170.5 110.0 174.5 119.0", paint: false, sw: 2.2 },
      { id: "c9", t: "circle", cx: 57.5, cy: 47.5, r: 8.5, paint: false, sw: 2.2 },
      { id: "c10", t: "circle", cx: 40.0, cy: 25.0, r: 5.5, paint: false, sw: 2.2 },
      { id: "c11", t: "circle", cx: 77.5, cy: 22.5, r: 4.0, paint: false, sw: 2.2 },
      { id: "p12", t: "path", d: "M22.5 194.0 C36.5 186.0 63.5 202.0 77.5 194.0 C91.5 186.0 118.5 202.0 132.5 194.0 C146.5 186.0 173.5 202.0 187.5 194.0 C201.5 186.0 228.5 202.0 242.5 194.0 C256.5 186.0 283.5 202.0 297.5 194.0", paint: false, sw: 2.6 },
      { id: "p13", t: "path", d: "M22.5 205.0 C36.5 197.0 63.5 213.0 77.5 205.0 C91.5 197.0 118.5 213.0 132.5 205.0 C146.5 197.0 173.5 213.0 187.5 205.0 C201.5 197.0 228.5 213.0 242.5 205.0 C256.5 197.0 283.5 213.0 297.5 205.0", paint: false, sw: 2.6 },
    ],
  },
  draw_race_car: {
    label: "the race car",
    w: 320, h: 225,
    parts: [
      { id: "p0", t: "path", d: "M35.0 147.5 L67.5 147.5 C77.5 122.5 105.0 115.0 127.5 114.0 L165.0 76.0 L217.5 76.0 L236.0 115.0 C260.0 117.0 277.5 127.5 284.0 147.5 L284.0 147.5 L35.0 147.5 Z", paint: true, sw: 3.2 },
      { id: "p1", t: "path", d: "M171.0 82.0 L211.0 82.0 L224.0 108.0 L152.5 108.0 Z", paint: true, sw: 2.6 },
      { id: "p2", t: "path", d: "M252.5 76.0 L297.5 76.0 L297.5 87.0 L252.5 87.0 Z", paint: true, sw: 3 },
      { id: "l3", t: "line", x1: 275.0, y1: 87.0, x2: 275.0, y2: 115.0, paint: false, sw: 2.6 },
      { id: "c4", t: "circle", cx: 95.0, cy: 160.0, r: 31.0, paint: true, sw: 3.2 },
      { id: "c5", t: "circle", cx: 95.0, cy: 160.0, r: 13.0, paint: true, sw: 2.4 },
      { id: "c6", t: "circle", cx: 227.5, cy: 160.0, r: 31.0, paint: true, sw: 3.2 },
      { id: "c7", t: "circle", cx: 227.5, cy: 160.0, r: 13.0, paint: true, sw: 2.4 },
      { id: "c8", t: "circle", cx: 131.0, cy: 129.0, r: 16.0, paint: true, sw: 2.6 },
      { id: "l9", t: "line", x1: 22.5, y1: 194.0, x2: 297.5, y2: 194.0, paint: false, sw: 3 },
      { id: "l10", t: "line", x1: 22.5, y1: 47.5, x2: 67.5, y2: 47.5, paint: false, sw: 2.2 },
      { id: "l11", t: "line", x1: 37.5, y1: 33.5, x2: 82.5, y2: 33.5, paint: false, sw: 2.2 },
      { id: "l12", t: "line", x1: 22.5, y1: 19.5, x2: 67.5, y2: 19.5, paint: false, sw: 2.2 },
      { id: "l13", t: "line", x1: 37.5, y1: 47.5, x2: 82.5, y2: 47.5, paint: false, sw: 2.2 },
      { id: "l14", t: "line", x1: 22.5, y1: 33.5, x2: 67.5, y2: 33.5, paint: false, sw: 2.2 },
      { id: "l15", t: "line", x1: 37.5, y1: 19.5, x2: 82.5, y2: 19.5, paint: false, sw: 2.2 },
    ],
  },
  draw_castle: {
    label: "the castle",
    w: 320, h: 225,
    parts: [
      { id: "p0", t: "path", d: "M37.5 172.5 L37.5 60.0 L90.0 60.0 L90.0 172.5", paint: true, sw: 3 },
      { id: "p1", t: "path", d: "M37.5 60.0 L37.5 46.0 L45.0 46.0 L45.0 60.0", paint: true, sw: 2.6 },
      { id: "p2", t: "path", d: "M52.5 60.0 L52.5 46.0 L60.0 46.0 L60.0 60.0", paint: true, sw: 2.6 },
      { id: "p3", t: "path", d: "M67.5 60.0 L67.5 46.0 L75.0 46.0 L75.0 60.0", paint: true, sw: 2.6 },
      { id: "p4", t: "path", d: "M82.5 60.0 L82.5 46.0 L90.0 46.0 L90.0 60.0", paint: true, sw: 2.6 },
      { id: "p5", t: "path", d: "M230.0 172.5 L230.0 60.0 L282.5 60.0 L282.5 172.5", paint: true, sw: 3 },
      { id: "p6", t: "path", d: "M230.0 60.0 L230.0 46.0 L237.5 46.0 L237.5 60.0", paint: true, sw: 2.6 },
      { id: "p7", t: "path", d: "M245.0 60.0 L245.0 46.0 L252.5 46.0 L252.5 60.0", paint: true, sw: 2.6 },
      { id: "p8", t: "path", d: "M260.0 60.0 L260.0 46.0 L267.5 46.0 L267.5 60.0", paint: true, sw: 2.6 },
      { id: "p9", t: "path", d: "M275.0 60.0 L275.0 46.0 L282.5 46.0 L282.5 60.0", paint: true, sw: 2.6 },
      { id: "p10", t: "path", d: "M127.5 172.5 L127.5 32.5 L192.5 32.5 L192.5 172.5", paint: true, sw: 3 },
      { id: "p11", t: "path", d: "M127.5 32.5 L127.5 18.5 L136.8 18.5 L136.8 32.5", paint: true, sw: 2.6 },
      { id: "p12", t: "path", d: "M146.1 32.5 L146.1 18.5 L155.4 18.5 L155.4 32.5", paint: true, sw: 2.6 },
      { id: "p13", t: "path", d: "M164.6 32.5 L164.6 18.5 L173.9 18.5 L173.9 32.5", paint: true, sw: 2.6 },
      { id: "p14", t: "path", d: "M183.2 32.5 L183.2 18.5 L192.5 18.5 L192.5 32.5", paint: true, sw: 2.6 },
      { id: "p15", t: "path", d: "M90.0 172.5 L90.0 87.5 L230.0 87.5 L230.0 172.5", paint: false, sw: 3 },
      { id: "p16", t: "path", d: "M90.0 87.5 L90.0 75.0 L104.0 75.0 L104.0 87.5", paint: true, sw: 2.4 },
      { id: "p17", t: "path", d: "M118.0 87.5 L118.0 75.0 L132.0 75.0 L132.0 87.5", paint: true, sw: 2.4 },
      { id: "p18", t: "path", d: "M146.0 87.5 L146.0 75.0 L160.0 75.0 L160.0 87.5", paint: true, sw: 2.4 },
      { id: "p19", t: "path", d: "M174.0 87.5 L174.0 75.0 L188.0 75.0 L188.0 87.5", paint: true, sw: 2.4 },
      { id: "p20", t: "path", d: "M202.0 87.5 L202.0 75.0 L216.0 75.0 L216.0 87.5", paint: true, sw: 2.4 },
      { id: "p21", t: "path", d: "M139.0 172.5 L139.0 122.5 C139.0 94.0 181.0 94.0 181.0 122.5 L181.0 172.5", paint: false, sw: 3 },
      { id: "l22", t: "line", x1: 160.0, y1: 172.5, x2: 160.0, y2: 102.5, paint: false, sw: 2.2 },
      { id: "l23", t: "line", x1: 139.0, y1: 157.5, x2: 181.0, y2: 157.5, paint: false, sw: 2 },
      { id: "l24", t: "line", x1: 139.0, y1: 136.5, x2: 181.0, y2: 136.5, paint: false, sw: 2 },
      { id: "l25", t: "line", x1: 139.0, y1: 115.5, x2: 181.0, y2: 115.5, paint: false, sw: 2 },
      { id: "p26", t: "path", d: "M55.0 110.0 L55.0 89.0 C55.0 77.5 72.5 77.5 72.5 89.0 L72.5 110.0 Z", paint: true, sw: 2.4 },
      { id: "p27", t: "path", d: "M247.5 110.0 L247.5 89.0 C247.5 77.5 265.0 77.5 265.0 89.0 L265.0 110.0 Z", paint: true, sw: 2.4 },
      { id: "l28", t: "line", x1: 63.7, y1: 46.0, x2: 63.7, y2: 15.0, paint: false, sw: 2.6 },
      { id: "p29", t: "path", d: "M63.7 15.0 L94.8 23.0 L63.7 31.0 Z", paint: true, sw: 2.6 },
      { id: "l30", t: "line", x1: 256.2, y1: 46.0, x2: 256.2, y2: 15.0, paint: false, sw: 2.6 },
      { id: "p31", t: "path", d: "M256.2 15.0 L287.2 23.0 L256.2 31.0 Z", paint: true, sw: 2.6 },
      { id: "l32", t: "line", x1: 160.0, y1: 18.5, x2: 160.0, y2: -12.5, paint: false, sw: 2.6 },
      { id: "p33", t: "path", d: "M160.0 -12.5 L191.0 -4.5 L160.0 3.5 Z", paint: true, sw: 2.6 },
      { id: "l34", t: "line", x1: 22.5, y1: 172.5, x2: 297.5, y2: 172.5, paint: false, sw: 3 },
    ],
  },
};

export const STICKERS: Sticker[] = [
  { id: "unicorn", label: "Unicorn", shapes: [
    { d: "M12 30 C6 26 6 16 13 12 C17 6 27 6 31 12 C35 17 33 25 27 29 C22 32 16 33 12 30 Z", fill: "#fff0f7" },
    { d: "M20 11 L23 1 L26 12 Z", fill: "#fbbf24" },
    { d: "M13 12 C8 10 5 14 6 19 C7 23 10 25 13 25 C10 20 10 15 13 12 Z", fill: "#ff4d9d" },
    { d: "M17 9 C13 6 9 7 7 10 C11 10 14 11 16 13 Z", fill: "#8b5cf6" },
    { d: "M26 17 m -2 0 a 2 2 0 1 0 4 0 a 2 2 0 1 0 -4 0", fill: "#2b2420" },
  ] },
  { id: "star", label: "Star", shapes: [
    { d: "M20.0 3.0 L24.4 13.9 L36.2 14.7 L27.1 22.3 L30.0 33.8 L20.0 27.5 L10.0 33.8 L12.9 22.3 L3.8 14.7 L15.6 13.9 Z", fill: "#fbbf24" },
    { d: "M20.0 12.0 L21.8 16.5 L26.7 16.8 L22.9 20.0 L24.1 24.7 L20.0 22.1 L15.9 24.7 L17.1 20.0 L13.3 16.8 L18.2 16.5 Z", fill: "#fff7dc" },
  ] },
  { id: "rainbow", label: "Rainbow", shapes: [
    { d: "M3 33 A17 17 0 0 1 37 33 L31 33 A11 11 0 0 0 9 33 Z", fill: "#ff4d9d" },
    { d: "M9 33 A11 11 0 0 1 31 33 L25 33 A5 5 0 0 0 15 33 Z", fill: "#fbbf24" },
    { d: "M15 33 A5 5 0 0 1 25 33 Z", fill: "#22d3ee" },
  ] },
  { id: "heart", label: "Heart", shapes: [
    { d: "M20 34 C6 24 4 15 10 10 C15 6 20 10 20 13 C20 10 25 6 30 10 C36 15 34 24 20 34 Z", fill: "#ff4d9d" },
  ] },
  { id: "flower", label: "Flower", shapes: [
    { d: "M20 4 m -6 0 a 6 7 0 1 0 12 0 a 6 7 0 1 0 -12 0", fill: "#a3e635" },
    { d: "M20 20 m 0.0 -7.5 a 7 8 0 1 0 0.1 0 Z", fill: "#8b5cf6" },
    { d: "M20 20 m 7.1 -2.3 a 7 8 0 1 0 0.1 0 Z", fill: "#8b5cf6" },
    { d: "M20 20 m 4.4 6.1 a 7 8 0 1 0 0.1 0 Z", fill: "#8b5cf6" },
    { d: "M20 20 m -4.4 6.1 a 7 8 0 1 0 0.1 0 Z", fill: "#8b5cf6" },
    { d: "M20 20 m -7.1 -2.3 a 7 8 0 1 0 0.1 0 Z", fill: "#8b5cf6" },
    { d: "M20 20 m -6 0 a 6 6 0 1 0 12 0 a 6 6 0 1 0 -12 0", fill: "#fbbf24" },
  ] },
  { id: "cloud", label: "Cloud", shapes: [
    { d: "M10 27 a 7 7 0 0 1 0 -14 a 9 9 0 0 1 17 -2 a 8 8 0 0 1 3 16 Z", fill: "#e0f2fe" },
  ] },
];

/** Crayon box. Two rows of six on a phone. Named because a swatch that only
 *  announces "use this colour" is useless to a child using a screen reader. */
export const PAINT_COLORS: { hex: string; name: string }[] = [
  { hex: "#ff4d9d", name: "Pink" },
  { hex: "#ef4444", name: "Red" },
  { hex: "#fb923c", name: "Orange" },
  { hex: "#fbbf24", name: "Yellow" },
  { hex: "#a3e635", name: "Lime" },
  { hex: "#22c55e", name: "Green" },
  { hex: "#22d3ee", name: "Sky blue" },
  { hex: "#3b82f6", name: "Blue" },
  { hex: "#8b5cf6", name: "Purple" },
  { hex: "#f472b6", name: "Rose" },
  { hex: "#8b5a2b", name: "Brown" },
  { hex: "#111827", name: "Black" },
];
