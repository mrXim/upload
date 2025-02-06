$(document).ready(function () {
	var startAll = new Date();
	var _tables = document.querySelectorAll("table");
	_tables.forEach(table => processTable(table));

	setTimeout(() => {
		processImage();
	}, 3000);

	var _processed = [];
	function processTable(table) {
		try {
			var start = new Date();
			rasterizeHTML
				.drawHTML(table.outerHTML)
				.then(renderResult => {
					const img = new Image();
					img.src = renderResult.image.src;
					table.replaceWith(img);
					console.log('table image', (new Date() - start), (new Date() - startAll));
				})
				.finally(() => {
					processedTable(table);
				});
		} catch (ex) {
			console.error(ex);
			processedTable(table);
		}
	}

	function processedTable(table) {
		_processed.push(table);
		if (_processed.length === _tables.length) {
			processImage();
		}
	}

	var processedImage = false;
	function processImage() {
		console.log('processImage', processedImage);
		try {
			if (processedImage) {
				return;
			}
			processedImage = true;

			//-- lazyload image
			$("img").lazyload({
				threshold: 200,
				skip_invisible: true,
				placeholder: "data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw",
				load: function () {
					$(window).trigger("scroll")
				}
			});

			//-- event click image
			$("img").click(function () {
				webkit.messageHandlers.callbackHandler.postMessage($(this).attr("data-original"))
			});

			//-- complet load image
			$("img").on("load", function () {
				webkit.messageHandlers.callbackHandler.postMessage(document.documentElement.getBoundingClientRect().height)
			});
		} catch (ex) {
			console.error(ex);
		}
	}
});
