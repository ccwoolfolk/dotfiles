/*
 * This automates downloading purchased music from Amazon Music rather than clicking each song's
 * menu individually. In my case, I had >1000 songs from decades of purchases.
 *
 * Before starting, go to chrome://settings/downloads and untick "ask where to save each file
 * before downloading" in particular.
 *
 * Paste the script into the console at https://music.amazon.com/recently/purchased.
 *
 * Set `TEST_LIMIT = Infinity` after the first batch downloads successfully.
 *
 */
(async function downloadAllPurchasedSongs() {
  const TEST_LIMIT = 5; // bump to Infinity once verified
  const SCROLL_STEP = 400;
  const SCROLL_WAIT = 350;
  const MAX_IDLE_SCROLLS = 15; // consecutive no-progress steps at the bottom before giving up
  const STORAGE_KEY = 'amazonMusicDownloader_done';

  const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

  async function waitFor(fn, timeout = 3000, interval = 120) {
    const start = Date.now();
    while (Date.now() - start < timeout) {
      const result = fn();
      if (result) return result;
      await sleep(interval);
    }
    return null;
  }

  function getDone() {
    try { return new Set(JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]')); }
    catch { return new Set(); }
  }
  function markDone(key) {
    const done = getDone();
    done.add(key);
    localStorage.setItem(STORAGE_KEY, JSON.stringify([...done]));
  }

  async function downloadRow(row) {
    const menuButton = row.querySelector('music-button[slot="contextMenu"]');
    if (!menuButton) throw new Error('no menu button');
    menuButton.click();

    const downloadOption = await waitFor(() =>
      document.querySelector('music-list-item[primary-text="Download"]')
    );
    if (!downloadOption) throw new Error('no Download menu option');

    await sleep(350);
    downloadOption.click();
    await sleep(800);

    document.body.dispatchEvent(new KeyboardEvent('keydown', { key: 'Escape', bubbles: true }));
    await waitFor(() => !document.querySelector('[role="menu"]'), 1500);
    await sleep(350);
  }

  window.scrollTo(0, 0);
  await sleep(500);

  const done = getDone();
  let ok = 0, fail = 0, processedThisRun = 0, idleScrolls = 0;

  while (processedThisRun < TEST_LIMIT) {
    const rows = Array.from(document.querySelectorAll('music-image-row'));
    let foundNew = false;

    for (const row of rows) {
      if (processedThisRun >= TEST_LIMIT) break;
      const key = row.getAttribute('data-key');
      if (!key || done.has(key)) continue;
      if (!row.querySelector('music-button[slot="contextMenu"]')) continue; // not hydrated yet

      foundNew = true;
      const title = row.getAttribute('primary-text') || key;
      try {
        await downloadRow(row);
        markDone(key);
        done.add(key);
        ok++;
        processedThisRun++;
        console.log(`[${processedThisRun}] downloaded: ${title}`);
      } catch (err) {
        fail++;
        console.error(`failed: ${title}`, err);
      }
    }

    if (processedThisRun >= TEST_LIMIT) break;

    const atBottom = window.scrollY + window.innerHeight >= document.documentElement.scrollHeight - 10;
    if (atBottom && !foundNew) {
      idleScrolls++;
      if (idleScrolls > MAX_IDLE_SCROLLS) {
        console.log('Reached bottom with no new content. Stopping.');
        break;
      }
    } else {
      idleScrolls = 0;
    }

    window.scrollBy(0, SCROLL_STEP);
    await sleep(SCROLL_WAIT);
  }

  console.log(`Done. Success: ${ok}, Failed: ${fail}, Total done (all-time): ${getDone().size}`);
})();
