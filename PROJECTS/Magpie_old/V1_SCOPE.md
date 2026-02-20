# Magpie v1 Scope

This document defines the complete feature set for Magpie v1.

Features listed as **Included** will be built. Features listed as **Excluded** will not be built, regardless of demand.

## Included

### Pattern import

- Load image files (PNG, JPG, SVG)
- Basic image adjustments (brightness, contrast, crop)
- Resize and scale patterns
- Convert to simplified line art

### Stitch mapping

- Convert image to stitch grid
- Define stitch density
- Visual preview of stitch pattern
- Adjust stitch direction indicators

### Thread palette

- Create custom thread palettes
- Import DMC and Anchor floss libraries (offline data)
- Map colors to thread numbers
- Show thread name and number for each color

### Pattern management

- Save patterns locally
- Load saved patterns
- Add notes and metadata to patterns
- Organize patterns by project or category

### Stitch estimation

- Count total stitches
- Estimate thread length needed
- Display fabric dimensions
- Show time estimate based on user's stitch rate

### Export

- Export pattern as JSON
- Export pattern as SVG
- Export stitch guide as plain text
- Export thread list with quantities

### Reference

- Offline stitch type reference (backstitch, satin stitch, etc.)
- Simple visual diagrams for common stitches

## Excluded

These features will not be built for v1:

- Advanced photo editing or filters
- Machine embroidery format export (DST, PES, etc.)
- Automatic thread color matching from photos
- 3D preview or rendering
- Pattern marketplace or sharing
- Cloud sync or backup
- Collaboration features
- Video tutorials or animations
- Integration with embroidery machines
- Cross-stitch or counted thread specific features
- Mobile or web versions
- Pattern generation from AI or algorithms
- Fabric texture simulation

## Future versions

There is no roadmap for v2. This is the complete tool.

If v2 happens, it will be defined after v1 is finished, used, and evaluated.

## File format

Patterns are stored as human-readable JSON with this structure:

```json
{
  "name": "Pattern Name",
  "width": 100,
  "height": 100,
  "stitchGrid": [[...]],
  "threads": [
    {"id": "DMC-310", "name": "Black", "color": "#000000"}
  ],
  "created": "2026-02-03",
  "modified": "2026-02-03",
  "notes": "Optional notes"
}
```

Thread libraries are stored as static JSON files.

## Definition of done

v1 is complete when:

- All included features work offline
- Documentation is written
- File formats are documented
- Thread libraries (DMC, Anchor) are included
- No known critical bugs remain
- The tool can be used for real embroidery projects without friction

v1 is a finished product, not a beta.
