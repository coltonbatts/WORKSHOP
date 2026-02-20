# ColorWizard v1 Scope

This document defines the complete feature set for ColorWizard Desktop v1.

Features listed as **Included** will be built. Features listed as **Excluded** will not be built, regardless of demand.

## Included

### Color wheel

- Interactive HSL/HSV color wheel
- Click to select colors
- Visual display of selected color
- Numerical color values (RGB, HSL, hex)

### Color mixing

- Mix two colors visually
- Show result of mixing
- Adjust mixing ratio
- Display mixing formula

### Palette creation

- Create named palettes
- Add/remove colors from palette
- Reorder colors within palette
- Save palettes locally
- Load saved palettes
- Export palettes as JSON, plain text, or hex list

### Color harmony

- Show complementary color
- Show analogous colors
- Show triadic harmony
- Show split-complementary harmony
- Visual display on color wheel

### Reference library

- Store color swatches with notes
- Tag colors for organization
- Search by name or tag
- All data stored locally

### Export

- Export palette as JSON
- Export palette as plain text
- Export palette as hex code list
- Export color wheel snapshot as image

## Excluded

These features will not be built for v1:

- Photo import or editing
- Eyedropper tool for screen colors
- Color blindness simulation
- Gradient generation
- Pattern creation
- Image color extraction
- Cloud sync or backup
- Sharing or collaboration features
- Plugin system
- Custom color models beyond RGB/HSL/HSV
- Animation or timeline features
- Print preview or CMYK conversion
- Integration with other design tools
- Mobile or web versions

## Future versions

There is no roadmap for v2. This is the complete tool.

If v2 happens, it will be defined after v1 is finished, used, and evaluated.

## File format

Palettes are stored as human-readable JSON with this structure:

```json
{
  "name": "Palette Name",
  "colors": [
    {"hex": "#FF5733", "name": "Optional color name"},
    {"hex": "#33FF57", "name": "Optional color name"}
  ],
  "created": "2026-02-03",
  "modified": "2026-02-03"
}
```

Reference library entries are stored similarly.

## Definition of done

v1 is complete when:

- All included features work offline
- Documentation is written
- File formats are documented
- No known critical bugs remain
- The tool can be used daily without friction

v1 is a finished product, not a beta.
