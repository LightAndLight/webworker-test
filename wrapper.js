importScripts('./output/worker.js');

app = Elm.Worker.Main.init();
app.ports.sendResponse.subscribe((e) => postMessage(e));
onmessage = (e) => {
    app.ports.receiveRequest.send(e.data);
};
