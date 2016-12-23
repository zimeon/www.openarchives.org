// File: copy-code.js
// Requires: prototype.js, scriptaculous.js?load=effects

	function copyToClipboard(elt) {
		var urlSwf = "http://static.photobucket.com/include/swf/_clipboard.swf";
		var strMssgBoxId = "notifyTextCopied";
		var eltNotify = null;

		// Display Notifications
		if((eltNotify = $(strMssgBoxId)) == null){
			// Attach the notification to the DOM
			var eltBody = document.getElementsByTagName('body').item(0);

			eltNotify = document.createElement('div');
			eltNotify.setAttribute('id', strMssgBoxId);
			eltNotify.style.display = 'none';

			eltNotify.innerHTML = 'Copied';

			eltBody.appendChild(eltNotify);
		}
		elt.onblur =
			function(e){
				Element.hide(eltNotify);
				return true;
			}

		var z = Position.cumulativeOffset(elt);
		var x = z[0];
		var y = z[1];

		Element.show(eltNotify);

		if(navigator.appName == 'Microsoft Internet Explorer'){
			if(x < 100){
				eltNotify.style.left = (x + (elt.offsetWidth - 23)) + 'px';
			}
			else{
				eltNotify.style.left = (x - (eltNotify.offsetWidth + 2)) + 'px';
			}
		}
		else{
			if(x < 100){
				eltNotify.style.left = (x + (elt.offsetWidth + 3)) + 'px';
			}
			else{
				eltNotify.style.left = (x - (eltNotify.offsetWidth + 2)) + 'px';
			}
		}

		eltNotify.style.top = y + 'px';

		var xEffect = Effect.Fade(eltNotify, { fps: 75, from: 1.9, to: 0.0, duration: 1.0, queue: 'front' } );
		window.status = 'Copied text to clipboard';

		// Copy the text inside the text box to the user's clipboard
		var flashcopier = 'flashcopier';
		if(!$(flashcopier)){
			var divholder = document.createElement('div');
			divholder.id = flashcopier;
			document.body.appendChild(divholder);
		}

		$(flashcopier).innerHTML = '';
		var divinfo = '<embed src="' + urlSwf + '" FlashVars="clipboard='+escape(elt.value)+'" width="0" height="0" type="application/x-shockwave-flash"></embed>';
		$(flashcopier).innerHTML = divinfo;

		elt.select();

		return true;
	}

