function societiesDialog(oldSocieties) {
	return new Promise((resolve, reject) => {
		let div = $(`
        <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070;">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form class="modal-content needs-validation" novalidate>
                    <div class="modal-header">
                        <h5 class="modal-title">${getLocalizedText("menu:societies_dialog:title")}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="input-group">
                            <span class="input-group-text">${getLocalizedText("menu:societies_dialog:search_society")}</span>
                            <input type="text" class="form-control input-society-search">
                        </div>

                        <div class="mt-2 societies-list scrollbar" style="max-height: 60vh; overflow-y: auto">

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">${getLocalizedText("menu:close")}</button>
                        <button type="submit" class="btn btn-success">${getLocalizedText("menu:confirm")}</button>
                    </div>    
                </form>
            </div>
        </div>
        `)

        // delete the div when the modal is closed
        div.on("hidden.bs.modal", function() {
            div.remove();
        });

        div.modal("show");
	
		div.find(".input-society-search").val("").on("keyup", function() {
            let text = $(this).val().toLowerCase();
        
            div.find(".societies-list .society-container-div").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(text) > -1)
            });
        });

		$.post(`https://${resName}/getAllJobs`, JSON.stringify({}), function (jobs) {
			let societiesListDiv = div.find(".societies-list");
	
			societiesListDiv.empty();
	
			for(const[jobName, jobData] of Object.entries(jobs)) {
				let jobDiv = $(`
					<div class="society-container-div">
						<div class="d-flex mx-1 mb-2 society">
							<div class="form-check fs-3 my-auto ms-2" style="width: auto">
								<input class="form-check-input society-checkbox" type="checkbox" data-job-name="${jobName}">

								<p class="mb-0">${jobData.label}</p>
							</div>

							<div class="col-5 ms-auto">
								<div class="input-group">
									<span class="input-group-text">${getLocalizedText("menu:percentage")}</span>
									<input type="number" class="form-control percentage" placeholder="%" disabled>
								</div>
							</div>
						</div>
					</div>
				`);
	
				$(jobDiv).find(".society-checkbox").change(function() {
					let isEnabled = $(this).prop("checked");

					$(this).closest(".society").find(".percentage").prop("disabled", !isEnabled).prop("required", isEnabled);
				});
				
				societiesListDiv.append(jobDiv);
			}

			if(oldSocieties) {
				for(let [jobName, percentage] of Object.entries(oldSocieties)) {
					div.find(".societies-list")
						.find(`[data-job-name="${jobName}"]`).prop("checked", true).change()
						.closest(".society").find(".percentage").val(percentage);
				}
			}

			// Unbinds the button and rebinds it to callback the selected jobs
			div.find("form").submit(function(event) {
                if(isThereAnyErrorInForm(event)) return;

				let selectedSocieties = {};
	
				let isThereAnySociety = false;

				societiesListDiv.find("input:checked").each(function() {
					isThereAnySociety = true;
	
					let percentageDiv = $(this).closest(".society").find(".percentage");

					let jobName = $(this).data("jobName");
					let percentage = parseInt( percentageDiv.val() );

					selectedSocieties[jobName] = percentage;
				});
	
				div.modal("hide");
		
				resolve(isThereAnySociety ? selectedSocieties : false);
			});
		});
	})
}