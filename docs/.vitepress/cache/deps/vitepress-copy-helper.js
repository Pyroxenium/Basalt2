import {
  computed,
  createElementBlock,
  normalizeClass,
  onMounted,
  openBlock,
  ref,
  unref,
  useSlots
} from "./chunk-QSFHPHRT.js";

// ../../../../../../node_modules/vitepress-copy-helper/dist/vitepress-copy-helper.js
async function L(l) {
  try {
    return navigator.clipboard.writeText(l);
  } catch {
    const e = document.createElement("textarea"), a = document.activeElement;
    e.value = l, e.setAttribute("readonly", ""), e.style.contain = "strict", e.style.position = "absolute", e.style.left = "-9999px", e.style.fontSize = "12pt";
    const t = document.getSelection(), n = t ? t.rangeCount > 0 && t.getRangeAt(0) : null;
    document.body.appendChild(e), e.select(), e.selectionStart = 0, e.selectionEnd = l.length, document.execCommand("copy"), document.body.removeChild(e), t && n && (t.removeAllRanges(), t.addRange(n)), a && a.focus();
  }
}
var N = (l, e) => {
  const a = l.__vccOpts || l;
  for (const [t, n] of e)
    a[t] = n;
  return a;
};
var $ = ["data-message", "data-label"];
var M = ["innerHTML"];
var d = {
  position: "auto",
  target: "auto",
  message: "copied",
  label: null,
  classes: "copy-btn",
  preferSibling: "previous"
};
var O = {
  __name: "CopyButton",
  props: {
    position: {
      // start, end, auto
      type: String,
      default: () => d.position
    },
    target: {
      // previous, next, auto
      type: String,
      default: () => d.target
    },
    message: {
      type: String,
      default: () => d.message
    },
    label: {
      type: String,
      default: () => d.label
    },
    classes: {
      type: String,
      default: () => d.classes
    },
    content: {
      type: String,
      default: null
    }
  },
  setup(l) {
    var v, g;
    const e = l, a = useSlots(), t = ref(null), n = ref(null), p = ref(true), f = ref(null), r = ref(null), C = e.label ? e.label : (g = (v = a.default) == null ? void 0 : v.call(a)[0]) == null ? void 0 : g.children, E = computed(() => `<!-- Button not rendered: ${f.value} -->`), x = computed(() => e.message.replace("$CONTENT", r.value));
    onMounted(() => {
      var m, y;
      const s = ((m = t.value.previousElementSibling) == null ? void 0 : m.tagName) === "CODE" ? t.value.previousElementSibling : null, i = ((y = t.value.nextElementSibling) == null ? void 0 : y.tagName) === "CODE" ? t.value.nextElementSibling : null;
      if (!s && !i && !e.content) {
        p.value = false, f.value = "No code element found and no content prop given";
        return;
      }
      if (e.content) {
        r.value = e.content;
        return;
      }
      let o = e.position;
      if (e.target === "auto" ? s && i ? (n.value = s, o === "auto" && (o = "end")) : n.value = s || i : e.target === "previous" ? (n.value = s, o === "auto" && (o = "end")) : e.target === "next" && (n.value = i, o === "auto" && (o = "start")), !n.value) {
        f.value = "Failed to select code node";
        return;
      }
      let u = "beforeend";
      o === "auto" ? s ? u = "beforeend" : i && (u = "afterbegin") : o === "start" ? u = "afterbegin" : o === "end" && (u = "beforeend"), r.value = n.value.innerText, n.value.innerText = "", n.value.insertAdjacentHTML("beforeend", `<span>${r.value}</span>`), n.value.insertAdjacentElement(u, t.value), t.value.classList.add(`copy-btn-${u}`);
    });
    async function T() {
      await L(r.value), t.value.classList.add("copied"), setTimeout(() => {
        t.value.classList.remove("copied");
      }, 1e3);
    }
    return (s, i) => p.value ? (openBlock(), createElementBlock("span", {
      key: 0,
      class: normalizeClass(l.classes),
      ref_key: "btn",
      ref: t,
      onClick: T,
      "data-message": x.value,
      "data-label": unref(C)
    }, null, 10, $)) : (openBlock(), createElementBlock("span", {
      key: 1,
      innerHTML: E.value
    }, null, 8, M));
  }
};
var R = N(O, [["__scopeId", "data-v-32f61984"]]);
var H = R;
export {
  R as default,
  H as defaultSettings
};
//# sourceMappingURL=vitepress-copy-helper.js.map
