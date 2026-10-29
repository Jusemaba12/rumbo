// Descarga una página de oferta y la convierte en texto plano.
// Funciona con portales públicos (Greenhouse, Lever, Get on Board…);
// LinkedIn e Indeed exigen sesión y devuelven poco o nada.

const MAX_CHARS = 30_000;

/** Evita que la función pida direcciones internas. */
export function isPublicHttpUrl(raw: string): boolean {
  let url: URL;
  try {
    url = new URL(raw);
  } catch {
    return false;
  }
  if (url.protocol !== "https:" && url.protocol !== "http:") return false;
  const host = url.hostname.toLowerCase();
  if (!host.includes(".") || host.endsWith(".local")) return false;
  return !/^(127\.|10\.|192\.168\.|169\.254\.|172\.(1[6-9]|2\d|3[01])\.|0\.|\[)/
    .test(host);
}

export async function fetchPageText(url: string): Promise<string | null> {
  if (!isPublicHttpUrl(url)) return null;
  try {
    const response = await fetch(url, {
      headers: {
        "User-Agent": "Mozilla/5.0 (compatible; Rumbo/1.0)",
        "Accept-Language": "es,en;q=0.8",
      },
      redirect: "follow",
      signal: AbortSignal.timeout(10_000),
    });
    if (!response.ok) return null;
    return htmlToText(await response.text()).slice(0, MAX_CHARS);
  } catch {
    return null;
  }
}

export function htmlToText(html: string): string {
  // Muchos portales incluyen la oferta como JSON-LD (schema.org JobPosting).
  const jsonLd = [
    ...html.matchAll(
      /<script[^>]*type=["']application\/ld\+json["'][^>]*>([\s\S]*?)<\/script>/gi,
    ),
  ]
    .map((match) => match[1])
    .filter((block) => block.includes("JobPosting"))
    .join("\n");

  const body = html
    .replace(/<(script|style|noscript|svg)[\s\S]*?<\/\1>/gi, " ")
    .replace(/<(br|\/p|\/li|\/h\d|\/div)[^>]*>/gi, "\n")
    .replace(/<[^>]+>/g, " ");

  return decodeEntities(`${jsonLd}\n${body}`)
    .replace(/[ \t]+/g, " ")
    .replace(/\n\s*\n+/g, "\n")
    .trim();
}

export function decodeEntities(text: string): string {
  const named: Record<string, string> = {
    amp: "&",
    lt: "<",
    gt: ">",
    quot: '"',
    apos: "'",
    nbsp: " ",
  };
  return text.replace(/&(#x?[0-9a-f]+|\w+);/gi, (entity, code: string) => {
    if (code.startsWith("#x") || code.startsWith("#X")) {
      return String.fromCodePoint(parseInt(code.slice(2), 16));
    }
    if (code.startsWith("#")) {
      return String.fromCodePoint(parseInt(code.slice(1), 10));
    }
    return named[code.toLowerCase()] ?? entity;
  });
}
