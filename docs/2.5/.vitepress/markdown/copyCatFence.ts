import type MarkdownIt from 'markdown-it'

const RUN_MARKER = /(?:^|\s)run(?=\s|$)/
const TITLE_OPTION = /(?:^|\s)title=(?:"([^"]*)"|'([^']*)'|([^\s]+))/

function encodeUtf8(value: string) {
  return Buffer.from(value, 'utf8').toString('base64')
}

function escapeAttribute(md: MarkdownIt, value: string) {
  return md.utils.escapeHtml(value)
}

/**
 * Turns explicitly runnable Lua fences into interactive Copy Cat examples.
 *
 * ```lua run title="My demo"
 * print("Hello")
 * ```
 */
export function copyCatFencePlugin(md: MarkdownIt) {
  const renderFence = md.renderer.rules.fence

  if (!renderFence) {
    throw new Error('Copy Cat examples require Markdown-It’s fence renderer.')
  }

  md.renderer.rules.fence = (tokens, index, options, env, self) => {
    const token = tokens[index]
    const info = token.info.trim()
    const language = info.match(/^([^\s]+)/)?.[1]
    const titleMatch = info.match(TITLE_OPTION)
    const infoWithoutTitle = info.replace(TITLE_OPTION, ' ')

    if (language !== 'lua' || !RUN_MARKER.test(infoWithoutTitle)) {
      return renderFence(tokens, index, options, env, self)
    }

    const title =
      titleMatch?.[1] ??
      titleMatch?.[2] ??
      titleMatch?.[3] ??
      'Basalt demo'

    // Keep VitePress options such as line highlighting, but hide our options
    // from the syntax highlighter.
    const originalInfo = token.info
    token.info = infoWithoutTitle
      .replace(RUN_MARKER, ' ')
      .replace(/\s+/g, ' ')
      .trim()

    const highlightedCode = renderFence(tokens, index, options, env, self)
    token.info = originalInfo

    return [
      '<CopyCatDemo',
      ` code="${escapeAttribute(md, encodeUtf8(token.content))}"`,
      ` title="${escapeAttribute(md, title)}"`,
      ` language="${escapeAttribute(md, language)}"`,
      '>',
      highlightedCode,
      '</CopyCatDemo>',
    ].join('')
  }
}
