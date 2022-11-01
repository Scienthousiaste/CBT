
import { select } from "../utils/lib"

document.addEventListener("DOMContentLoaded", () => {
    select(".new-form-page select").on("change", onSelectChange);
    select(".new-form-page .remove-choice-button").on("click", onClickRemoveChoice);
    select(".new-form-page .add-choice-button").on("click", onClickAddChoice);
    select(".new-form-page .add-question-button").on("click", onClickAddQuestion);
    select(".new-form-page .delete-question-button").on("click", onDeleteQuestion);
});

function onDeleteQuestion(e) {
    e.preventDefault();
    e.target.closest(".question").remove();
}

function makeNewUserChoice() {
    const userChoice = document.createElement("div");
    userChoice.setAttribute("class", "user-choice");

    const input = document.createElement("input");
    input.setAttribute("type", "text");

    const removeButton = document.createElement("button");
    const text = document.createTextNode("-");
    removeButton.appendChild(text);
    removeButton.setAttribute("class", "button remove-choice-button");

    removeButton.addEventListener("click", e => {
        e.target.parentElement.remove();
    });

    userChoice.appendChild(input);
    userChoice.appendChild(removeButton);
    return userChoice;
}

function makeNewQuestion() {
    const question = document.createElement("div");
    question.setAttribute("class", "question");
    question.appendChild(makeQuestionHeader());
    question.appendChild(makeTextQuestionInput());
    question.appendChild(makeTypeAnswerSelector());

    return question;
}

function makeQuestionHeader() {
    const questionHeader = document.createElement("div");
    questionHeader.setAttribute("class", "question-header");
    const text = document.createTextNode("Question");
    questionHeader.appendChild(text);

    const deleteButton = document.createElement("button");
    deleteButton.setAttribute("class", "button delete-question-button");
    const textButton = document.createTextNode("Delete Question");
    deleteButton.appendChild(textButton);
    deleteButton.addEventListener("click", onDeleteQuestion);

    questionHeader.appendChild(deleteButton);
    return questionHeader;
}

function makeTypeAnswerSelector() {
    const container = document.createElement("div");
    const span = document.createElement("span");
    const textSpan = document.createTextNode("Type answer: ");
    span.appendChild(textSpan);
    container.appendChild(span);

    const selectElement = document.createElement("select");

    const types = {
        "unique_choice": "Single choice",
        "multiple_choice": "Multiple choice",
        "number": "Number",
        "boolean": "True/False",
        "text": "Text",
        "integer": "Integer",
    }

    for (t in types) {
        const optionElement = document.createElement("option");
        optionElement.setAttribute("value", t);
        const textOption = document.createTextNode(types[t]);
        optionElement.appendChild(textOption);
        if (t == "text") {
            optionElement.setAttribute("selected", "selected");
        }
        selectElement.appendChild(optionElement);
    }
    selectElement.addEventListener("change", onSelectChange);
    container.appendChild(selectElement);
    return container;
}

function makeTextQuestionInput() {
    const container = document.createElement("div");
    const questionTextSpan = document.createElement("span");
    const textNode = document.createTextNode("Text question: ");
    questionTextSpan.appendChild(textNode);

    const inputElement = document.createElement("input");
    inputElement.setAttribute("type", "text");

    container.appendChild(questionTextSpan);
    container.appendChild(inputElement);
    return container;
}

function makeAddUserChoiceButton() {
    const button = document.createElement("button");
    button.setAttribute("class", "button add-choice-button");
    const textNode = document.createTextNode("Add choice +");
    button.appendChild(textNode);
    button.addEventListener("click", onClickAddChoice);
    return button;
}

function onSelectChange(e) {
    const selectElement = e.target;
    const question = selectElement.closest(".question");

    if (["unique_choice", "multiple_choice"].includes(selectElement.value)) {
        addChoicesAndChoiceButtonIfNone(question);
    }
    else {
        removeChoicesAndAddChoiceButton(question);
    }
}

function removeChoicesAndAddChoiceButton(question) {
    const toRemove = [];
    for (const child of question.children) {
        if (child.classList.contains("user-choice") || child.classList.contains("add-choice-button")) {
            toRemove.push(child);
        }
    }

    toRemove.forEach(tr => tr.remove());
}

function addChoicesAndChoiceButtonIfNone(question) {
    if (noChoiceNorAddChoiceButtonPresent(question.children)) {
        question.appendChild(makeNewUserChoice());
        question.appendChild(makeNewUserChoice());
        question.appendChild(makeAddUserChoiceButton());
    }
}

function noChoiceNorAddChoiceButtonPresent(elements) {
    for (let i = 0; i < elements.length; i++) {
        if (elements[i].classList.contains("user-choice") || elements[i].classList.contains("add-choice-button")) {
            return false;
        }
    }
    return true;
}

function onClickAddChoice(e) {
    e.preventDefault();
    e.target.parentElement.insertBefore(
        makeNewUserChoice(),
        e.target
    );
}

function onClickAddQuestion(e) {
    e.preventDefault();
    e.target.parentElement.insertBefore(
        makeNewQuestion(),
        e.target
    );
}

function onClickRemoveChoice(e) {
    e.target.parentElement.remove();
}