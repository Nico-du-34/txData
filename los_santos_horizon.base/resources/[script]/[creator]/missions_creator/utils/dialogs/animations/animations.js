const DEFAULT_PLANT_INTERACTION_ANIM_DATA = {
	type: "scenario",
	scenarioName: "PROP_HUMAN_BUM_BIN",
	duration: 5
}

function addAnimation(div, animData) {
	const index = div.children().length;
	
	let animDiv = $(`
		<div class="animation">
			<div class="text-center fs-5 mb-3 animation-type-div">
				<div class="form-check form-check-inline">
					<input class="form-check-input animation-type-radio" type="radio" name="animation-type-${index}" value="animation" checked>
					<label class="form-check-label">${getLocalizedText("menu:animation")}</label>
				</div>
				<div class="form-check form-check-inline">
					<input class="form-check-input animation-type-radio" type="radio" name="animation-type-${index}" value="scenario">
					<label class="form-check-label">${getLocalizedText("menu:scenario")}</label>
				</div>
				<!--
                <div class="form-check form-check-inline">
                    <input class="form-check-input animation-type-radio" type="radio" name="animation-type-${index}" value="special">
                    <label class="form-check-label">${getLocalizedText("menu:special")}</label>
                </div>
                -->
			</div>

			<div class="animation-div text-center">
				<a class="fst-italic clickable" target="_blank"  onclick='window.invokeNative("openUrl", "https://en.los-santos-multiplayer.com/dev.airdancer?cxt=anim")'>${getLocalizedText("menu:animations_list")}</a>
				
				<div class="input-group my-1">
					<span class="input-group-text">${getLocalizedText("menu:animation_dictionary")}</span>
					<input type="text" class="form-control animation-dictionary" placeholder="amb@world_human_gardener_plant@male@base" required>
				</div>
				<div class="input-group my-1">
					<span class="input-group-text">${getLocalizedText("menu:animation_name")}</span>
					<input type="text" class="form-control animation-name" placeholder="base" required>
				</div>
				<div class="input-group my-1">
					<span class="input-group-text">${getLocalizedText("menu:duration")}</span>
					<input type="number" step="0.1" class="form-control animation-duration" placeholder="${getLocalizedText("menu:seconds")}" required>
				</div>
			</div>

			<div class="scenario-div text-center" style="display:none">
				<a class="fst-italic clickable" target="_blank"  onclick='window.invokeNative("openUrl", "https://wiki.rage.mp/index.php?title=Scenarios")'>${getLocalizedText("menu:scenarios_list")}</a>
				
				<div class="input-group my-1">
					<span class="input-group-text">${getLocalizedText("menu:scenario_name")}</span>
					<input type="text" class="form-control scenario-name" placeholder="WORLD_HUMAN_GARDENER_PLANT">
				</div>
				<div class="input-group my-1">
					<span class="input-group-text">${getLocalizedText("menu:duration")}</span>
					<input type="number" step="0.1" class="form-control scenario-duration" placeholder="${getLocalizedText("menu:seconds")}">
				</div>
			</div>

			<div class="special-div text-center mx-1" style="display:none">			
				<select class="form-select special-animation">
				</select>

				<div class="input-group my-1">
					<span class="input-group-text">${getLocalizedText("menu:duration")}</span>
					<input type="number" step="0.1" class="form-control special-duration" placeholder="${getLocalizedText("menu:seconds")}">
				</div>
			</div>

			<div class="d-inline-block col-12 mt-1">
				<button type="button" class="btn btn-danger rounded btn-sm float-end remove-animation-btn">${getLocalizedText("menu:remove_animation")}</button>
			</div>

			<hr>
		</div>
	`);

	let animationTypeDiv = animDiv.find(".animation-type-div");

	animationTypeDiv.find(".animation-type-radio").change(function() {
		const newValue = $(this).val();

		if(newValue == "scenario") {
			animDiv.find(".animation-div").hide().find("input").prop("required", false);
			animDiv.find(".special-div").hide().find("input").prop("required", false);
			animDiv.find(".scenario-div").show().find("input").prop("required", true);
		} else if(newValue == "animation") {
			animDiv.find(".scenario-div").hide().find("input").prop("required", false);
			animDiv.find(".special-div").hide().find("input").prop("required", false);
			animDiv.find(".animation-div").show().find("input").prop("required", true);
		} else if(newValue == "special") {
			animDiv.find(".scenario-div").hide().find("input").prop("required", false);
			animDiv.find(".animation-div").hide().find("input").prop("required", false);
			animDiv.find(".special-div").show().find("input").prop("required", true);
		}
	});

	animDiv.find(".remove-animation-btn").click(function() {
		animDiv.remove();
	});

	if(animData) {
		animationTypeDiv.find(`.animation-type-radio[value="${animData.type}"]`).prop("checked", true).change();

		if(animData.type == "scenario") {
			animDiv.find(".scenario-name").val(animData.scenarioName);
			animDiv.find(".scenario-duration").val(animData.duration);
		} else if(animData.type == "animation") {
			animDiv.find(".animation-dictionary").val(animData.animDict);
			animDiv.find(".animation-name").val(animData.animName);
			animDiv.find(".animation-duration").val(animData.duration);
		} else if(animData.type == "special") {
			animDiv.find(".special-animation").val(animData.specialAnimation);
			animDiv.find(".special-duration").val(animData.duration);
		}
	}

	div.append(animDiv);
}

