export default async (request, context) => {
  const ua = request.headers.get("user-agent") ?? "";
  if (!/curl|wget|httpie/i.test(ua)) {
    return context.next();
  }

  const url = new URL(request.url);
  const mdPath = url.pathname.replace(/\/?$/, "/index.md");
  url.pathname = mdPath;

  const response = await fetch(url.toString());
  if (!response.ok) return context.next();

  return new Response(response.body, {
    headers: {
      "content-type": "text/plain; charset=utf-8",
      "cache-control": response.headers.get("cache-control") ?? "",
    },
  });
};
