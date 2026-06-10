---
name: typebot-routing-edges
description: Strict guidelines on visual coordinate layouts, edge connection routing, and group positioning on the canvas.
---

# Typebot Routing & Edges Manual

Use this skill to determine connections, branching routes, and coordinate grids for Typebot workflow design.

---

## 1. Graph Coordinate System (No Overlaps)
Typebot maps its groups and start events onto a 2D coordinate grid using `graphCoordinates: { "x": number, "y": number }`. 

### A. Start Event Position
The start event should always be set at origin or near it:
```json
"graphCoordinates": { "x": 0, "y": 0 }
```

### B. Group Spacing Rules
Never place groups on top of each other. Keep a clear grid spacing:
* **Horizontal Grid:** Shift the `x` coordinate by `+350` to `+450` units for sequential side-by-side groups.
* **Vertical Grid:** Shift the `y` coordinate by `+250` to `+350` units for flows progressing downwards.
* **Example Layout:**
  - Group 1 (Welcome): `{ "x": 200, "y": 0 }`
  - Group 2 (Capture Input): `{ "x": 600, "y": 0 }`
  - Group 3 (AI Processing): `{ "x": 600, "y": 300 }`
  - Group 4 (Goodbye): `{ "x": 1000, "y": 300 }`

---

## 2. Edge Schema Structure
Every routing line on the canvas is declared in the root `"edges"` array. Edges must match this schema:
```json
{
  "id": "edge-unique-cuid",
  "from": {
    "blockId": "source-block-id-cuid", // Required if branching from a block
    "itemId": "source-item-id-cuid",   // Required ONLY if branching from an item (choice, condition)
    "eventId": "source-event-id-cuid"  // Required ONLY if from an event (like start event)
  },
  "to": {
    "groupId": "target-group-id-cuid", // Required target group container
    "blockId": "target-block-id-cuid"  // Optional target block inside the group
  }
}
```

---

## 3. Connection Rules & Use Cases

### A. Event-to-Group (The Entry Link)
Connects the start event to the initial group.
* **Outgoing Field:** The start event itself must reference this edge in its `outgoingEdgeId` key.
* **Event schema:**
  ```json
  {
    "id": "event-start",
    "type": "start",
    "outgoingEdgeId": "edge-start-to-group1",
    "graphCoordinates": { "x": 0, "y": 0 }
  }
  ```
> [!CAUTION]
> **CRITICAL RULE:** Do not forget to actually define this edge in the root `"edges"` array! If you give the start event an `outgoingEdgeId` but fail to add the corresponding edge object to `"edges"`, the flow will crash.
> Ensure you add something like this to `"edges"`:
> `{"id": "edge-start-to-group1", "from": {"eventId": "event-start"}, "to": {"groupId": "grp-target"}}`

### B. Block-to-Group (Linear Next Steps)
When a block (like Text, Set Variable, or Text Input) automatically proceeds to the next group after displaying or capturing input.
* **Outgoing Field:** Put the `outgoingEdgeId` directly on the block object.
* **Example:**
  ```json
  {
    "id": "block-text-1",
    "type": "text",
    "outgoingEdgeId": "edge-linear-1",
    "content": { ... }
  }
  ```

### C. Item-to-Group (Conditional/Branching Paths)
When routing branches dynamically based on choice lists, condition blocks, split tests, or cards.
* **Outgoing Field:** Place the `outgoingEdgeId` on the specific *item* object inside the block's `items` array.
* **Parent Block:** The parent block itself should NOT have an `outgoingEdgeId` unless acting as a default fallback path.
* **Edge definition:** The `"from"` node in the edge must contain BOTH `blockId` and `itemId`.

---

## 4. Default Fallbacks (Catch-Alls)
If a block (e.g. Choice Input) has multiple buttons, but only one button has a custom route:
1. Put the custom route's `outgoingEdgeId` on that specific item.
2. Put a fallback `outgoingEdgeId` directly on the parent block object itself.
3. This creates a catch-all route that handles all other selections.
