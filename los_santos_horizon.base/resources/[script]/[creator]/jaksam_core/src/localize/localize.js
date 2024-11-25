
function openTranslationsMenu() {
    const div = $(`
    <div id="jaksam-core-translations" class="container-lg bg-dark text-white position-absolute top-50 start-50 translate-middle rounded"">
        <div id="main-bar" class="d-inline-block col-12 text-center mt-2">
            <p class="d-inline fw-bold fs-1">jaksam's core - Translations</p>
            
            <button id="close-main-btn" type="button" class="btn-close btn-close-white float-end mt-2"></button>
        </div>
    </div>
    `);

    $('body').append(div);
} openTranslationsMenu()