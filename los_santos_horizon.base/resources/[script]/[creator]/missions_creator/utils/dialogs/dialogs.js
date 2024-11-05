async function objectDialog(type) {
	let resolve = null;
	const promise = new Promise((res, rej) => { resolve = res; });

	switch(type) {
		case "item": {
			resolve( await itemsDialog() );
			break;
		}

		case "account": {
			resolve( await accountsDialog() );
			break;
		}

		case "weapon": {
			resolve( await weaponsDialog() );
			break;
		}
	}

	return promise;
}

function toggleCursor(enabled) {
	if (enabled) {
		$.post(`https://${resName}/enableCursor`, JSON.stringify({}));
	} else {
		$.post(`https://${resName}/disableCursor`, JSON.stringify({}));
	}
}

function loadDialog(dialogName) {
	var script = document.createElement('script');

	script.setAttribute('src',`../utils/dialogs/${dialogName}/${dialogName}.js`);

	document.head.appendChild(script);
}

// Messages received by client
window.addEventListener('message', (event) => {
	let data = event.data;
	let action = data.action;

	switch(action) {
		case "loadDialog": {
			var script = document.createElement('script');
			script.setAttribute('src',`../utils/dialogs/${data.dialogName}/${data.dialogName}.js`);
			document.head.appendChild(script);
			break;
		}
	}
})

let framework = null;

// Listen message
window.addEventListener('message', async function(event) {
	let data = event.data;
	if(data.action != "confirmFramework") return;

	framework = data.framework;
});

function getFramework() {
	return framework;
}

$.post(`https://${resName}/nuiReady`, JSON.stringify({}));