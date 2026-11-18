#import "@preview/cetz:0.5.3"

// Editable A3 database diagram. Coordinates are in centimetres.
#let db-schema-triggers() = cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = rgb("#222222")
  let muted = rgb("#555555")
  let rule = 0.55pt
  let row-height = 0.49

  let label(x, y, value, size: 9pt, color: ink, font: "CM Super Typewriter 1200", anchor: "west") = {
    content((x, y), anchor: anchor, text(font: font, size: size, fill: color, value))
  }
  let entity(x, y, width, title, fields, note: none) = {
    let height = (fields.len() + 1) * row-height
    rect((x, y), (x + width, y + height), stroke: rule, fill: white)
    line((x, y + height - row-height), (x + width, y + height - row-height), stroke: rule)
    line((x + 0.72, y), (x + 0.72, y + height - row-height), stroke: rule)
    label(x + width / 2, y + height - row-height / 2, title,
      size: 10pt, font: "CM Super 1440", anchor: "center")
    for (i, field) in fields.enumerate() {
      let baseline = y + height - row-height * (i + 1.5)
      label(x + 0.35, baseline, field.at(0), size: 8.5pt, anchor: "center")
      label(x + 0.84, baseline, field.at(1))
    }
    if note != none {
      label(x + width / 2, y + height + 0.32, note,
        size: 7.5pt, color: muted, font: "CM Super 1440", anchor: "center")
    }
  }
  let relation(points, one, many, note: none, note-at: none) = {
    line(..points, stroke: rule)
    label(one.at(0), one.at(1), "1", size: 8pt, anchor: "center")
    label(many.at(0), many.at(1), "∞", size: 9pt, font: "CM Super 1440", anchor: "center")
    if note != none {
      label(note-at.at(0), note-at.at(1), note,
        size: 7pt, color: muted, font: "CM Super 1440", anchor: "center")
    }
  }
  let action(points, operation, at) = {
    line(..points, stroke: (paint: muted, thickness: 0.5pt, dash: "dashed"), mark: (end: ">", scale: 0.55))
    label(at.at(0), at.at(1), operation, size: 7pt, color: muted, anchor: "center")
  }

  // Foreign-key relationships are drawn first, below table frames.
  relation(((19.9, 16.55), (22.7, 16.55), (22.7, 18.9), (24.5, 18.9)),
    (24.15, 19.12), (20.25, 16.8), note: "15–20", note-at: (21.1, 16.2))
  relation(((14.1, 17.0), (13.6, 17.0), (13.6, 2.08), (14.1, 2.08)),
    (13.8, 17.2), (13.8, 2.3), note: "18–22", note-at: (13.35, 3.1))
  relation(((10.6, 17.4), (11.4, 17.4), (11.4, 4.15), (14.1, 4.15)),
    (13.8, 4.4), (10.9, 17.65), note: "2–5 языков на начертание", note-at: (11.5, 11.6))
  relation(((7.8, 16.1), (7.8, 10.44)),
    (7.5, 10.75), (8.1, 15.8), note: "33–45 символов на пару", note-at: (7.8, 13.0))
  relation(((3.9, 11.23), (4.45, 11.23), (4.45, 8.72), (5.1, 8.72)),
    (4.15, 11.45), (4.8, 8.95))
  relation(((3.9, 8.23), (4.7, 8.23), (4.7, 8.23), (5.1, 8.23)),
    (4.15, 8.45), (4.83, 8.45))
  relation(((19.9, 3.05), (21.0, 3.05), (21.0, 8.18), (20.3, 8.18)),
    (20.0, 8.4), (20.25, 3.3))
  relation(((19.9, 3.55), (30.5, 3.55), (30.5, 14.48), (28.8, 14.48)),
    (29.1, 14.7), (20.2, 3.8))
  relation(((19.9, 1.35), (30.8, 1.35), (30.8, 8.72), (30.0, 8.72)),
    (30.3, 8.94), (20.2, 1.6))
  relation(((30.0, 9.21), (32.1, 9.21)),
    (31.8, 9.42), (30.3, 9.42))

  // Trigger effects: dashed arrows distinguish updates from foreign keys.
  action(((17.0, 14.25), (17.0, 13.35)), "UPDATE", (16.45, 13.9))
  action(((18.5, 14.25), (19.5, 13.35)), "DELETE", (19.2, 13.9))
  action(((16.1, 8.45), (16.1, 10.9)), "INSERT", (15.55, 9.8))
  action(((17.6, 8.45), (18.0, 10.9)), "UPDATE", (18.45, 9.8))
  action(((19.0, 8.45), (20.0, 10.9)), "DELETE", (20.25, 9.8))
  action(((15.0, 15.18), (12.8, 13.6), (12.8, 4.55), (14.1, 4.55)),
    "UPDATE", (12.55, 12.0))
  action(((15.0, 14.66), (12.45, 13.6), (12.45, 4.08), (14.1, 4.08)),
    "DELETE", (12.15, 9.9))

  // Tables and annotations.
  entity(5.1, 16.1, 5.5, "Symbol", (
    ("PK", "id_Symbol"), ("", "Value"), ("", "Unicode_code"),
    ("FK", "id_Typeface"), ("FK", "id_Language"),
  ), note: "4; 2–5 и 33–45; 568476")
  entity(14.1, 16.3, 5.8, "Font_family", (
    ("PK", "id_Font_family"), ("", "Name"), ("", "Year_created"),
    ("", "Description"), ("", "Typeface_count"), ("FK", "id_Category"),
  ), note: "2; 15–20; 208")
  entity(24.5, 16.7, 5.5, "Category", (
    ("PK", "id_Category"), ("", "Name"), ("", "Description"),
    ("", "Icon"), ("", "Font_family_count"),
  ), note: "1; —; 12")
  entity(0.2, 10.5, 3.9, "Writing_direction", (
    ("PK", "id_Writing_dir."), ("", "Name"),
  ), note: "1; —; 2")
  entity(0.2, 7.5, 3.9, "Script_type", (
    ("PK", "id_Script_type"), ("", "Name"),
  ), note: "1; —; 3")
  entity(5.1, 7.5, 5.5, "Language", (
    ("PK", "id_Language"), ("", "Name"), ("", "ISO_code"),
    ("FK", "id_Writing_direction"), ("FK", "id_Script_type"),
  ), note: "2; —; 40")
  entity(14.0, 10.9, 7.4, "Typeface_format_weight_stats", (
    ("PK", "id_Font_family"), ("PK", "Typeface_name"),
    ("", "Format_count"), ("", "Weight_count"),
  ))
  entity(25.0, 13.5, 3.8, "Slope", (
    ("PK", "id_Slope"), ("", "Name"),
  ), note: "1; —; 3")
  entity(24.5, 7.5, 5.5, "Format", (
    ("PK", "id_Format"), ("", "Name"), ("FK", "id_Extension"),
    ("", "Year_released"), ("", "Description"), ("", "Web_support"),
  ), note: "2; —; 5")
  entity(32.1, 8.25, 3.9, "Extension", (
    ("PK", "id_Extension"), ("", "Name"),
  ), note: "1; —; 5")
  entity(20.3, 7.2, 3.9, "Weight", (
    ("PK", "id_Weight"), ("", "Name"),
  ), note: "1; —; 9")
  entity(14.1, 1.1, 5.8, "Typeface", (
    ("PK", "id_Typeface"), ("", "Name"), ("FK", "id_Weight"),
    ("FK", "id_Slope"), ("", "File_size"),
    ("FK", "id_Font_family"), ("FK", "id_Format"),
  ), note: "3; 18–22; 4148")

  rect((15.0, 14.25), (19.2, 16.0), radius: 0.1, stroke: rule, fill: white)
  label(15.2, 15.7, "triggers:", size: 7.6pt)
  label(15.2, 15.18, "font_family_updated", size: 7.6pt)
  label(15.2, 14.66, "font_family_deleted", size: 7.6pt)
  rect((14.7, 6.6), (19.5, 8.45), radius: 0.1, stroke: rule, fill: white)
  label(14.9, 8.2, "triggers:", size: 7.6pt)
  label(14.9, 7.77, "typeface_inserted", size: 7.6pt)
  label(14.9, 7.34, "typeface_updated", size: 7.6pt)
  label(14.9, 6.91, "typeface_deleted", size: 7.6pt)
})
