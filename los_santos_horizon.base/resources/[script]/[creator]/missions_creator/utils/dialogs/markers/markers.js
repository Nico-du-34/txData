function getDefaultMarkerCustomization() {
	return {
		type: 1,
		scale: {
			x: 2,
			y: 2,
			z: 0.2
		},
		color: {
			red: 0,
			green: 255,
			blue: 0,
			opacity: 200
		},
		rotation: {
			x: 0.0,
			y: 0.0,
			z: 0.0
		},
		followCamera: false,
		bounce: false,
		rotate: false
	}
}

async function markerDialog(currentMarkerData) {
	return new Promise((resolve, reject) => {
		let div = $(`
        <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070; background: rgba(25, 25, 25, 0.7);">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form class="modal-content needs-validation" novalidate>
                    <div class="modal-header">
                        <h5 class="modal-title">${getLocalizedText("menu:marker_customization")}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-center">
                        <div class="form-check form-check-inline fs-4 mb-3">
                            <input class="form-check-input marker-enabled" type="checkbox" value="">
                            <label class="form-check-label">${getLocalizedText("menu:marker_enabled")}</label>
                        </div>


                        <div class="form-floating text-body">
                            <input type="number" class="form-control marker-type" placeholder="${getLocalizedText("menu:marker_type")}" required>
                            <label>${getLocalizedText("menu:marker_type")}</label>
                        </div>

                        <a class="fst-italic" href="https://docs.fivem.net/docs/game-references/markers/" target="_blank"  onclick='window.invokeNative("openUrl", "https://docs.fivem.net/docs/game-references/markers/")'>https://docs.fivem.net/docs/game-references/markers/</a>

                        <div class="mt-3">
                            <p class="fs-4">${getLocalizedText("menu:marker_size")}</p>

                            <div class="row g-2 row-cols-auto align-items-center">
                                <div class="form-floating text-body col-4">
                                    <input type="number" min="0.1" step="0.1" class="form-control marker-size-x" placeholder="${getLocalizedText("menu:x")}" required>
                                    <label>${getLocalizedText("menu:x")}</label>
                                </div>

                                <div class="form-floating text-body col-4">
                                    <input type="number" min="0.1" step="0.1" class="form-control marker-size-y" placeholder="${getLocalizedText("menu:y")}" required>
                                    <label>${getLocalizedText("menu:y")}</label>
                                </div>

                                <div class="form-floating text-body col-4">
                                    <input type="number" min="0.1" step="0.1" class="form-control marker-size-z" placeholder="${getLocalizedText("menu:z")}" required>
                                    <label>${getLocalizedText("menu:z")}</label>
                                </div>
                            </div>
                        </div>

                        <div class="mt-3">
                            <p class="fs-4">${getLocalizedText("menu:marker_rotation")}</p>

                            <div class="row g-2 row-cols-auto align-items-center">
                                <div class="form-floating text-body col-4">
                                    <input type="number" step="0.1" class="form-control marker-rotation-x" placeholder="${getLocalizedText("menu:x")}" required>
                                    <label>${getLocalizedText("menu:x")}</label>
                                </div>

                                <div class="form-floating text-body col-4">
                                    <input type="number" step="0.1" class="form-control marker-rotation-y" placeholder="${getLocalizedText("menu:y")}" required>
                                    <label>${getLocalizedText("menu:y")}</label>
                                </div>

                                <div class="form-floating text-body col-4">
                                    <input type="number" step="0.1" class="form-control marker-rotation-z" placeholder="${getLocalizedText("menu:z")}" required>
                                    <label>${getLocalizedText("menu:z")}</label>
                                </div>		
                            </div>
                        </div>

                        <div class="mt-3">
                            <p class="fs-4">${getLocalizedText("menu:marker_color")}</p>

                            <div class="row g-2 row-cols-auto align-items-center">
                                <div class="form-floating text-body col-3">
                                    <input type="number" min="0" max="255" class="form-control marker-color-red" placeholder="0-255" required>
                                    <label>${getLocalizedText("menu:red")}</label>
                                </div>

                                <div class="form-floating text-body col-3">
                                    <input type="number" min="0" max="255" class="form-control marker-color-green" placeholder="0-255" required>
                                    <label>${getLocalizedText("menu:green")}</label>
                                </div>

                                <div class="form-floating text-body col-3">
                                    <input type="number" min="0" max="255" class="form-control marker-color-blue" placeholder="0-255" required>
                                    <label>${getLocalizedText("menu:blue")}</label>
                                </div>

                                <div class="form-floating text-body col-3">
                                    <input type="number" min="0" max="255" class="form-control marker-color-opacity" placeholder="0-255" required>
                                    <label>${getLocalizedText("menu:opacity")}</label>
                                </div>		
                            </div>
                        </div>

                        <div class="mt-3">
                            <p class="fs-4">${getLocalizedText("menu:other")}</p>

                            <div class="fs-5">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input marker-bounce" type="checkbox">
                                    <label class="form-check-label">${getLocalizedText("menu:bounce")}</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input marker-follow-camera" type="checkbox">
                                    <label class="form-check-label">${getLocalizedText("menu:follow_camera")}</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input marker-rotate" type="checkbox">
                                    <label class="form-check-label">${getLocalizedText("menu:rotate")}</label>
                                </div>
                            </div>
                        </div>

                        <div class="mt-3">
                            <p class="fs-4">${getLocalizedText("menu:marker_texture")}</p>

                            <div class="row g-2 row-cols-auto align-items-center">
                                <div class="form-floating text-body col-6">
                                    <input type="text" class="form-control marker-texture-dict" placeholder="Texture">
                                    <label>${getLocalizedText("menu:texture_dict")}</label>
                                </div>

                                <div class="form-floating text-body col-6">
                                    <input type="text" class="form-control marker-texture-name" placeholder="Texture">
                                    <label>${getLocalizedText("menu:texture_name")}</label>
                                </div>	
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">${getLocalizedText("menu:close")}</button>
                        <button type="submit" class="btn btn-success">${getLocalizedText("menu:confirm")}</button>
                    </div>    
                </form>
            </div>
        </div>
        `);

        // delete the div when the modal is closed
        div.on("hidden.bs.modal", function() {
            div.remove();
        });

		if(!currentMarkerData) {
			currentMarkerData = getDefaultMarkerCustomization()
		}

        div.find(".marker-enabled").change(function() {
            const enabled = $(this).prop("checked");
            div.find("input, select").not( $(this) ).prop("disabled", !enabled);
        });

        div.find(".marker-enabled").prop("checked", currentMarkerData.isEnabled).change();
		div.find(".marker-type").val(currentMarkerData.type);
		div.find(".marker-size-x").val(currentMarkerData.scale.x);
		div.find(".marker-size-y").val(currentMarkerData.scale.y);
		div.find(".marker-size-z").val(currentMarkerData.scale.z);
		div.find(".marker-color-red").val(currentMarkerData.color.red);
		div.find(".marker-color-green").val(currentMarkerData.color.green);
		div.find(".marker-color-blue").val(currentMarkerData.color.blue);
		div.find(".marker-color-opacity").val(currentMarkerData.color.opacity);
		div.find(".marker-rotation-x").val(currentMarkerData.rotation.x);
		div.find(".marker-rotation-y").val(currentMarkerData.rotation.y);
		div.find(".marker-rotation-z").val(currentMarkerData.rotation.z);
		div.find(".marker-follow-camera").prop("checked", currentMarkerData.followCamera);
		div.find(".marker-bounce").prop("checked", currentMarkerData.bounce);
		div.find(".marker-rotate").prop("checked", currentMarkerData.rotate);
        div.find(".marker-texture-dict").val(currentMarkerData.textureDict);
        div.find(".marker-texture-name").val(currentMarkerData.textureName);

		div.find("form").submit(function(event) {
            if(isThereAnyErrorInForm(event)) return;

			let markerData = {
                isEnabled: div.find(".marker-enabled").prop("checked"),
				type: parseInt( div.find(".marker-type").val() ),
				scale: {
					x: parseFloat( div.find(".marker-size-x").val() ),
					y: parseFloat( div.find(".marker-size-y").val() ),
					z: parseFloat( div.find(".marker-size-z").val() )
				},
				color: {
					red: parseInt( div.find(".marker-color-red").val() ),
					green: parseInt( div.find(".marker-color-green").val() ),
					blue: parseInt( div.find(".marker-color-blue").val() ),
					opacity: parseInt( div.find(".marker-color-opacity").val() )
				},
				rotation: {
					x: parseFloat( div.find(".marker-rotation-x").val() ),
					y: parseFloat( div.find(".marker-rotation-y").val() ),
					z: parseFloat( div.find(".marker-rotation-z").val() )
				},
				followCamera: div.find(".marker-follow-camera").prop("checked"),
				bounce: div.find(".marker-bounce").prop("checked"),
				rotate: div.find(".marker-rotate").prop("checked"),
                textureDict: div.find(".marker-texture-dict").val() || null,
                textureName: div.find(".marker-texture-name").val() || null,
			}

			div.modal("hide");

			resolve(markerData);
		})

		div.modal("show");
	});
}