# Luarmor Documentation

The source for the [Luarmor](https://luarmor.net) documentation, built with [Mintlify](https://mintlify.com).

## Structure

| Path | Contents |
|------|----------|
| `mint.json` | Site config: navigation, tabs, redirects, colours |
| `introduction.mdx`, `quickstart.mdx` | Getting started |
| `discord-bot.mdx`, `features/` | Feature guides (Discord bot, ad rewards, webhook protection, source locker) |
| `scripting/` | Writing scripts for Luarmor: optimisation, macros, runtime variables, key check library, verification |
| `troubleshooting/` | Help for script users and script owners, plus common scams |
| `api-reference/` | API tab: introduction, SDKs, and one page per endpoint under `endpoint/` |
| `api-reference/openapi.json` | OpenAPI spec for the HTTP API |
| `snippets/` | Reusable MDX snippets imported by pages |
| `images/` | Screenshots, referenced as `/images/<name>` |

## Development

Install the [Mintlify CLI](https://www.npmjs.com/package/mintlify):

```
npm i -g mintlify
```

Then, from the root of this repository (where `mint.json` is), run:

```
mintlify dev
```

The site is served at `http://localhost:3000`. Run `mintlify broken-links` before opening a pull request.

## Adding a page

1. Create an `.mdx` file with a `title` and `description` in its frontmatter. Don't add an `# H1`, as Mintlify renders the title.
2. Add its path (without `.mdx`) to the right group in `mint.json`'s `navigation`.
3. If you move or rename a page, add a `redirects` entry in `mint.json` so old links keep working.

## Contributing

Pull requests are welcome. For questions about Luarmor itself, join the [Discord server](https://discord.gg/luarmor).
