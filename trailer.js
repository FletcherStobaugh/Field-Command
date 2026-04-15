// ============================================================
// FIELD COMMAND — trailer controller
// Handles: fake timestamp, replay, and email capture stub.
// ============================================================

(function () {
  "use strict";

  const TRAILER_DURATION_MS = 30000;

  /* ----- Fake mission timestamp (HUD, upper-left) ----- */
  const tsEl = document.getElementById("timestamp");
  let started = Date.now();

  function pad(n) { return String(n).padStart(2, "0"); }

  function tick() {
    const elapsed = Date.now() - started;
    const total = Math.floor(elapsed / 1000);
    const mm = pad(Math.floor(total / 60));
    const ss = pad(total % 60);
    if (tsEl) tsEl.textContent = `${mm}:${ss}`;
  }
  tick();
  setInterval(tick, 500);

  /* ----- Replay button: re-trigger all CSS animations ----- */
  const replayBtn = document.getElementById("replay");
  const trailer = document.getElementById("trailer");

  if (replayBtn && trailer) {
    replayBtn.addEventListener("click", function () {
      started = Date.now();
      // Cloning + replacing the trailer node forces all CSS animations to restart.
      const clone = trailer.cloneNode(true);
      trailer.parentNode.replaceChild(clone, trailer);
      // Re-attach the replay handler to the new node's button.
      const newReplay = clone.querySelector("#replay");
      if (newReplay) {
        newReplay.addEventListener("click", function () {
          replayBtn.click(); // defer to the original handler chain
        });
      }
      // Smooth-scroll back to top for a clean replay.
      window.scrollTo({ top: 0, behavior: "smooth" });
    });
  }

  /* ----- Email capture (stub — no backend yet) ----- */
  const form = document.getElementById("wishlist-form");
  const note = document.getElementById("form-note");

  if (form) {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      const emailInput = form.querySelector('input[type="email"]');
      const value = emailInput ? emailInput.value.trim() : "";
      if (!value) return;

      // Stash locally so we don't lose signups before the backend is wired.
      try {
        const existing = JSON.parse(localStorage.getItem("fc_wishlist") || "[]");
        existing.push({ email: value, ts: new Date().toISOString() });
        localStorage.setItem("fc_wishlist", JSON.stringify(existing));
      } catch (_) { /* localStorage blocked, continue */ }

      if (note) {
        note.textContent = "LOGGED // YOU'RE ON THE LIST. STAND BY FOR ORDERS.";
        note.style.color = "var(--orange)";
      }
      if (emailInput) emailInput.value = "";
    });
  }
})();
