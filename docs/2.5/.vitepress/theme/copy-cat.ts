const COPY_CAT_ORIGIN = 'https://copy-cat.squiddev.cc/'
const REQUIRE_JS_URL = `${COPY_CAT_ORIGIN}require.js`
const LOAD_TIMEOUT = 20_000

type RequireJs = {
  (
    dependencies: string[],
    onLoad: (module: unknown) => void,
    onError?: (error: unknown) => void,
  ): void
  config(options: {
    paths: Record<string, string>
  }): void
}

export type CopyCatComputer = {
  dispose?: () => void
  queueEvent?: (event: string, ...arguments_: unknown[]) => void
  reboot?: () => void
  shutdown?: () => void
  turnOn?: () => void
}

type CopyCatEmbed = ((
  container: HTMLElement,
  options: {
    files: Record<string, string>
    hdFont: boolean
    height: number
    label: string
    width: number
  },
) => Promise<CopyCatComputer>) & {
  render?: (component: null, container: HTMLElement) => void
}

export type CopyCatSession = {
  computer: CopyCatComputer
  dispose: () => void
}

export type CopyCatOptions = {
  code: string
  height: number
  runtimeUrl: string
  title: string
  width: number
}

declare global {
  interface Window {
    require?: RequireJs
    requirejs?: RequireJs
  }
}

let requireJsPromise: Promise<RequireJs> | undefined
let embedPromise: Promise<CopyCatEmbed> | undefined
const filePromises = new Map<string, Promise<string>>()
let topWindowZIndex = 100

export function nextCopyCatZIndex() {
  topWindowZIndex += 1
  return topWindowZIndex
}

function getRequireJs() {
  const loader = window.requirejs ?? window.require
  return loader && typeof loader.config === 'function' ? loader : undefined
}

function withTimeout<T>(promise: Promise<T>, message: string) {
  return new Promise<T>((resolve, reject) => {
    const timeout = window.setTimeout(
      () => reject(new Error(message)),
      LOAD_TIMEOUT,
    )

    promise.then(
      (value) => {
        window.clearTimeout(timeout)
        resolve(value)
      },
      (error) => {
        window.clearTimeout(timeout)
        reject(error)
      },
    )
  })
}

function loadRequireJs() {
  const available = getRequireJs()
  if (available) return Promise.resolve(available)
  if (requireJsPromise) return requireJsPromise

  requireJsPromise = withTimeout(
    new Promise<RequireJs>((resolve, reject) => {
      const existing = document.querySelector<HTMLScriptElement>(
        'script[data-copy-cat-require-js]',
      )
      const script = existing ?? document.createElement('script')

      const finish = () => {
        const loader = getRequireJs()
        if (loader) {
          resolve(loader)
        } else {
          reject(new Error('RequireJS loaded, but did not expose an AMD loader.'))
        }
      }

      script.addEventListener('load', finish, { once: true })
      script.addEventListener(
        'error',
        () => reject(new Error('Could not load the Copy Cat module loader.')),
        { once: true },
      )

      if (!existing) {
        script.src = REQUIRE_JS_URL
        script.async = true
        script.dataset.copyCatRequireJs = 'true'
        document.head.append(script)
      }
    }),
    'Loading the Copy Cat module loader timed out.',
  ).catch((error) => {
    requireJsPromise = undefined
    if (!getRequireJs()) {
      document
        .querySelector<HTMLScriptElement>('script[data-copy-cat-require-js]')
        ?.remove()
    }
    throw error
  })

  return requireJsPromise
}

function loadEmbed() {
  if (embedPromise) return embedPromise

  embedPromise = loadRequireJs()
    .then((loader) => {
      loader.config({
        paths: {
          copycat: COPY_CAT_ORIGIN,
        },
      })

      return withTimeout(
        new Promise<CopyCatEmbed>((resolve, reject) => {
          loader(
            ['copycat/embed'],
            (module) => {
              if (typeof module === 'function') {
                resolve(module as CopyCatEmbed)
              } else {
                reject(new Error('Copy Cat returned an invalid embed module.'))
              }
            },
            reject,
          )
        }),
        'Loading Copy Cat timed out.',
      )
    })
    .catch((error) => {
      embedPromise = undefined
      throw error
    })

  return embedPromise
}

function loadText(url: string) {
  const cached = filePromises.get(url)
  if (cached) return cached

  const pending = fetch(url)
    .then((response) => {
      if (!response.ok) {
        throw new Error(
          `Could not load ${url} (${response.status} ${response.statusText}).`,
        )
      }
      return response.text()
    })
    .catch((error) => {
      filePromises.delete(url)
      throw error
    })

  filePromises.set(url, pending)
  return pending
}

export async function mountCopyCat(
  container: HTMLElement,
  options: CopyCatOptions,
): Promise<CopyCatSession> {
  const [embed, basaltRuntime] = await Promise.all([
    loadEmbed(),
    loadText(options.runtimeUrl),
  ])

  container.replaceChildren()

  const computer = await embed(container, {
    files: {
      'basalt.lua': basaltRuntime,
      'startup.lua': options.code,
    },
    hdFont: true,
    height: options.height,
    label: options.title,
    width: options.width,
  })

  let disposed = false
  return {
    computer,
    dispose() {
      if (disposed) return
      disposed = true

      if (embed.render) {
        embed.render(null, container)
      } else {
        computer.dispose?.()
        container.replaceChildren()
      }
    },
  }
}
