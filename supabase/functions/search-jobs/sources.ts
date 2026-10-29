// Conectores de portales con API pública. Cada uno devuelve ofertas
// normalizadas; si un portal falla, la búsqueda sigue con los demás.
import { decodeEntities, htmlToText } from "../_shared/page_text.ts";

export type WorkMode = "remote" | "hybrid" | "onsite";

export interface RawJob {
  source: string;
  externalId: string;
  url: string;
  title: string;
  company: string;
  location: string;
  workMode: WorkMode | null;
  description: string;
  tags: string[];
  salaryMin: number | null;
  salaryMax: number | null;
  salaryCurrency: string | null;
  publishedAt: Date | null;
}

export const SOURCES = [
  "getonboard",
  "remotive",
  "himalayas",
  "remoteok",
  "weworkremotely",
] as const;
export type SourceId = (typeof SOURCES)[number];

/** Algunos portales de empresa tienen cientos de ofertas y tardan más. */
const TIMEOUT_MS = 20_000;

async function fetchOk(url: string): Promise<Response> {
  const response = await fetch(url, {
    headers: { "User-Agent": "Rumbo/1.0 (uso personal)" },
    signal: AbortSignal.timeout(TIMEOUT_MS),
  });
  if (!response.ok) throw new Error(`${url} → ${response.status}`);
  return response;
}

async function getJson(url: string): Promise<unknown> {
  return (await fetchOk(url)).json();
}

const text = (value: unknown) => (typeof value === "string" ? value : "");
const num = (value: unknown) =>
  typeof value === "number" && Number.isFinite(value) && value > 0
    ? value
    : null;

// --- Get on Board (tecnología, LATAM) ---------------------------------------

// deno-lint-ignore no-explicit-any
export function fromGetOnBoard(item: any): RawJob {
  const a = item.attributes ?? {};
  const modality = text(a.remote_modality);
  const company = a.company?.data?.attributes?.name;
  return {
    source: "getonboard",
    externalId: text(item.id),
    url: `https://www.getonbrd.com/jobs/${item.id}`,
    title: text(a.title),
    company: text(company),
    location: (Array.isArray(a.countries) ? a.countries : []).join(", "),
    workMode: modality === "fully_remote" || modality === "remote_local"
      ? "remote"
      : modality === "hybrid"
      ? "hybrid"
      : modality === "no_remote"
      ? "onsite"
      : null,
    description: htmlToText(
      [a.description, a.functions, a.desirable].map(text).join("\n"),
    ),
    tags: [],
    salaryMin: num(a.min_salary),
    salaryMax: num(a.max_salary),
    salaryCurrency: num(a.min_salary) || num(a.max_salary) ? "USD" : null,
    publishedAt: typeof a.published_at === "number"
      ? new Date(a.published_at * 1000)
      : null,
  };
}

async function searchGetOnBoard(query: string): Promise<RawJob[]> {
  const url = "https://www.getonbrd.com/api/v0/search/jobs?per_page=30" +
    `&expand=${encodeURIComponent('["company"]')}` +
    `&query=${encodeURIComponent(query)}`;
  // deno-lint-ignore no-explicit-any
  const body = (await getJson(url)) as any;
  return (body.data ?? []).map(fromGetOnBoard);
}

// --- Remotive (remoto global) -----------------------------------------------

// deno-lint-ignore no-explicit-any
export function fromRemotive(item: any): RawJob {
  return {
    source: "remotive",
    externalId: String(item.id ?? ""),
    url: text(item.url),
    title: text(item.title),
    company: text(item.company_name),
    location: text(item.candidate_required_location),
    workMode: "remote",
    description: htmlToText(text(item.description)),
    tags: Array.isArray(item.tags) ? item.tags.map(text) : [],
    salaryMin: null,
    salaryMax: null,
    salaryCurrency: null,
    publishedAt: item.publication_date
      ? new Date(`${item.publication_date}Z`)
      : null,
  };
}

async function searchRemotive(query: string): Promise<RawJob[]> {
  // deno-lint-ignore no-explicit-any
  const body = (await getJson(
    `https://remotive.com/api/remote-jobs?limit=50&search=${
      encodeURIComponent(query)
    }`,
  )) as any;
  return (body.jobs ?? []).map(fromRemotive);
}

