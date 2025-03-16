hljs.initHighlightingOnLoad();
addEventListener('load', function() {
  var blocks = document.querySelectorAll('pre code.hljs');
  Array.prototype.forEach.call(blocks, function(block) {
    var language = block.result.language;
    block.insertAdjacentHTML("afterbegin",`<label>${language}\n\n</label>`)
  });
})

hljs.addPlugin(
  new CopyButtonPlugin()
);
