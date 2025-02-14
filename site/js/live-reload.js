function setupLiveReload() {
  const evtSource = new EventSource('/live-reload');
  evtSource.onmessage = function(event) {
    if (event.data === 'reload') {
      window.location.reload();
    }
  };
  evtSource.onerror = function() {
    // Try to reconnect after a brief delay
    setTimeout(() => setupLiveReload(), 1000);
  };
}
setupLiveReload(); 