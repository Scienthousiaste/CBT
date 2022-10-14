
import {select} from "../utils/lib"

document.addEventListener("DOMContentLoaded", () => {
    select(".new-form-page .remove-button").on("click", e => {
        e.target.parentElement.remove();
    })
});