// --- Himalayas (remoto global) ----------------------------------------------

// deno-lint-ignore no-explicit-any
export function fromHimalayas(item: any): RawJob {
  const restrictions = Array.isArray(item.locationRestrictions)
    ? item.locationRestrictions.map(text)
    : [];
  return {
    source: "himalayas",
    externalId: text(item.guid),
    url: text(item.applicationLink) || text(item.guid),
    title: text(item.title),
    company: text(item.companyName),
    location: restrictions.length ? restrictions.join(", ") : "Worldwide",
    workMode: "remote",
    description: htmlToText(text(item.description) || text(item.excerpt)),
    tags: Array.isArray(item.categories) ? item.categories.map(text) : [],
    salaryMin: num(item.minSalary),
    salaryMax: num(item.maxSalary),
    salaryCurrency: text(item.currency) || null,
    publishedAt: typeof item.pubDate === "number"
      ? new Date(item.pubDate * 1000)
      : null,
  };
}

async function searchHimalayas(query: string): Promise<RawJob[]> {
  // deno-lint-ignore no-explicit-any
  const body = (await getJson(
    `https://himalayas.app/jobs/api/search?limit=40&q=${
      encodeURIComponent(query)
    }`,
  )) as any;
  return (body.jobs ?? []).map(fromHimalayas);
}

// --- Remote OK (remoto global) ---------------------------------------------
// Sus condiciones piden citar «Remote OK» y enlazar a la oferta original: la
// app muestra el portal de origen y abre su enlace.

// deno-lint-ignore no-explicit-any
export function fromRemoteOk(item: any): RawJob {
  return {
    source: "remoteok",
    externalId: String(item.id ?? ""),
    url: text(item.url) || text(item.apply_url),
    title: decodeEntities(text(item.position)),
    company: decodeEntities(text(item.company)),
    location: decodeEntities(text(item.location)) || "Worldwide",
    workMode: "remote",
    description: htmlToText(text(item.description)),
    tags: Array.isArray(item.tags) ? item.tags.map(text) : [],
    salaryMin: num(item.salary_min),
    salaryMax: num(item.salary_max),
    salaryCurrency: num(item.salary_min) || num(item.salary_max) ? "USD" : null,
    publishedAt: typeof item.epoch === "number"
      ? new Date(item.epoch * 1000)
      : null,
  };
}

/** Busca por etiqueta: la primera palabra del cargo («Flutter Developer» →
 * «flutter»). Sin etiqueta solo devuelve las 100 ofertas más recientes de
 * cualquier tema. El primer elemento es el aviso legal. */