function animationsDialog(oldAnimations) {
    let resolve = null;
    const promise = new Promise((res, rej) => { resolve = res; });

    const div = $(`
    <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1072;">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <form class="modal-content needs-validation" novalidate>
                <div class="modal-header">
                    <h5 class="modal-title">${getLocalizedText("menu:animations")}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">

                    <div style="max-height: 60vh; overflow-x:auto" class="pe-2 scrollbar animations-list">

                    </div>

                    <div class="btn-group mt-2">
                        <button type="button" class="btn btn-primary add-animation-btn">${getLocalizedText("menu:add_animation")}</button>
                        <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown"></button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item add-default-interaction-animation" href="#">${getLocalizedText("menu:default_interaction")}</a></li>
                        </ul>
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

    const animationsList = div.find(".animations-list");

    // delete the div when the modal is closed
    div.on("hidden.bs.modal", function() {
        div.remove();
    });

    div.find(".add-animation-btn").click(function() {
        addAnimation(animationsList);
    });

	div.find(".add-default-interaction-animation").click(function() {
		addAnimation(animationsList, DEFAULT_PLANT_INTERACTION_ANIM_DATA);
	});

    if(oldAnimations) {
        oldAnimations.forEach((animData) => {
            addAnimation(animationsList, animData);
        });
    }

    div.modal("show");

    div.find("form").submit(function(event) {
        if(isThereAnyErrorInForm(event)) return;

        const animationsList = [];
        let isThereAnyAnimation = false;

        div.find(".animations-list").find(".animation").each(function() {
            isThereAnyAnimation = true;

            const animationType = $(this).find(".animation-type-radio:checked").val();

            if(animationType == "animation") {
                const animDict = $(this).find(".animation-dictionary").val();
                const animName = $(this).find(".animation-name").val();
                const duration = parseFloat( $(this).find(".animation-duration").val() );

                animationsList.push({
                    type: "animation",
                    animDict: animDict,
                    animName: animName,
                    duration: duration
                });
            } else if(animationType == "scenario") {
                const scenarioName = $(this).find(".scenario-name").val();
                const duration = parseFloat( $(this).find(".scenario-duration").val() );

                animationsList.push({
                    type: "scenario",
                    scenarioName: scenarioName,
                    duration: duration
                });
            } else if(animationType == "special") {
                const specialAnimation = $(this).find(".special-animation").val();
                const duration = parseFloat( $(this).find(".special-duration").val() );

                animationsList.push({
                    type: "special",
                    specialAnimation: specialAnimation,
                    duration: duration
                });
            }
        });

        div.modal("hide");

        resolve(isThereAnyAnimation ? animationsList : null);
    })

    return promise;
}

function getDefaultAnimationsData() {
	return [DEFAULT_PLANT_INTERACTION_ANIM_DATA];
}