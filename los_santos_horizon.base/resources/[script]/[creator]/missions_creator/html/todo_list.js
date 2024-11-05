function createTimer(durationInMinutes, displayDiv) {
	if (durationInMinutes <= 0) return;

    const currentStageIndex = $("#todo-list").data("stageIndex");

	let timer = durationInMinutes * 60;
	const interval = setInterval(() => {
        const newStageIndex = $("#todo-list").data("stageIndex");
        const isHidden = $("#todo-list").is(":hidden");

		if (timer < 0 || newStageIndex !== currentStageIndex || isHidden) {
			clearInterval(interval);
			return;
		}

		const minutes = String(Math.floor(timer / 60)).padStart(2, '0');
		const seconds = String(timer % 60).padStart(2, '0');
		displayDiv.text(`${minutes}:${seconds}`);

		timer--;
	}, 1000);
}


function setupToDoList(stageIndex, label, description, maxMinutesDuration) {
    $("#todo-list").data("stageIndex", stageIndex);
    $("#tasks-list-todo").empty();
    $("#tasks-list-completed").empty();

    $("#todo-stage-label").text(label);
    $("#todo-stage-description").text(description);

    
    createTimer(maxMinutesDuration, $("#todo-stage-timer"));

    $("#todo-list").show();
}

function updateToDoList(elements) {
    const tasksListDiv = $("#tasks-list-todo");
    tasksListDiv.empty();
    const completedTasksListDiv = $("#tasks-list-completed");
    completedTasksListDiv.empty();

    elements.forEach(element => {
        const description = element.description ? `: ${element.description}` : "";
        const div = $(`<p class="my-2" data-task-index="${element.index}">${element.label}${description}</p>`);

        div.fadeOut(250, () => {
            element.isCompleted ? completedTasksListDiv.append(div) : tasksListDiv.append(div);

            div.css("color", element.isCompleted ? "darkgray" : "white");
            
            div.fadeIn(250);
        });
    });
}


// Messages received by client
window.addEventListener('message', (event) => {
	let data = event.data;
	let action = data.action;

	switch(action) {
		case "setupToDoList": {
			setupToDoList(data.stageIndex, data.label, data.description, data.maxMinutesDuration);

			break;
		}

        case "updateToDoList": {
            updateToDoList(data.elements);

            break;
        }

        case "hideToDoList": {
            $("#todo-list").hide();

            break;
        }
	}
})