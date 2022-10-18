
import {select} from "../utils/lib"

document.addEventListener("DOMContentLoaded", () => {
    select(".new-form-page .remove-button").on("click", e => {
        e.target.parentElement.remove();
    })

    select(".new-form-page .add-choice-button").on("click", e => {
        e.preventDefault();
        const userChoice = document.createElement("div");
        userChoice.setAttribute("class", "user-choice");

        const input = document.createElement("input");
        input.setAttribute("type", "text");

        const removeButton = document.createElement("button");
        const text = document.createTextNode("-");
        removeButton.appendChild(text);
        removeButton.setAttribute("class", "button remove-button");

        removeButton.addEventListener("click", e => {
            e.target.parentElement.remove();
        });

        userChoice.appendChild(input);
        userChoice.appendChild(removeButton);
       
        const add_choice_button = select(".add-choice-button")[0]
        e.target.parentElement.insertBefore(userChoice, add_choice_button);
    })

    select(".new-form-page .add-question-button").on("click", e => {
    })
});