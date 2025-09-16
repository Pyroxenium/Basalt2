function v(){if(typeof window>"u")return;let r=null,a=!1;async function g(){const t=await fetch("https://raw.githubusercontent.com/Pyroxenium/Basalt2/refs/heads/main/release/basalt.lua").then(s=>s.text());return window.require||await new Promise((s,o)=>{const e=document.createElement("script");e.src="https://copy-cat.squiddev.cc/require.js",e.onload=s,e.onerror=o,document.body.appendChild(e)}),t}async function h(t,s="Code Demo"){if(console.log("runCodeInEmulator called with:",{code:t,title:s}),a||r){console.warn("Emulator already running");return}a=!0,console.log("Starting emulator loading...");try{console.log("Loading dependencies...");const o=await g();console.log("Dependencies loaded, basalt length:",o.length);const e=document.createElement("div");e.style.position="fixed",e.style.top="-9999px",e.style.left="-9999px",e.style.width="650px",e.style.height="480px",e.style.padding="0",e.style.margin="0",e.style.border="none",document.body.appendChild(e),window.require.config({paths:{copycat:"https://copy-cat.squiddev.cc/"}}),window.require(["copycat/embed"],i=>{const l=i(e,{hdFont:"https://copy-cat.squiddev.cc/term_font_hd-0506b6efe5f7feae.png",files:{"startup.lua":t,"basalt.lua":o},label:s});console.log("Setup promise created:",l),l&&typeof l.then=="function"?l.then(n=>{console.log("Computer instance resolved from promise:",n),r=n,n&&typeof n.run=="function"?(n.run(),console.log("Computer started running")):n&&typeof n.start=="function"?(n.start(),console.log("Computer started with start()")):(console.error("Computer does not have run or start method:",n),console.log("Available methods:",Object.getOwnPropertyNames(n||{}))),console.log("Showing terminal window..."),f(e,s),a=!1,console.log("Emulator setup complete")}).catch(n=>{console.error("Error in setup promise:",n),a=!1}):(console.log("Setup returned directly:",l),r=l,l&&typeof l.run=="function"?(l.run(),console.log("Computer started running (direct)")):console.error("Direct setup does not have run method:",l),f(e,s),a=!1)})}catch(o){console.error("Error starting emulator:",o),a=!1}}function f(t,s){console.log("showTerminalWindow called with:",{container:t,title:s});const o=document.createElement("div");o.className="global-terminal-window",console.log("Terminal window div created"),o.style.cssText=`
      position: fixed;
      width: 625px;
      height: 425px;
      background: #1a1a1a;
      border-radius: 8px;
      box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
      display: flex;
      flex-direction: column;
      z-index: 9999;
      border: 1px solid #333;
      top: 100px;
      left: 100px;
    `;const e=document.createElement("div");e.className="terminal-header",e.style.cssText=`
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0.2rem 1rem;
      background: linear-gradient(180deg, #2a2a2a 0%, #222 100%);
      border-bottom: 1px solid #111;
      cursor: move;
      user-select: none;
      border-radius: 8px 8px 0 0;
    `;const i=document.createElement("div");i.innerHTML=`<span style="color: #fff; font-size: 0.875rem; font-weight: 500;">💻 ${s}</span>`;const l=document.createElement("div");l.innerHTML=`
      <button class="control-button close" style="width: 24px; height: 24px; border-radius: 50%; border: none; cursor: pointer; background: #ef4444; color: white; font-size: 12px;" onclick="closeGlobalEmulator()">✕</button>
    `,e.appendChild(i),e.appendChild(l);const n=document.createElement("div");n.style.cssText=`
      flex: 1;
      background: #000;
      border-radius: 0 0 8px 8px;
      overflow: hidden;
      padding: 0;
      margin: 0;
    `,n.appendChild(t),t.style.position="static",t.style.top="auto",t.style.left="auto",t.style.width="100%",t.style.height="100%",t.style.padding="0",t.style.margin="0",o.appendChild(e),o.appendChild(n),document.body.appendChild(o),console.log("Terminal window added to body");let u=!1,c={x:0,y:0};e.addEventListener("mousedown",d=>{u=!0,c.x=d.clientX-o.offsetLeft,c.y=d.clientY-o.offsetTop}),document.addEventListener("mousemove",d=>{if(!u)return;const y=o.offsetWidth,b=o.offsetHeight;let p=d.clientX-c.x,m=d.clientY-c.y;const x=window.innerWidth-y,C=window.innerHeight-b;p=Math.max(0,Math.min(p,x)),m=Math.max(0,Math.min(m,C)),o.style.left=p+"px",o.style.top=m+"px"}),document.addEventListener("mouseup",()=>{u=!1})}function w(){if(r){try{r.shutdown()}catch(s){console.warn("Error shutting down:",s)}r=null}const t=document.querySelector(".global-terminal-window");t&&document.body.removeChild(t)}window.runCodeBlock=function(t){const s=t.closest(".code-block-with-run"),e=s.querySelector(".code-content").getAttribute("data-code"),i=atob(e),l=s.querySelector(".language-badge"),n=l&&l.textContent?l.textContent:"lua";h(i,`Code Demo (${n})`)},window.closeGlobalEmulator=w}export{v as initEmulator};
