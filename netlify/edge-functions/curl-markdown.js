export default async (request, context) => {
  if (request.headers.get("x-md-internal")) return context.next();

  const ua = request.headers.get("user-agent") ?? "";
  const url = new URL(request.url);
  let mdPath;

  if (url.pathname.endsWith(".md")) {
    mdPath = url.pathname.replace(/\.md$/, "/index.md");
  } else if (/curl|wget|httpie/i.test(ua)) {
    mdPath = url.pathname.replace(/\/?$/, "/index.md");
  } else {
    return context.next();
  }

  url.pathname = mdPath;

  const response = await fetch(url.toString(), { headers: { "x-md-internal": "1" } });
  if (!response.ok) {
    return new Response("# 404 Not Found\n\nThe page you were looking for doesn't exist.\n", {
      status: 404,
      headers: { "content-type": "text/plain; charset=utf-8" },
    });
  }

  return new Response(response.body, {
    headers: {
      "content-type": "text/plain; charset=utf-8",
      "cache-control": response.headers.get("cache-control") ?? "",
    },
  });
};