async function searchRemoteOk(query: string): Promise<RawJob[]> {
  const tagName = query.trim().split(/\s+/)[0]?.toLowerCase()
    .replace(/[^a-z0-9+#.-]/g, "") ?? "";
  const body = await getJson(
    `https://remoteok.com/api${tagName ? `?tag=${encodeURIComponent(tagName)}` : ""}`,
  );
  return (Array.isArray(body) ? body : [])
    .filter((item) => item?.id && item?.position)
    .map(fromRemoteOk);
}

// --- We Work Remotely (remoto global, RSS de programación) -----------------
// Permite usar sus feeds citando la fuente y enlazando a cada oferta.

const tag = (xml: string, name: string) =>
  decodeEntities(
    xml.match(new RegExp(`<${name}>([\\s\\S]*?)</${name}>`))?.[1]
      ?.replace(/^<!\[CDATA\[|\]\]>$/g, "")
      .trim() ?? "",
  );

/** Un <item> del RSS. El título viene como «Empresa: Cargo». */
export function fromWeWorkRemotely(item: string): RawJob {
  const fullTitle = tag(item, "title");
  const colon = fullTitle.indexOf(":");
  const published = Date.parse(tag(item, "pubDate"));
  return {
    source: "weworkremotely",
    externalId: tag(item, "guid") || tag(item, "link"),
    url: tag(item, "link"),
    title: colon === -1 ? fullTitle : fullTitle.slice(colon + 1).trim(),
    company: colon === -1 ? "" : fullTitle.slice(0, colon).trim(),
    location: tag(item, "region") || "Anywhere in the World",
    workMode: "remote",
    description: htmlToText(tag(item, "description")),
    tags: [tag(item, "category")].filter(Boolean),
    salaryMin: null,
    salaryMax: null,
    salaryCurrency: null,
    publishedAt: Number.isNaN(published) ? null : new Date(published),
  };
}

async function fetchWeWorkRemotely(): Promise<RawJob[]> {
  const xml = await (await fetchOk(
    "https://weworkremotely.com/categories/remote-programming-jobs.rss",
  )).text();
  return [...xml.matchAll(/<item>([\s\S]*?)<\/item>/g)].map((match) =>
    fromWeWorkRemotely(match[1])
  );
}

// --- Portales de empresa: Greenhouse, Lever, Ashby, Workable, SmartRecruiters,
// Recruitee y Teamtailor. Devuelven las ofertas de una empresa; el filtro
// decide cuáles sirven.

export const BOARD_PROVIDERS = [
  "greenhouse",
  "lever",
  "ashby",
  "workable",
  "smartrecruiters",
  "recruitee",
  "teamtailor",
] as const;
export type BoardProvider = (typeof BOARD_PROVIDERS)[number];

export interface WatchedBoard {
  provider: BoardProvider;
  token: string;
}

/** Máximo de empresas vigiladas por búsqueda. */
export const MAX_BOARDS = 20;

const REMOTE_WORD = /(^|[^a-z])(remote|remoto)([^a-z]|$)/i;

function modeFromText(value: string): WorkMode | null {
  const text = value.toLowerCase();
  if (text.includes("hybrid") || text.includes("híbrido")) return "hybrid";
  if (REMOTE_WORD.test(text)) return "remote";
  if (text.includes("onsite") || text.includes("on-site")) return "onsite";
  return null;
}

// deno-lint-ignore no-explicit-any
export function fromGreenhouse(item: any, company: string): RawJob {
  const location = text(item.location?.name);
  return {
    source: "greenhouse",
    externalId: String(item.id ?? ""),
    url: text(item.absolute_url),
    title: text(item.title),
    company: text(item.company_name) || company,
    location,
    workMode: modeFromText(location),
    // Greenhouse entrega el HTML escapado (&lt;p&gt;…).
    description: htmlToText(decodeEntities(text(item.content))),
    tags: [],
    salaryMin: null,
    salaryMax: null,
    salaryCurrency: null,
    publishedAt: item.first_published
      ? new Date(item.first_published)
      : item.updated_at
      ? new Date(item.updated_at)
      : null,
  };
}

async function fetchGreenhouse(token: string): Promise<RawJob[]> {
  const base = `https://boards-api.greenhouse.io/v1/boards/${
    encodeURIComponent(token)
  }`;
  // deno-lint-ignore no-explicit-any
  const [board, body] = (await Promise.all([
    getJson(base),
    getJson(`${base}/jobs?content=true`),
  ])) as any[];
  return (body.jobs ?? []).map((item: unknown) =>
    fromGreenhouse(item, text(board.name) || token)
  );
}

// deno-lint-ignore no-explicit-any
export function fromLever(item: any, company: string): RawJob {
  const location = text(item.categories?.location);
  const workplace = text(item.workplaceType);
  const lists = Array.isArray(item.lists)
    ? item.lists
      // deno-lint-ignore no-explicit-any
      .map((list: any) => `${text(list.text)}\n${htmlToText(text(list.content))}`)
      .join("\n")
    : "";
  return {
    source: "lever",
    externalId: text(item.id),
    url: text(item.hostedUrl),
    title: text(item.text),
    company,
    location,
    workMode: workplace === "remote"
      ? "remote"
      : workplace === "hybrid"
      ? "hybrid"
      : workplace === "onsite"
      ? "onsite"
      : modeFromText(location),
    description: [text(item.descriptionPlain), lists, text(item.additionalPlain)]
      .join("\n"),
    tags: [],
    salaryMin: null,
    salaryMax: null,
    salaryCurrency: null,
    publishedAt: typeof item.createdAt === "number"
      ? new Date(item.createdAt)
      : null,
  };
}

async function fetchLever(token: string): Promise<RawJob[]> {
  const body = await getJson(
    `https://api.lever.co/v0/postings/${encodeURIComponent(token)}?mode=json`,
  );
  return (Array.isArray(body) ? body : []).map((item) =>
    fromLever(item, companyFromToken(token))
  );
}

// deno-lint-ignore no-explicit-any
export function fromAshby(item: any, company: string): RawJob {
  const workplace = text(item.workplaceType).toLowerCase();
  // «Bogota» llega sin país; el país viene aparte en la dirección.
  const country = text(item.address?.postalAddress?.addressCountry);
  const secondary = Array.isArray(item.secondaryLocations)
    // deno-lint-ignore no-explicit-any
    ? item.secondaryLocations.map((l: any) => text(l?.location))
    : [];
  const location = [text(item.location), ...secondary, country]
    .filter((part, i, all) => part && all.indexOf(part) === i)
    .join(", ");
  return {
    source: "ashby",
    externalId: text(item.id),
    url: text(item.jobUrl),
    title: text(item.title),
    company,
    location,
    workMode: workplace === "remote" || item.isRemote === true &&
        workplace === ""
      ? "remote"
      : workplace === "hybrid"
      ? "hybrid"
      : workplace === "onsite"
      ? "onsite"
      : modeFromText(location),
    description: text(item.descriptionPlain) ||
      htmlToText(text(item.descriptionHtml)),
    tags: [],
    salaryMin: null,
    salaryMax: null,
    salaryCurrency: null,
    publishedAt: item.publishedAt ? new Date(item.publishedAt) : null,
  };
}

async function fetchAshby(token: string): Promise<RawJob[]> {
  // deno-lint-ignore no-explicit-any
  const body = (await getJson(
    `https://api.ashbyhq.com/posting-api/job-board/${
      encodeURIComponent(token)
    }`,
  )) as any;
  return (body.jobs ?? [])
    // deno-lint-ignore no-explicit-any
    .filter((item: any) => item.isListed !== false)
    .map((item: unknown) => fromAshby(item, companyFromToken(token)));
}

// deno-lint-ignore no-explicit-any
export function fromWorkable(item: any, company: string): RawJob {
  const location = [text(item.city), text(item.state), text(item.country)]
    .filter(Boolean)
    .join(", ");
  const remote = item.telecommuting === true;
  return {
    source: "workable",
    externalId: text(item.shortcode),
    url: text(item.url) || text(item.shortlink),
    title: text(item.title),
    company,
    location: remote && !location ? "Remote" : location,
    workMode: remote ? "remote" : modeFromText(`${text(item.title)} ${location}`),
    description: htmlToText(text(item.description)),
    tags: [text(item.department), text(item.function)].filter(Boolean),
    salaryMin: null,
    salaryMax: null,
    salaryCurrency: null,
    publishedAt: item.published_on ? new Date(item.published_on) : null,
  };
}

async function fetchWorkable(token: string): Promise<RawJob[]> {
  // deno-lint-ignore no-explicit-any
  const body = (await getJson(
    `https://apply.workable.com/api/v1/widget/accounts/${
      encodeURIComponent(token)
    }?details=true`,
  )) as any;
  const company = text(body.name) || companyFromToken(token);
  return (body.jobs ?? []).map((item: unknown) => fromWorkable(item, company));
}

/** Detalle de SmartRecruiters: la lista no trae la descripción. */
// deno-lint-ignore no-explicit-any
export function fromSmartRecruiters(item: any, detail: any = null): RawJob {
  const place = item.location ?? {};
  const location = text(place.fullLocation) ||
    [text(place.city), text(place.country).toUpperCase()]
      .filter(Boolean)
      .join(", ");
  const sections = detail?.jobAd?.sections ?? {};
  const description = ["jobDescription", "qualifications", "additionalInformation"]
    .map((key) => htmlToText(text(sections[key]?.text)))
    .filter(Boolean)
    .join("\n");
  const companyId = text(item.company?.identifier);
  return {
    source: "smartrecruiters",
    externalId: text(item.id),
    url: text(detail?.postingUrl) ||
      `https://jobs.smartrecruiters.com/${companyId}/${text(item.id)}`,
    title: text(item.name),
    company: text(item.company?.name) || companyFromToken(companyId),
    location: place.remote === true && !location ? "Remote" : location,
    workMode: place.remote === true
      ? "remote"
      : place.hybrid === true
      ? "hybrid"
      : modeFromText(location) ?? "onsite",
    description,
    tags: [text(item.function?.label)].filter(Boolean),
    salaryMin: null,
    salaryMax: null,
    salaryCurrency: null,
    publishedAt: item.releasedDate ? new Date(item.releasedDate) : null,
  };
}

/** Detalles que se piden por empresa: cada uno es una llamada aparte. */
const SMARTRECRUITERS_DETAILS = 8;

/**
 * Hay empresas con miles de ofertas: se busca por cada término de la
 * búsqueda y solo se piden los detalles de las que lo llevan en el título.
 */
async function fetchSmartRecruiters(
  token: string,
  queries: string[],
): Promise<RawJob[]> {
  const base = `https://api.smartrecruiters.com/v1/companies/${
    encodeURIComponent(token)
  }/postings`;
  const lists = await Promise.all(
    (queries.length ? queries : [""]).map((query) =>
      getJson(`${base}?limit=100&q=${encodeURIComponent(query)}`)
    ),
  );
  // deno-lint-ignore no-explicit-any
  const byId = new Map<string, any>();
  // deno-lint-ignore no-explicit-any
  for (const list of lists as any[]) {
    for (const item of list.content ?? []) byId.set(text(item.id), item);
  }
  const items = [...byId.values()];
  const terms = queries.map((q) => q.toLowerCase()).filter(Boolean);
  const relevant = items
    .filter((item) =>
      terms.some((term) => text(item.name).toLowerCase().includes(term))
    )
    .slice(0, SMARTRECRUITERS_DETAILS);
  const details = await Promise.allSettled(
    relevant.map((item) => getJson(`${base}/${encodeURIComponent(text(item.id))}`)),
  );
  const detailById = new Map(
    relevant.map((item, i) => [
      text(item.id),
      details[i].status === "fulfilled" ? details[i].value : null,
    ]),
  );
  return items.map((item) =>
    fromSmartRecruiters(item, detailById.get(text(item.id)) ?? null)
  );
}

// deno-lint-ignore no-explicit-any
export function fromRecruitee(item: any, company: string): RawJob {
  const location = text(item.location) ||
    [text(item.city), text(item.country)].filter(Boolean).join(", ");
  // «2026-10-02 14:37:16 UTC»
  const published = Date.parse(
    text(item.published_at).replace(" UTC", "Z").replace(" ", "T"),
  );
  return {
    source: "recruitee",
    externalId: String(item.id ?? ""),
    url: text(item.careers_url),
    title: text(item.title),
    company: text(item.company_name) || company,
    location: !text(item.country) ||
        location.toLowerCase().includes(text(item.country).toLowerCase())
      ? location
      : [location, text(item.country)].filter(Boolean).join(", "),
    workMode: item.remote === true
      ? "remote"
      : item.hybrid === true
      ? "hybrid"
      : item.on_site === true
      ? "onsite"
      : modeFromText(location),
    description: [text(item.description), text(item.requirements)]
      .map(htmlToText)
      .filter(Boolean)
      .join("\n"),
    tags: Array.isArray(item.tags) ? item.tags.map(text).filter(Boolean) : [],
    salaryMin: num(item.salary?.min),
    salaryMax: num(item.salary?.max),
    salaryCurrency: text(item.salary?.currency) || null,
    publishedAt: Number.isNaN(published) ? null : new Date(published),
  };
}

async function fetchRecruitee(token: string): Promise<RawJob[]> {
  // deno-lint-ignore no-explicit-any
  const body = (await getJson(
    `https://${encodeURIComponent(token)}.recruitee.com/api/offers/`,
  )) as any;
  return (body.offers ?? []).map((item: unknown) =>
    fromRecruitee(item, companyFromToken(token))
  );
}

/** Un <item> del RSS de Teamtailor. */
export function fromTeamtailor(item: string, company: string): RawJob {
  const places = [...item.matchAll(/<tt:location>([\s\S]*?)<\/tt:location>/g)]
    .map((match) =>
      [tag(match[1], "tt:city"), tag(match[1], "tt:country")]
        .filter(Boolean)
        .join(", ")
    )
    .filter(Boolean);
  const location = [...new Set(places)].join("; ");
  // none | hybrid | temporary | fully
  const status = tag(item, "remoteStatus");
  const published = Date.parse(tag(item, "pubDate"));
  return {
    source: "teamtailor",
    externalId: tag(item, "guid") || tag(item, "link"),
    url: tag(item, "link"),
    title: tag(item, "title"),
    company,
    location: status === "fully" && !location ? "Remote" : location,
    workMode: status === "fully"
      ? "remote"
      : status === "hybrid"
      ? "hybrid"
      : status === "none"
      ? "onsite"
      : modeFromText(location),
    description: htmlToText(tag(item, "description")),
    tags: [tag(item, "tt:department"), tag(item, "tt:role")].filter(Boolean),
    salaryMin: null,
    salaryMax: null,
    salaryCurrency: null,
    publishedAt: Number.isNaN(published) ? null : new Date(published),
  };
}

async function fetchTeamtailor(token: string): Promise<RawJob[]> {
  const xml = await (await fetchOk(
    `https://${encodeURIComponent(token)}.teamtailor.com/jobs.rss`,
  )).text();
  const channel = xml.split("<item>")[0];
  const company = tag(channel, "title") || companyFromToken(token);
  return [...xml.matchAll(/<item>([\s\S]*?)<\/item>/g)].map((match) =>
    fromTeamtailor(match[1], company)
  );
}

/** «acme-labs» → «Acme Labs» (Lever y Ashby no dan el nombre). */
export function companyFromToken(token: string): string {
  return token
    .split(/[-_]+/)
    .filter(Boolean)
    .map((word) => word[0].toUpperCase() + word.slice(1))
    .join(" ");
}

/** Cada proveedor recibe la empresa y los términos de la búsqueda. */
const BOARD_FETCHERS: Record<
  BoardProvider,
  (token: string, queries: string[]) => Promise<RawJob[]>
> = {
  greenhouse: fetchGreenhouse,
  lever: fetchLever,
  ashby: fetchAshby,
  workable: fetchWorkable,
  smartrecruiters: fetchSmartRecruiters,
  recruitee: fetchRecruitee,
  teamtailor: fetchTeamtailor,
};

/** Portales que se consultan por búsqueda (uno por cada cargo). */
const SEARCHERS: Partial<
  Record<SourceId, (query: string) => Promise<RawJob[]>>
> = {
  getonboard: searchGetOnBoard,
  remotive: searchRemotive,
  himalayas: searchHimalayas,
  remoteok: searchRemoteOk,
};

/** Portales que devuelven todo de una vez: se consultan una sola vez. */
const FEEDS: Partial<Record<SourceId, () => Promise<RawJob[]>>> = {
  weworkremotely: fetchWeWorkRemotely,
};

/**
 * Busca en paralelo en los portales y en las empresas vigiladas; devuelve lo
 * encontrado y qué fuentes fallaron (p. ej. «greenhouse:acme» si no existe).
 */
export async function searchAll(
  sources: SourceId[],
  queries: string[],
  boards: WatchedBoard[] = [],
): Promise<{ jobs: RawJob[]; failed: string[] }> {
  const tasks = [
    ...sources.flatMap((source) => {
      const search = SEARCHERS[source];
      return search
        ? queries.map((query) => ({ source, run: search(query) }))
        : [];
    }),
    ...sources.flatMap((source) => {
      const feed = FEEDS[source];
      return feed ? [{ source, run: feed() }] : [];
    }),
    ...boards.slice(0, MAX_BOARDS).map((board) => ({
      source: `${board.provider}:${board.token}`,
      run: BOARD_FETCHERS[board.provider](board.token, queries),
    })),
  ];
  const results = await Promise.allSettled(tasks.map((task) => task.run));
  const jobs: RawJob[] = [];
  const failed = new Set<string>();
  results.forEach((result, index) => {
    if (result.status === "fulfilled") jobs.push(...result.value);
    else {
      failed.add(tasks[index].source);
      console.warn(`search ${tasks[index].source} failed`, result.reason);
    }
  });
  return { jobs, failed: [...failed] };
}
