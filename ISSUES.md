# Open issues & directions to verify

Only **unresolved** problems and **decisions still to make**. Explained behaviour and fixes already documented in `README.md` are **not** duplicated here.

---

## 1. New simulations: batch `samplingUrl` is often `null`

Simulator workers expect the batch record to point at a running sampling server. If `samplingUrl` is empty, the search loop may not get suggestions.

**Direction:** Set `samplingUrl` in Payload Admin before Goal B, or confirm with senior how lab machines configure this.

---

## 2. Goal B blocked without ITRI `sdc-docker` image

Running new simulations needs the lab Docker/ROS stack and image access.

**Direction:** Obtain image / machine access from supervisor.

---

## 3. BEV map still differs from paper / website

Lane boundaries were added; dashed centre markings, junction polish, or wrong `.xodr` variant (`hct_6` vs `hct_6_no_930`) may still explain gaps.

**Direction:** Compare renders using `hct_6_no_930.xodr` from Payload; decide if renderer should draw lane marking types from OpenDRIVE.

---

## 4. `alldatasets/` source of truth

Large exports are gitignored; no single documented shared location.

**Direction:** NAS/shared path or “export from Payload Documents” workflow owned by the lab.

---

## 5. Dashboard “Analysis” sends a very large task grid

`app/dashboard/.../Saves/index.tsx` builds **many** `hdbscan+mfpca` tasks (nested loops over min cluster size, min samples, epsilon, …). One POST can run for a long time or hit browser/proxy timeouts while the UI looks idle.

**Direction:** Confirm with senior whether the full grid is intentional; consider fewer tasks for dev, progress UI, or server-side chunking.

---

## 6. Cluster colours require manual selection

`redux/slices/batch.ts` has auto-select of the first clustering result **commented out** (`selectFirst`), so scatter plots stay black until the user clicks a clustering row.

**Direction:** Product decision — uncomment / restore auto-select vs keep explicit choice.

---

## 7. Analyzer: port already in use (`Errno 98`)

Starting `litestar run --port 9010` twice leaves the first process owning the port; the second exits with **Address already in use**. Only one analyzer should run on 9010.

**Direction:** Operational — see `README.md` § Debugging → port conflict.

---

## 8. Analyzer vs Dashboard Payload URL mismatch

Analyzer reads `PAYLOAD_API` from `app/analyzer/.env`. Dashboard reads `NEXT_PUBLIC_PAYLOAD_API_ADDRESS` from `app/dashboard/.env`. If one points at `localhost:3020` and the other at the lab IP, they operate on **different** databases.

**Direction:** Align both to the same Payload base URL when debugging “empty trials” or failed analysis.

---

## Open questions

| Topic | Owner |
|---|---|
| `sdc-docker` image hosting | Supervisor |
| Shared `alldatasets/` location | Lab |
| Full clustering grid vs faster dev runs | Senior / code owner |
| LLM Phase 4: images + captions vs text-only | Research |
