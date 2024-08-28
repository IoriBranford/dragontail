# Polygonal bounds

## Ver 0

Init bounds from polygon:

- Determine inside/outside of polygon edges
  - Left is outside if polygon points are given clockwise (signed polygon area is positive)
  - Right is outside otherwise

Get out-of-bounds vector of circle:

- OOB = (0, 0)
- For each bounds edge
  - If circle touches edge
      - Add vector to OOB pushing circle back inside
- Return OOB

Does circle touch bounds edge:

- Return if the circle center's distance from the projection on the edge is <= the circle radius