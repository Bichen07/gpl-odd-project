import { NextRequest, NextResponse } from "next/server";

/**
 * Same-origin proxy for Payload document files (saved trajectory-analysis zips).
 *
 * The browser cannot always reach the Payload host directly — it may be on a
 * different network than the client, or the Payload file endpoint may not send
 * CORS headers for the dashboard origin. The Next.js server, however, can reach
 * Payload, so we stream the file through here (same origin → no CORS, works from
 * any client that can reach the dashboard).
 *
 * To avoid acting as an open proxy / SSRF, only the configured Payload host
 * (NEXT_PUBLIC_PAYLOAD_API_ADDRESS) is allowed.
 */
export async function GET(req: NextRequest) {
  const target = new URL(req.url).searchParams.get("url");
  if (!target) {
    return NextResponse.json({ error: "url query param required" }, { status: 400 });
  }

  const base = process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS ?? "";
  let allowedHost = "";
  try {
    allowedHost = new URL(base).host;
  } catch {
    return NextResponse.json(
      { error: "server misconfigured: NEXT_PUBLIC_PAYLOAD_API_ADDRESS invalid" },
      { status: 500 },
    );
  }

  let targetHost = "";
  try {
    targetHost = new URL(target).host;
  } catch {
    return NextResponse.json({ error: "invalid target url" }, { status: 400 });
  }
  if (targetHost !== allowedHost) {
    return NextResponse.json(
      { error: `host not allowed (only ${allowedHost})` },
      { status: 403 },
    );
  }

  try {
    const upstream = await fetch(target, { cache: "no-store" });
    if (!upstream.ok) {
      return NextResponse.json(
        { error: `upstream responded ${upstream.status}` },
        { status: 502 },
      );
    }
    const buf = await upstream.arrayBuffer();
    const contentType =
      upstream.headers.get("content-type") ?? "application/octet-stream";
    return new NextResponse(buf, {
      headers: { "Content-Type": contentType, "Cache-Control": "no-store" },
    });
  } catch (err) {
    return NextResponse.json(
      { error: `failed to fetch upstream: ${String(err)}` },
      { status: 502 },
    );
  }
}
