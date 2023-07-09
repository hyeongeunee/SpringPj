<%--
  Created by IntelliJ IDEA.
  User: hyeongeun
  Date: 2023-07-06
  Time: 오후 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>inputText</title>
    <style>
        @import url("https://fonts.googleapis.com/css?family=Oswald");

        body {
            font-size: 10px;
            font-family: "Oswald", sans-serif;
            margin: 0;
            display: grid;
            height: 100vh;
            place-items: center;
        }

        .c-checkbox {
            display: none;
        }

        .c-checkbox:checked + .c-formContainer .c-form {
            width: 37.5em;
        }

        .c-checkbox:checked + .c-formContainer .c-form__toggle {
            visibility: hidden;
            opacity: 0;
            transform: scale(0.7);
        }

        .c-checkbox:checked + .c-formContainer .c-form__input,
        .c-checkbox:checked + .c-formContainer .c-form__buttonLabel {
            transition: 0.2s 0.1s;
            visibility: visible;
            opacity: 1;
            transform: scale(1);
        }

        .c-checkbox:not(:checked) + .c-formContainer .c-form__input:required:valid ~ .c-form__toggle::before, .c-checkbox:checked + .c-formContainer .c-form__input:required:valid ~ .c-form__toggle::before {
            content: "Thank You! 😊";
        }

        .c-checkbox:not(:checked) + .c-formContainer .c-form__input:required:valid ~ .c-form__toggle {
            pointer-events: none;
            cursor: default;
        }

        .c-formContainer,
        .c-form,
        .c-form__toggle {
            width: 20em;
            height: 6.25em;
        }

        .c-formContainer {
            position: relative;
            font-weight: 700;
        }

        .c-form,
        .c-form__toggle {
            position: absolute;
            border-radius: 6.25em;
            background-color: #ffffff;
            transition: 0.2s;
        }

        .c-form {
            left: 50%;
            transform: translateX(-50%);
            padding: 0.625em;
            box-sizing: border-box;
            box-shadow: 0 0.125em 0.3125em rgba(0, 0, 0, 0.3);
            display: flex;
            justify-content: center;
        }

        .c-form__toggle {
            color: #ff7b73;
            top: 0;
            cursor: pointer;
            z-index: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .c-form__toggle::before {
            font-size: 1.75em;
            content: attr(data-title);
        }

        .c-form__input,
        .c-form__button {
            font: inherit;
            border: 0;
            outline: 0;
            border-radius: 5em;
            box-sizing: border-box;
        }

        .c-form__input,
        .c-form__buttonLabel {
            font-size: 2em;
            opacity: 0;
            visibility: hidden;
            transform: scale(0.7);
            transition: 0s;
        }

        .c-form__input {
            color: #ffcccc;
            height: 100%;
            width: 100%;
            padding: 0 0.714em;
        }

        .c-form__input::placeholder {
            color: currentColor;
            text-align: center;
        }

        .c-form__input:required:valid {
            color: #ff7b73;
        }

        .c-form__input:required:valid + .c-form__buttonLabel {
            color: #ffffff;
        }

        .c-form__input:required:valid + .c-form__buttonLabel::before {
            pointer-events: initial;
        }

        .c-form__buttonLabel {
            color: #ffaea9;
            height: 100%;
            width: auto;
        }

        .c-form__buttonLabel::before {
            content: "";
            position: absolute;
            width: 100%;
            height: 100%;
            pointer-events: none;
            cursor: pointer;
        }

        .c-form__button {
            color: inherit;
            padding: 0;
            height: 100%;
            width: 5em;
            background-color: #ff7b73;
        }
    </style>
</head>
<body>
<input class="c-checkbox" type="checkbox" id="checkbox">
<div class="c-formContainer">
    <form class="c-form" action="">
        <input class="c-form__input" placeholder="Keyword" type="search" style="text-align: center">
        <label class="c-form__buttonLabel" for="checkbox">
            <button class="c-form__button" type="button">Submit</button>
        </label>
        <label class="c-form__toggle" for="checkbox" data-title="Search"></label>
    </form>
</div>
</body>
</html>
