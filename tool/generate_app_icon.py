#!/usr/bin/env python3
"""Generate app icons: web (PWA), macOS AppIcon.appiconset, Windows .ico.

Run: python3 tool/generate_app_icon.py
"""

from __future__ import annotations

import sys
from pathlib import Path

try:
    from PIL import Image, ImageDraw
except ImportError:
    import subprocess

    subprocess.check_call([sys.executable, "-m", "pip", "install", "pillow", "-q"])
    from PIL import Image, ImageDraw


def lerp(a: float, b: float, t: float) -> float:
    return a + (b - a) * t


def draw_vertical_gradient(img: Image.Image, top: tuple[int, int, int], bottom: tuple[int, int, int]) -> None:
    px = img.load()
    w, h = img.size
    for y in range(h):
        t = y / max(h - 1, 1)
        r = int(lerp(top[0], bottom[0], t))
        g = int(lerp(top[1], bottom[1], t))
        b = int(lerp(top[2], bottom[2], t))
        for x in range(w):
            px[x, y] = (r, g, b)


def draw_phone_icon(sz: int, draw: ImageDraw.ImageDraw) -> None:
    """Draw phone at size sz×sz (RGB draw target already has gradient)."""
    cx, cy = sz // 2, sz // 2
    ph = int(sz * 0.60)
    pw = int(ph * 0.50)
    x0 = cx - pw // 2
    y0 = cy - ph // 2
    x1 = x0 + pw
    y1 = y0 + ph
    outer_r = max(12, int(pw * 0.14))
    stroke_outer = max(8, sz // 95)
    bezel = max(10, int(pw * 0.065))
    inner_r = max(8, outer_r - bezel // 2)
    ix0, iy0 = x0 + bezel, y0 + bezel
    ix1, iy1 = x1 - bezel, y1 - bezel

    frame = (235, 240, 252)
    frame_soft = (200, 210, 235)
    dark = (12, 14, 28)

    # Side buttons (left)
    gap = max(3, stroke_outer // 3)
    bx = x0 - gap - max(5, int(pw * 0.045))
    bw = max(4, int(pw * 0.055))
    mute_h = int(ph * 0.055)
    draw.rounded_rectangle(
        [bx, y0 + int(ph * 0.16), bx + bw, y0 + int(ph * 0.16) + mute_h],
        radius=bw // 2,
        fill=frame,
        outline=frame_soft,
        width=1,
    )
    vh = int(ph * 0.11)
    yv1 = y0 + int(ph * 0.26)
    draw.rounded_rectangle([bx, yv1, bx + bw, yv1 + vh], radius=bw // 2, fill=frame, outline=frame_soft, width=1)
    yv2 = yv1 + vh + int(ph * 0.028)
    draw.rounded_rectangle([bx, yv2, bx + bw, yv2 + vh], radius=bw // 2, fill=frame, outline=frame_soft, width=1)

    # Power (right)
    rx = x1 + gap
    ph_btn = int(ph * 0.16)
    draw.rounded_rectangle(
        [rx, cy - ph_btn // 2, rx + bw, cy + ph_btn // 2],
        radius=bw // 2,
        fill=frame,
        outline=frame_soft,
        width=1,
    )

    # Outer chassis
    draw.rounded_rectangle(
        [x0, y0, x1, y1],
        radius=outer_r,
        outline=frame,
        width=stroke_outer,
    )

    # Inner screen / glass edge
    stroke_inner = max(3, sz // 220)
    draw.rounded_rectangle(
        [ix0, iy0, ix1, iy1],
        radius=inner_r,
        outline=frame_soft,
        width=stroke_inner,
    )

    # Dynamic Island
    iw = int((ix1 - ix0) * 0.42)
    ih = max(10, int((ix1 - ix0) * 0.12))
    icx = (ix0 + ix1) // 2
    top_pad = int((iy1 - iy0) * 0.045)
    iy_island = iy0 + top_pad
    draw.rounded_rectangle(
        [icx - iw // 2, iy_island, icx + iw // 2, iy_island + ih],
        radius=ih // 2,
        fill=dark,
        outline=dark,
        width=1,
    )

    # Front camera lens (dot)
    lens_r = max(3, sz // 220)
    lx = icx + iw // 2 + int(iw * 0.22)
    ly = iy_island + ih // 2
    draw.ellipse([lx - lens_r, ly - lens_r, lx + lens_r, ly + lens_r], fill=frame_soft, outline=frame, width=1)

    # Earpiece slit
    slit_w = int((ix1 - ix0) * 0.14)
    slit_h = max(2, sz // 400)
    sx = icx - iw // 2 - int(iw * 0.35) - slit_w
    sy = iy_island + ih // 2 - slit_h // 2
    draw.rounded_rectangle([sx, sy, sx + slit_w, sy + slit_h], radius=slit_h, fill=frame_soft)

    # Bottom home indicator
    ind_w = int((ix1 - ix0) * 0.26)
    ind_h = max(4, sz // 256)
    ind_y = iy1 - int((iy1 - iy0) * 0.065)
    draw.rounded_rectangle(
        [icx - ind_w // 2, ind_y, icx + ind_w // 2, ind_y + ind_h],
        radius=ind_h // 2,
        fill=frame,
        outline=frame_soft,
        width=1,
    )


def apply_icon_rounded_mask(rgba: Image.Image, size: int, radius_ratio: float = 0.30) -> None:
    """Large rounded-rect mask (Flutter-style “bubble” plate). Transparent outside."""
    r = int(size * radius_ratio)
    mask = Image.new("L", (size, size), 0)
    mdraw = ImageDraw.Draw(mask)
    mdraw.rounded_rectangle([0, 0, size - 1, size - 1], radius=r, fill=255)
    rgba.putalpha(mask)


def export_macos_app_icons(icon_rgba: Image.Image, appiconset: Path) -> None:
    """Write PNGs (with alpha) for macOS Runner AppIcon.appiconset/Contents.json."""
    appiconset.mkdir(parents=True, exist_ok=True)
    mapping = [
        ("app_icon_16.png", 16),
        ("app_icon_32.png", 32),
        ("app_icon_64.png", 64),
        ("app_icon_128.png", 128),
        ("app_icon_256.png", 256),
        ("app_icon_512.png", 512),
        ("app_icon_1024.png", 1024),
    ]
    for name, dim in mapping:
        icon_rgba.resize((dim, dim), Image.Resampling.LANCZOS).save(
            appiconset / name, optimize=True
        )


def export_windows_ico(icon_rgba: Image.Image, ico_path: Path) -> None:
    """Multi-size .ico with transparency (windows/runner/resources)."""
    ico_path.parent.mkdir(parents=True, exist_ok=True)
    dims = [256, 128, 64, 48, 32, 16]
    imgs = [icon_rgba.resize((d, d), Image.Resampling.LANCZOS) for d in dims]
    imgs[0].save(ico_path, format="ICO", append_images=imgs[1:])


def export_maskable_padded(icon_rgba: Image.Image, size: int) -> Image.Image:
    """Scale to ~78% safe zone; outer margin fully transparent."""
    inner = int(size * 0.78)
    pad = (size - inner) // 2
    small = icon_rgba.resize((inner, inner), Image.Resampling.LANCZOS)
    out = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    out.paste(small, (pad, pad), small)
    return out


def main() -> None:
    root = Path(__file__).resolve().parents[1]
    out_size = 1024
    render_size = 1536
    out_source = root / "assets" / "branding" / "app_icon_source.png"
    out_source.parent.mkdir(parents=True, exist_ok=True)

    top_rgb = (26, 26, 46)
    bot_rgb = (74, 108, 247)

    big = Image.new("RGB", (render_size, render_size))
    draw_vertical_gradient(big, top_rgb, bot_rgb)
    draw = ImageDraw.Draw(big)
    draw_phone_icon(render_size, draw)

    img = big.resize((out_size, out_size), Image.Resampling.LANCZOS)
    rgba = img.convert("RGBA")
    apply_icon_rounded_mask(rgba, out_size)

    rgba.save(out_source, format="PNG", optimize=True)
    print(f"Wrote {out_source}")

    web = root / "web"
    icons = web / "icons"
    icons.mkdir(parents=True, exist_ok=True)

    rgba.resize((48, 48), Image.Resampling.LANCZOS).save(web / "favicon.png", optimize=True)
    rgba.resize((192, 192), Image.Resampling.LANCZOS).save(icons / "Icon-192.png", optimize=True)
    rgba.resize((512, 512), Image.Resampling.LANCZOS).save(icons / "Icon-512.png", optimize=True)
    export_maskable_padded(rgba, 192).save(icons / "Icon-maskable-192.png", optimize=True)
    export_maskable_padded(rgba, 512).save(icons / "Icon-maskable-512.png", optimize=True)
    print(f"Wrote {web}/favicon.png and {icons}/Icon-*.png (transparent corners)")

    mac_icon = root / "macos" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset"
    export_macos_app_icons(rgba, mac_icon)
    print(f"Wrote {mac_icon}/app_icon_*.png")

    win_ico = root / "windows" / "runner" / "resources" / "app_icon.ico"
    export_windows_ico(rgba, win_ico)
    print(f"Wrote {win_ico}")


if __name__ == "__main__":
    main()
