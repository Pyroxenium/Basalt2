import { mkdir, readdir, writeFile } from 'node:fs/promises'
import { dirname, join, relative, resolve, sep } from 'node:path'

const [versionDirectoryArg, outputDirectoryArg] = process.argv.slice(2)

if (!versionDirectoryArg || !outputDirectoryArg) {
  throw new Error('usage: create-version-redirects <version-directory> <output-directory>')
}

const versionDirectory = resolve(versionDirectoryArg)
const outputDirectory = resolve(outputDirectoryArg)

async function htmlFiles(directory) {
  const result = []
  for (const entry of await readdir(directory, { withFileTypes: true })) {
    const path = join(directory, entry.name)
    if (entry.isDirectory()) {
      result.push(...await htmlFiles(path))
    } else if (entry.isFile() && entry.name.endsWith('.html')) {
      result.push(path)
    }
  }
  return result
}

for (const source of await htmlFiles(versionDirectory)) {
  const page = relative(versionDirectory, source)
  if (page === 'index.html') continue

  const webPath = page.split(sep).join('/')
  const target = `/2.0/${webPath}`
  const destination = join(outputDirectory, page)

  await mkdir(dirname(destination), { recursive: true })
  await writeFile(destination, `<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="0; url=${target}">
    <link rel="canonical" href="${target}">
    <title>Basalt 2 Documentation</title>
  </head>
  <body>
    <p>This page moved to <a href="${target}">${target}</a>.</p>
  </body>
</html>
`)
}

